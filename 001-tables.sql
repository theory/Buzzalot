SET client_min_messages = warning;
\set ON_ERROR_ROLLBACK 1
\set ON_ERROR_STOP 1

BEGIN;

CREATE TABLE users (
    token TEXT   PRIMARY KEY,
    name  TEXT   NOT NULL DEFAULT ''
);

CREATE OR REPLACE FUNCTION random_string(
    len INT = 8
) RETURNS TEXT LANGUAGE 'plpgsql' AS $$
DECLARE
    chars TEXT = '0123456789'
              || 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'
              || 'abcdefghijklmnopqrstuvwxyz'
              || '~!@#$%^&*()_+[]{}\|''";:,.<>/?';
    ret TEXT = '';
    i   INT;
    pos INT;
BEGIN
    FOR i IN 1..len LOOP
        pos := 1 + cast( random() * ( length(chars) - 1) AS INT );
        ret := ret || substr(chars, pos, 1);
    END LOOP;
    RETURN ret;
END;
$$;

-- XXX Validate email addresses.
CREATE TABLE addresses (
    address    CITEXT PRIMARY KEY,
    token      TEXT   NOT NULL REFERENCES users(token),
    is_primary BOOL   NOT NULL DEFAULT TRUE,
    code       TEXT   NOT NULL DEFAULT random_string()
);

CREATE UNIQUE INDEX primary_email ON addresses(token) WHERE is_primary;

CREATE OR REPLACE FUNCTION primary_email_required (
) RETURNS TRIGGER LANGUAGE PLPGSQL AS $$
BEGIN
    IF NOT EXISTS (
        SELECT is_primary
          FROM addresses
         WHERE token = NEW.token
           AND is_primary
    ) THEN
        RAISE EXCEPTION 'User must have a primary email address';
    END IF;
    RETURN NEW;
END;
$$;

CREATE TRIGGER primary_email_required AFTER INSERT OR UPDATE OR DELETE ON addresses
    FOR EACH ROW EXECUTE PROCEDURE primary_email_required();

CREATE OR REPLACE FUNCTION add_user(
    token  TEXT,
    name   TEXT,
    email  TEXT
) RETURNS VOID LANGUAGE SQL AS $$
    INSERT INTO users (token, name) VALUES ($1, $2);
    INSERT INTO addresses (address, token) VALUES ($3, $1);
$$;

CREATE OR REPLACE FUNCTION verify_email (
    email TEXT,
    vcode TEXT
) RETURNS BOOL LANGUAGE PLPGSQL AS $$
BEGIN
    UPDATE addresses
       SET code = ''
     WHERE address = $1
       AND code    = $2;
    RETURN FOUND;
END;
$$;

CREATE OR REPLACE FUNCTION add_email(
    token TEXT,
    email VARIADIC TEXT[]
) RETURNS VOID LANGUAGE SQL AS $$
    INSERT INTO addresses (token, address, is_primary)
    SELECT $1, $2[i], false
      FROM generate_series(1, array_upper($2, 1)) s(i)
$$;

CREATE TABLE messages (
    message_id  BIGSERIAL PRIMARY KEY,
    token       TEXT        NOT NULL REFERENCES users(token),
    recip       CITEXT      NOT NULL REFERENCES addresses(address),
    body        TEXT        NOT NULL,
    user_sent   BOOLEAN     NOT NULL,
    sent_at     TIMESTAMPTZ NOT NULL DEFAULT now()
);

CREATE OR REPLACE FUNCTION token_for(
    email CITEXT
) RETURNS TEXT LANGUAGE SQL STABLE AS $$
    SELECT token FROM addresses WHERE address = $1 AND code = '';
$$;

CREATE OR REPLACE FUNCTION email_for(
    token TEXT
) RETURNS TEXT LANGUAGE SQL STABLE AS $$
    SELECT address FROM addresses WHERE token = $1 AND is_primary;
$$;

CREATE OR REPLACE FUNCTION send_message(
    token  TEXT,
    recip  CITEXT,
    msg    TEXT
) RETURNS VOID LANGUAGE SQL AS $$
    INSERT INTO messages (token, recip, body, user_sent)
    VALUES ($1, $2, $3, true), (token_for($2), email_for($1), $3, false)
$$;

CREATE OR REPLACE FUNCTION delete_messages(
    token TEXT,
    ids   VARIADIC BIGINT[]
) RETURNS VOID LANGUAGE SQL AS $$
    DELETE FROM messages
     WHERE token = $1
       AND message_id = ANY($2)
$$;
 
CREATE OR REPLACE VIEW conversations AS
SELECT m.token   AS token,
       CASE WHEN user_sent THEN u.name ELSE v.name END AS sender,
       CASE when user_sent THEN v.name ELSE u.name END AS receiver,
       m.sent_at AS sent_at,
       m.body    AS body
  FROM messages m
  JOIN users u     ON (m.token = u.token)
  JOIN addresses a ON (m.recip = a.address)
  JOIN users v     ON (a.token = v.token);

CREATE OR REPLACE VIEW recipients AS
SELECT token, 
       CASE WHEN user_sent THEN uname ELSE recip END AS sender,
       CASE when user_sent THEN recip ELSE uname END AS receiver,
       sent_at,
       body,
       rnum
FROM (
SELECT m.token   AS token,
       u.name    AS uname,
       v.name    AS recip,
       m.user_sent AS user_sent,
       m.sent_at AS sent_at,
       m.body    AS body,
       row_number() OVER (PARTITION BY m.token, m.recip ORDER BY m.sent_at DESC) AS rnum
  FROM messages m
  JOIN users u     ON (m.token = u.token)
  JOIN addresses a ON (m.recip = a.address)
  JOIN users v     ON (a.token = v.token)
) AS msgs
WHERE msgs.rnum = 1;

--ROLLBACK;
COMMIT;
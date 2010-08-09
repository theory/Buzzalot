PRAGMA foreign_keys = ON; -- Future-proof.

BEGIN;

CREATE TABLE messages (
    message_id  TEXT COLLATE nocase PRIMARY KEY,
    email       TEXT COLLATE nocase NOT NULL REFERENCES correspondents(email) ON UPDATE CASCADE ON DELETE CASCADE,
    body        TEXT                NOT NULL,
    from_me     BOOLEAN             NOT NULL,
    sent_at     TIMESTAMP           NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX idx_message_email ON messages(email);
CREATE INDEX idx_message_sent_at ON messages(sent_at);

/* Note: The following can be deleted once SQLite 3.6.19+ ships on the iPhone. */

-- Enforce the FK constraint on insert.
CREATE TRIGGER messages_email_ifkey
BEFORE INSERT ON messages
FOR EACH ROW BEGIN
    SELECT RAISE(ABORT, 'insert or update on table "messages" violates foreign key constraint "messages_email_fkey"')
     WHERE (SELECT 1 FROM correspondents WHERE email = NEW.email) IS NULL;
END;

-- Enforce the FK constraint on update.
CREATE TRIGGER messages_email_ufkey
BEFORE UPDATE ON messages
FOR EACH ROW BEGIN
    SELECT RAISE(ABORT, 'insert or update on table "messages" violates foreign key constraint "messages_email_fkey"')
     WHERE (SELECT 1 FROM correspondents WHERE email = NEW.email) IS NULL;
END;

-- Cascade updates from correspondents.
CREATE TRIGGER correspondents_email_upkey
AFTER UPDATE ON correspondents
FOR EACH ROW BEGIN
  UPDATE messages SET email = NEW.email WHERE email = OLD.email;
END;

-- Cascade deletes from correspondents.
CREATE TRIGGER correspondents_email_dpkey
AFTER DELETE ON correspondents
FOR EACH ROW BEGIN
  DELETE from messages WHERE email = OLD.email;
END;

COMMIT;

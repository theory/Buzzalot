PRAGMA foreign_keys = ON; -- Future-proof.

CREATE TABLE correspondents (
    email TEXT COLLATE nocase NOT NULL PRIMARY KEY,
    name  TEXT                NOT NULL
);

CREATE INDEX idx_correspondent_name ON correspondents(name);

CREATE TABLE messages (
    message_id  TEXT COLLATE nocase PRIMARY KEY,
    email       TEXT COLLATE nocase NOT NULL REFERENCES correspondents(email) ON UPDATE CASCADE ON DELETE CASCADE,
    body        TEXT                NOT NULL,
    from_me     BOOLEAN             NOT NULL,
    sent_at     TIMESTAMP           NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX idx_message_email ON messages(email);
CREATE INDEX idx_message_sent_at ON messages(sent_at);

CREATE VIEW most_recent AS
SELECT c.email, c.name, COALESCE(m.from_me, 0) AS from_me, COALESCE(m.body, '') AS body, COALESCE(m.sent_at, '') AS sent_at
  FROM correspondents c
  LEFT JOIN messages m ON c.email = m.email
  LEFT JOIN messages m2 ON m.email = m2.email AND (
       m.sent_at < m2.sent_at
    OR (m.sent_at = m2.sent_at AND m.message_id < m2.message_id)
  )
 WHERE m2.email iS NULL;

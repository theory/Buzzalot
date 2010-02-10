PRAGMA foreign_keys = ON; -- Future-proof.

BEGIN;

CREATE TABLE correspondents (
    email TEXT COLLATE nocase NOT NULL PRIMARY KEY,
    name  TEXT                NOT NULL
);

CREATE INDEX idx_correspondent_name ON correspondents(name);

COMMIT;

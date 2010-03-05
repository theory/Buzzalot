PRAGMA foreign_keys = ON; -- Future-proof.

BEGIN;

CREATE TABLE addresses (
    email     TEXT COLLATE nocase NOT NULL PRIMARY KEY,
    confirmed BOOLEAN NOT NULL DEFAULT 0,
    position  INTEGER NOT NULL UNIQUE
);

COMMIT;

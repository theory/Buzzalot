BEGIN;

CREATE VIEW most_recent AS
SELECT c.email, c.name, COALESCE(m.from_me, 0) AS from_me, COALESCE(m.body, '') AS body, m.sent_at AS sent_at
  FROM correspondents c
  LEFT JOIN messages m ON c.email = m.email
  LEFT JOIN messages m2 ON m.email = m2.email AND (
       m.sent_at < m2.sent_at
    OR (m.sent_at = m2.sent_at AND m.message_id < m2.message_id)
  )
 WHERE m2.email iS NULL;

COMMIT;

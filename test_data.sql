PRAGMA foreign_keys = ON; -- Future-proof.

BEGIN;

INSERT INTO correspondents
VALUES ('duncan@duncandavidson.com', 'James Duncan Davidson');
INSERT INTO correspondents
VALUES ('Tim.Bunce@pobox.com', 'Tim Bunce');
INSERT INTO correspondents
VALUES ('casey@geeknest.com', 'Casey West' );
INSERT INTO correspondents
VALUES ('siliconflorist@gmail.com', 'Rick Turoczy' );
INSERT INTO correspondents
VALUES ('julie@strongrrl.com', 'Julie Wheeler');
INSERT INTO correspondents
VALUES ('rick@lepage.com', 'Rick LePage');
INSERT INTO correspondents
VALUES ('duke@leto.com', 'Duke Leto');
INSERT INTO correspondents
VALUES ('pete@krawczyk.com', 'Pete Krawczyk');
INSERT INTO correspondents
VALUES ('gmeyer@apple.com', 'Gordon Meyer');

INSERT INTO messages ( message_id, email, from_me, body, sent_at )
VALUES ('65dfcef0-143d-11df-bef0-7f981bcf9818', 'Tim.Bunce@pobox.com', 0,
        'Any chance you''d be able to review the plperl changes sometime soonish? I''m concerned that at least some will fall off the end of the ''fest',
        datetime(strftime('%s','now') - 86400 * 23, 'unixepoch')
        );

INSERT INTO messages ( message_id, email, from_me, body, sent_at )
VALUES ('6554a686-143d-11df-91e4-5b45e12f0e15', 'Tim.Bunce@pobox.com', 1,
        'Yes, I’m going to try. I’m overcommitted these days. :-( There’s a *lot* of interest in your patches, though, so I doubt they’ll fall off.',
        datetime(strftime('%s','now') - 86400 * 23, 'unixepoch')
        );

INSERT INTO messages ( message_id, email, from_me, body, sent_at )
VALUES ('267bf0bc-143e-11df-92b5-5349853ba7f4', 'Tim.Bunce@pobox.com', 0,
        'I hope you''re right. I''ve not detected "a lot of interest" on pgsql-hackers. Seemed like an uphill struggle.',
        datetime(strftime('%s','now') - 86400 * 22, 'unixepoch')
        );

INSERT INTO messages ( message_id, email, from_me, body, sent_at )
VALUES ('6d397ace-143e-11df-8af7-0f076dd20b70', 'Tim.Bunce@pobox.com', 1,
        'Enough of us expressed interest that Robert asked two of us to look at something else in the CF. Plus Andrew is aggressively shepherding it.',
        datetime(strftime('%s','now') - 86400 * 2, 'unixepoch')
        );

INSERT INTO messages ( message_id, email, from_me, body, sent_at )
VALUES ('916fe9a0-143e-11df-9675-b3b576e20274', 'Tim.Bunce@pobox.com', 0,
        'Okay, thanks. I hope Andrew doesn''t get stuck on the GUC problem that currently blocking his progress.',
        datetime(strftime('%s','now') - 86400 * 2, 'unixepoch')
        );

INSERT INTO messages ( message_id, email, from_me, body, sent_at )
VALUES ('9df31e40-143e-11df-8866-d3b24a459a99', 'Tim.Bunce@pobox.com', 1,
        'Are you helping with it?',
        datetime(strftime('%s','now') - 86400 * 2, 'unixepoch')
        );

INSERT INTO messages ( message_id, email, from_me, body, sent_at )
VALUES ('bf4af96e-143e-11df-a27b-1ff1dcb8dc53', 'Tim.Bunce@pobox.com', 0,
        'I''m gonn''a try (but I know zero about pg internals so I''d be surprised if I can help)',
        datetime(strftime('%s','now') - 86400 * 2, 'unixepoch')
        );

INSERT INTO messages ( message_id, email, from_me, body, sent_at )
VALUES ('e0a4ba8c-143e-11df-ab35-83032232b39e', 'Tim.Bunce@pobox.com', 0,
        'Hi David. Any thoughts on Toms position re on_perl_init and END?',
        datetime(strftime('%s','now') - 3600, 'unixepoch')
        );

INSERT INTO messages ( message_id, email, from_me, body, sent_at )
VALUES ('eeef38ec-143e-11df-9715-e3f16478aee9', 'Tim.Bunce@pobox.com', 1,
        'You need to address his complaints about Perl messing with PostgreSQL''s internals. I asked for links to specific examples.',
        datetime(strftime('%s','now') - 21 * 60, 'unixepoch')
        );

INSERT INTO messages ( message_id, email, from_me, body, sent_at )
VALUES ('0f891794-143f-11df-be42-3b5d649de9b2', 'Tim.Bunce@pobox.com', 1,
        'Andrew says see http://anoncvs.postgresql.org/cvsweb.cgi/pgsql/src/pl/plperl/plperl.c, rev 1.101.',
        datetime(strftime('%s','now') - 20 * 60, 'unixepoch')
        );

INSERT INTO messages ( message_id, email, from_me, body, sent_at )
VALUES ('27a3cfb8-143f-11df-99c1-4b0f06a90509', 'Tim.Bunce@pobox.com', 0,
        'Sure, there''s nothing to stop plperl (or pltcl or plpython) closing file descriptors for example.',
        datetime(strftime('%s','now') - 18 * 60, 'unixepoch')
        );

INSERT INTO messages ( message_id, email, from_me, body, sent_at )
VALUES ('42a49aae-143f-11df-8ac3-bf062a11a333', 'Tim.Bunce@pobox.com', 0,
        'Actually that''s plperlu. I''ll ponder plperl more carefully and formulate a reply email.',
        datetime(strftime('%s','now') - 15 * 60, 'unixepoch')
        );

INSERT INTO messages ( message_id, email, from_me, body, sent_at )
VALUES ('484501a6-143f-11df-b2c7-8f9ecc0a73ce', 'Tim.Bunce@pobox.com', 1,
        'a. Don''t tell me! b. Reach me on IRC.',
        datetime(strftime('%s','now') - 10 * 60, 'unixepoch')
        );

--ROLLBACK;
COMMIT;


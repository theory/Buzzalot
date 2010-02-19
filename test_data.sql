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

-- Tim
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

INSERT INTO messages ( message_id, email, from_me, body, sent_at )
VALUES ('d8ab76d4-1d8c-11df-ab21-03765c5d3754', 'Tim.Bunce@pobox.com', 0,
        'Any chance you''d be able to review the plperl changes sometime soonish? I''m concerned that at least some will fall off the end of the ''fest',
        datetime(strftime('%s','now') - 86400 * 23, 'unixepoch')
        );

-- Duncan

INSERT INTO messages ( message_id, email, from_me, body, sent_at )
VALUES ('fd780932-1d87-11df-bdca-27b34c550da8', 'duncan@duncandavidson.com', 1,
        'Do you happen to have an iPhone programming book? I could use something to read that will help me to wrap my brain around Apple''s MVC stuff.',
        datetime(strftime('%s','now') - 86400 * 26, 'unixepoch')
       );

INSERT INTO messages ( message_id, email, from_me, body, sent_at )
VALUES ('07abf56c-1d88-11df-89d1-7730a4d4e87b', 'duncan@duncandavidson.com', 0,
        'I don''t have anything specific to the iPhone, no.. :(',
        datetime((strftime('%s','now') - 86400 * 26) + 45, 'unixepoch')
       );

INSERT INTO messages ( message_id, email, from_me, body, sent_at )
VALUES ('0be0a2e0-1d88-11df-a722-1be0811258e8', 'duncan@duncandavidson.com', 1,
        'S’okay. I learned a lot today fiddling with IB. Thanks!',
        datetime((strftime('%s','now') - 86400 * 26) + 120, 'unixepoch')
       );

-- Casey

INSERT INTO messages ( message_id, email, from_me, body, sent_at )
VALUES ('1fa56416-1d8b-11df-90c6-9780273c798f', 'casey@geeknest.com', 1,
        'Hey, you about? I''d like to pick your brain a bit about JSAN if you have a few minutes. I''m on AIM and IRC.',
        datetime(strftime('%s','now') - 86400 * 27, 'unixepoch')
       );

INSERT INTO messages ( message_id, email, from_me, body, sent_at )
VALUES ('ec594e80-1d88-11df-8c00-c7cf2e1656a5', 'casey@geeknest.com', 0,
        'I''ll have time a little later today. Have two more hours at client, then heading to airport. Should have a little time there.',
        datetime((strftime('%s','now') - 86400 * 27) + 340, 'unixepoch')
       );

INSERT INTO messages ( message_id, email, from_me, body, sent_at )
VALUES ('2081e440-1d8b-11df-8a86-eb0370541c4a', 'casey@geeknest.com', 1,
        'Great, thanks.',
        datetime((strftime('%s','now') - 86400 * 27) + 400, 'unixepoch')
       );

INSERT INTO messages ( message_id, email, from_me, body, sent_at )
VALUES ('20d62780-1d8b-11df-966d-538a3aa5a271', 'casey@geeknest.com', 1,
        'Bah. I''m not going to be around much this afternoon, alas, as I''m taking Anna to the Children’s Museum. Ping me though, maybe I can talk.',
        datetime((strftime('%s','now') - 86400 * 27) + 7200, 'unixepoch')
       );

-- Julie

INSERT INTO messages ( message_id, email, from_me, body, sent_at )
VALUES ('ce52200a-1d89-11df-a867-032162988a3e', 'julie@strongrrl.com', 0,
        'How was it seeing Anessa?',
        datetime(strftime('%s','now') - 86400, 'unixepoch')
       );

INSERT INTO messages ( message_id, email, from_me, body, sent_at )
VALUES ('d6380cb2-1d89-11df-b344-33c923ee9467', 'julie@strongrrl.com', 1,
        'Sorry, was on the phone. It was nice! I think there''s real friend potential there. Like you, she''s very social, and left all her friends behind in sacto.',
        datetime(strftime('%s','now') - 86320, 'unixepoch')
       );

INSERT INTO messages ( message_id, email, from_me, body, sent_at )
VALUES ('dba490e4-1d89-11df-82e0-0fde7d0f7aef', 'julie@strongrrl.com', 0,
        'Great. Having lunch at Whole Foods with A now.',
        datetime(strftime('%s','now') - 86256, 'unixepoch')
       );

INSERT INTO messages ( message_id, email, from_me, body, sent_at )
VALUES ('e04d2bc4-1d89-11df-95fb-d77333d8e2b4', 'julie@strongrrl.com', 1,
        'Okay. Sew you soon!',
        datetime(strftime('%s','now') - 86132, 'unixepoch')
       );

INSERT INTO messages ( message_id, email, from_me, body, sent_at )
VALUES ('e5bc0ff8-1d89-11df-8015-b30a62fee7a5', 'julie@strongrrl.com', 0,
        'Um, please don''t sew me. We''ve got gym next. Home for cupcakes atound 2:45. :-)',
        datetime(strftime('%s','now') - 85204, 'unixepoch')
       );

INSERT INTO messages ( message_id, email, from_me, body, sent_at )
VALUES ('e608c4c4-1d89-11df-b05d-d35e9e6f31f5', 'julie@strongrrl.com', 1,
        'Heh, oops.',
        datetime(strftime('%s','now') - 84165, 'unixepoch')
       );

INSERT INTO messages ( message_id, email, from_me, body, sent_at )
VALUES ('e647028e-1d89-11df-9d04-df2e2ce67830', 'julie@strongrrl.com', 1,
        'Heading out now.',
        datetime(strftime('%s','now', 'utc') - 80, 'unixepoch')
       );

INSERT INTO messages ( message_id, email, from_me, body, sent_at )
VALUES ('e6862d24-1d89-11df-866f-fb03b77f8fe3', 'julie@strongrrl.com', 0,
        'K be safe',
        datetime(strftime('%s','now', 'utc') - 45, 'unixepoch')
       );

INSERT INTO messages ( message_id, email, from_me, body, sent_at )
VALUES ('e6cbcce4-1d89-11df-ad03-5fa0c9aff6a3', 'julie@strongrrl.com', 1,
        'Riding with Selena.',
        datetime(strftime('%s','now', 'utc'), 'unixepoch')
       );

-- Duke

INSERT INTO messages ( message_id, email, from_me, body, sent_at )
VALUES ('88766bf8-1d8a-11df-a5b8-c7c48d731436', 'duke@leto.com', 0,
        'can you help with this? http://gist.github.com/287501 I want to compare floats in pgTAP. maybe my casting-fu is rusty',
        datetime(strftime('%s','now') - 86400 * 23, 'unixepoch')
       );

-- LePage

INSERT INTO messages ( message_id, email, from_me, body, sent_at )
VALUES ('2120e8e2-1d8b-11df-be29-bbfa5e31229e', 'rick@lepage.com', 0,
        'To whom was that directed? I was just about to meet Duncan at Hot Lips.',
        datetime(strftime('%s','now') - 86400 * 23 * 3, 'unixepoch')
       );

-- Gordon

INSERT INTO messages ( message_id, email, from_me, body, sent_at )
VALUES ('014a58a4-1d8c-11df-8829-6b682d7b9654', 'gmeyer@apple.com', 0,
        'I have an invite, d me your email address.',
        datetime(strftime('%s','now') - 86692 * 30 * 3, 'unixepoch')
       );

-- Sachmet.

INSERT INTO messages ( message_id, email, from_me, body, sent_at )
VALUES ('6bf4944e-1d8c-11df-88ad-6b5ffeeba48e', 'pete@krawczyk.com', 0,
        'Yes.',
        datetime(strftime('%s','now') - 86439 * 30 * 18, 'unixepoch')
       );

INSERT INTO messages ( message_id, email, from_me, body, sent_at )
VALUES ('6cc54e2c-1d8c-11df-8fa6-efd0e61d38a1', 'pete@krawczyk.com', 0,
        'In order to process your request, I need an email address. ;-)',
        datetime((strftime('%s','now') - 86439 * 30 * 18) + 10, 'unixepoch')
       );

INSERT INTO messages ( message_id, email, from_me, body, sent_at )
VALUES ('6d0d3408-1d8c-11df-ab90-636aafa579f7', 'pete@krawczyk.com', 1,
        'RJBS has sent me one. Thanks!',
        datetime((strftime('%s','now') - 86439 * 30 * 18) + 175, 'unixepoch')
       );

--ROLLBACK;
COMMIT;

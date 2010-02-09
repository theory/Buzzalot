//
//  Buzzer.m
//  Buzzalot
//
//  Created by David E. Wheeler on 2/8/10.
//  Copyright 2010 Kineticode, Inc.. All rights reserved.
//

#import "Buzzer.h"
#import "BuzzalotAppDelegate.h"

@implementation Buzzer
@synthesize email, name, body, when, icon;

+ (NSMutableArray *) selectBuzzers {
    sqlite3 *db = [BuzzalotAppDelegate getDBConnection];
    sqlite3_stmt *sth;
    NSMutableArray *buzzers = [[NSMutableArray alloc] init];
    if (sqlite3_prepare_v2(db, "SELECT email, name, body, sent_at FROM most_recent ORDER BY sent_at DESC", -1, &sth, nil) == SQLITE_OK ) {
        while (sqlite3_step(sth) == SQLITE_ROW) {
            [buzzers addObject: [[Buzzer alloc]
                                 initWithEmail: (char *) sqlite3_column_text(sth, 0)
                                 name: (char *) sqlite3_column_text(sth, 1)
                                 when: (char *) sqlite3_column_text(sth, 3)
                                 body: (char *) sqlite3_column_text(sth, 2)
                                 ]];
        }
        sqlite3_finalize(sth);
    }
    return buzzers;
}    

-(Buzzer *)initWithEmail:(char *)e name:(char *)n when:(char *)w body:(char *)b {
    if (self = [super init]) {
        self.email = [[NSString alloc] initWithUTF8String:e];
        self.name  = [[NSString alloc] initWithUTF8String:n];
        self.when  = [[NSString alloc] initWithUTF8String:w];
        self.body  = [[NSString alloc] initWithUTF8String:b];
    }
    return self;
}

- (UIImage *) icon {
    // TODO: Replace with address book lookup/local cache.
    NSDictionary *icons = [[NSDictionary alloc] initWithObjectsAndKeys:
                           @"duncan.jpg",      @"duncan@duncandavidson.com",
                           @"timbunce.jpg",    @"Tim.Bunce@pobox.com",
                           @"caseywest.jpg",   @"casey@geeknest.com",
                           @"strongrrl.jpg",   @"julie@strongrrl.com",
                           @"turoczy.jpg",     @"siliconflorist@gmail.com",
                           @"gordonmeyer.jpg", @"gmeyer@apple.com",
                           @"dukeleto.jpg",    @"duke@leto.com",
                           @"rlepage.jpg",     @"rick@lepage.com",
                           @"sachmet.jpg",     @"pete@krawczyk.com",
                           nil ];
    return [UIImage imageNamed:[icons objectForKey:self.email]];
}

-(void)deleteBuzzer {
    sqlite3 *db = [BuzzalotAppDelegate getDBConnection];
    sqlite3_stmt *sth;
    // Delete messages.
    if (sqlite3_prepare_v2(db, "DELETE FROM messages WHERE email = ?", -1, &sth, nil) == SQLITE_OK ) {
        sqlite3_bind_text(sth, 1, [self.email UTF8String], -1, NULL);
    }

    sqlite3_step(sth);
    sqlite3_finalize(sth);

    // Delete correspondent.
    if (sqlite3_prepare_v2(db, "DELETE FROM correspondents WHERE email = ?", -1, &sth, nil) == SQLITE_OK ) {
        sqlite3_bind_text(sth, 1, [self.email UTF8String], -1, NULL);
    }
    sqlite3_step(sth);
    sqlite3_finalize(sth);
}


@end

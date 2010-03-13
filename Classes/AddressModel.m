//
//  AddressModel.m
//  Buzzalot
//
//  Created by David E. Wheeler on 3/1/10.
//  Copyright 2010 Kineticode, Inc.. All rights reserved.
//

#import "AddressModel.h"
#import "BuzzalotAppDelegate.h"

@implementation AddressModel
@synthesize email, confirmed;

+(NSMutableArray *) selectAll {
    sqlite3 *db = [BuzzalotAppDelegate getDBConnection];
    sqlite3_stmt *sth;
    NSMutableArray *addresses = [[NSMutableArray alloc] init];
    if (sqlite3_prepare_v2(db, "SELECT email, confirmed FROM addresses ORDER BY position", -1, &sth, nil) == SQLITE_OK ) {
        while (sqlite3_step(sth) == SQLITE_ROW) {
            [addresses addObject: [[AddressModel alloc]
                                  initWithEmail: (char *) sqlite3_column_text(sth, 0)
                                  confirmed: sqlite3_column_int(sth, 1)
                                  ]];
        }
        sqlite3_finalize(sth);
    }
    return [addresses autorelease];
}

+(void) reorderAddressesFrom:(NSArray *)a {
    sqlite3 *db = [BuzzalotAppDelegate getDBConnection];
    char *errorMsg;
    if (sqlite3_exec(db, "BEGIN;", NULL, NULL, &errorMsg) != SQLITE_OK) {
        sqlite3_close(db);
        NSAssert1(0, @"Error executing BEGIN: %s", errorMsg);
    }

    if (sqlite3_exec(db, "UPDATE addresses SET position = -position;", NULL, NULL, &errorMsg) != SQLITE_OK) {
        sqlite3_close(db);
        NSAssert1(0, @"Error executing UPDATE addresses SET position = -position;: %s", errorMsg);
    }

    sqlite3_stmt *sth;
    if (sqlite3_prepare_v2(db, "UPDATE addresses SET position = ? WHERE email = ?", -1, &sth, nil) == SQLITE_OK ) {
        int i = 0;
        for (AddressModel *addr in a) {
            sqlite3_bind_int(sth, 1, ++i);
            sqlite3_bind_text(sth, 2, [addr.email UTF8String], -1, NULL);
            NSLog(@"Email: %@ (%u)", addr.email, i);
            sqlite3_step(sth);
            sqlite3_reset(sth);
        }
        sqlite3_finalize(sth);
    }

    if (sqlite3_exec(db, "DELETE FROM addresses WHERE position < 0;", NULL, NULL, &errorMsg) != SQLITE_OK) {
        sqlite3_close(db);
        NSAssert1(0, @"Error executing DELETE FROM addresses WHERE position < 0: %s", errorMsg);
    }

    if (sqlite3_exec(db, "COMMIT;", NULL, NULL, &errorMsg) != SQLITE_OK) {
        sqlite3_close(db);
        NSAssert1(0, @"Error executing COMMIT: %s", errorMsg);
    }
}

- (AddressModel *) initWithEmail:(char *)e confirmed:(int)c {
    if (self = [super init]) {
        self.email     = [[NSString alloc] initWithUTF8String:e];
        self.confirmed = c == 1;
    }
    return self;
}

- (void) confirm {
    sqlite3 *db = [BuzzalotAppDelegate getDBConnection];
    sqlite3_stmt *sth;
    if (sqlite3_prepare_v2(db, "UPDATE addresses SET confirmed = 1 WHERE email = ?", -1, &sth, nil) == SQLITE_OK ) {
        sqlite3_bind_text(sth, 1, [self.email UTF8String], -1, NULL);
        sqlite3_step(sth);
        sqlite3_finalize(sth);
    }
}

- (void) add {
    sqlite3 *db = [BuzzalotAppDelegate getDBConnection];
    sqlite3_stmt *sth;
    if (sqlite3_prepare_v2(db, "INSERT INTO addresses (email, position) VALUES (?, (SELECT MAX(position) + 1 FROM addresses));", -1, &sth, nil) == SQLITE_OK ) {
        sqlite3_bind_text(sth, 1, [self.email UTF8String], -1, NULL);
        sqlite3_step(sth);
        sqlite3_finalize(sth);
    }
}

- (void)dealloc {
    [email release];
    [super dealloc];
}


@end

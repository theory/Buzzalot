//
//  SQLMigrator.m
//  Buzzalot
//
//  Created by David E. Wheeler on 2/9/10.
//  Copyright 2010 Kineticode, Inc.. All rights reserved.
//

#import "SQLMigrator.h"

@implementation SQLMigrator

NSInteger intSort(id num1, id num2, void *context) {
    int v1 = [num1 intValue];
    int v2 = [num2 intValue];
    if (v1 < v2)
        return NSOrderedAscending;
    else if (v1 > v2)
        return NSOrderedDescending;
    else
        return NSOrderedSame;
}

+(void) migrateDb:(sqlite3 *)db directory:(NSString *)dir {
    // What's the current version?
    sqlite3_stmt *sth;
    int version = 0;
    if (sqlite3_prepare_v2(db, "PRAGMA schema_version;", -1, &sth, nil) == SQLITE_OK ) {
        sqlite3_step(sth);
        version = sqlite3_column_int(sth, 0);
    }
    sqlite3_finalize(sth);

    // Open the migration directory.
    NSArray *paths = [[NSBundle mainBundle] pathsForResourcesOfType:@"sql" inDirectory:dir ];
    
    // Iterate through the migration files and execute them.
    NSString *fileContents;
    char *errorMsg;
    for (NSString *filename in paths) {
        int fileVersion = [[[filename componentsSeparatedByString:@"/"] lastObject] intValue];
        if (fileVersion > version) {
            fileContents = [[NSString alloc] initWithContentsOfFile:filename encoding:NSUTF8StringEncoding error:nil];
            if (sqlite3_exec(db, [fileContents UTF8String], NULL, NULL, &errorMsg) != SQLITE_OK) {
                sqlite3_close(db);
                NSAssert2(0, @"Error executing %s: %s", filename, errorMsg);
            } else {
                if (sqlite3_exec(db, [[NSString stringWithFormat:@"PRAGMA schema_version = %u;", fileVersion] UTF8String], NULL, NULL, &errorMsg) != SQLITE_OK) {
                    sqlite3_close(db);
                    NSAssert2(0, @"Error executing PRAGMA schema_version = %u: %s", fileVersion, errorMsg);
                }
            }
        }
    }

    // Clean up.
    [paths release];
    [fileContents release];
}

@end

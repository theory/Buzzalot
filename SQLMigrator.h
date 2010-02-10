//
//  SQLMigrator.h
//  Buzzalot
//
//  Created by David E. Wheeler on 2/9/10.
//  Copyright 2010 Kineticode, Inc.. All rights reserved.
//

#import <sqlite3.h>

@interface SQLMigrator : NSObject {

}

+(void) migrateDb:(sqlite3 *)db directory:(NSString *)dir;

@end

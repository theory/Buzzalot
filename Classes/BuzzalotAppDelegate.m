//
//  BuzzalotAppDelegate.m
//  Buzzalot
//
//  Created by David E. Wheeler on 2/2/10.
//  Copyright Kineticode, Inc. 2010. All rights reserved.
//

#import "BuzzalotAppDelegate.h"
#import "RootViewController.h"

@implementation BuzzalotAppDelegate

@synthesize window, navController;

+ (NSString *) dbFilePath {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    return [[paths objectAtIndex:0] stringByAppendingPathComponent:kDBFilename];
}

- (void)createEditableCopyOfDatabaseIfNeeded {
    // First, test for existence.
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *dbFilePath = [[self class] dbFilePath];
    if ([fileManager fileExistsAtPath:dbFilePath]) return;
    
    // The writable database does not exist, so copy the default to the appropriate location.
    NSError *error;
    NSString *defaultDBPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:kDBFilename];
    if (![fileManager copyItemAtPath:defaultDBPath toPath:dbFilePath error:&error])
        NSAssert1(0, @"Failed to create writable database file with message '%@'.", [error localizedDescription]);
}

- (void)applicationDidFinishLaunching:(UIApplication *)application {    
	window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
	
	RootViewController *viewController = [[RootViewController alloc] init];
	navController = [[UINavigationController alloc] initWithRootViewController:viewController];
	[viewController release];

    // Make sure we have a database.
    [self createEditableCopyOfDatabaseIfNeeded];

    // onfigure and show the window.
    [window addSubview:[navController view]];
	[window makeKeyAndVisible];
}

- (void)dealloc {
	[navController release];
    [window release];
    [super dealloc];
}

+(sqlite3 *) getDBConnection {
    sqlite3 *conn;
    if (sqlite3_open([[self dbFilePath] UTF8String], &conn) != SQLITE_OK) {
        sqlite3_close(conn);
        NSAssert(0, @"Failed to open database");
    }
    return conn;
}
@end

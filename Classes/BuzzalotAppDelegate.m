//
//  BuzzalotAppDelegate.m
//  Buzzalot
//
//  Created by David E. Wheeler on 2/2/10.
//  Copyright Kineticode, Inc. 2010. All rights reserved.
//

#import "BuzzalotAppDelegate.h"
#import "RootViewController.h"
#import "SQLMigrator.h"
#import "IconFinder.h"

@implementation BuzzalotAppDelegate

@synthesize window, navController, iconQueue;

+ (NSString *) dbFilePath {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    return [[paths objectAtIndex:0] stringByAppendingPathComponent:kDBFilename];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
	window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
	
	RootViewController *viewController = [[RootViewController alloc] init];
	navController = [[UINavigationController alloc] initWithRootViewController:viewController];
	[viewController release];

    // Make sure we have a database.
    [SQLMigrator migrateDb:[BuzzalotAppDelegate getDBConnection] directory: @"sql"];

    // Set up the icon queue.
    self.iconQueue = [[NSOperationQueue alloc] init];

    // TODO: Start background task to download latest messages. Update each
    // recipient icon as it arrives, no more than once a day.

    // Configure and show the window.
    [window addSubview:[navController view]];

	if ([[NSUserDefaults standardUserDefaults] stringForKey:kUserNameKey] == nil) {
		// Create the default configuration values.
		NSDictionary *appDefaults = [NSDictionary dictionary];
		[[NSUserDefaults standardUserDefaults] registerDefaults:appDefaults];
		[[NSUserDefaults standardUserDefaults] synchronize];

        // Load the ConfigViewController
        [viewController showConfig];
    }

	[window makeKeyAndVisible];
    return YES;
}

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application {
    [IconFinder clearCache];
}

- (void)dealloc {
    [iconQueue release];
    [navController release];
    [window release];
    [super dealloc];
}

// TODO: Make this into an instance attribute.
+(sqlite3 *) getDBConnection {
    sqlite3 *conn;
    if (sqlite3_open([[self dbFilePath] UTF8String], &conn) != SQLITE_OK) {
        sqlite3_close(conn);
        NSAssert(0, @"Failed to open database");
    } else {
        // Future-proof: Eventually we'll have SQLite 3.6.19 or greater.
        char *errorMsg;
        if (sqlite3_exec(conn, "PRAGMA foreign_keys = ON;", NULL, NULL, &errorMsg) != SQLITE_OK) {
            sqlite3_close(conn);
            NSAssert1(0, @"Error enabling foreign-key constraints: %s", errorMsg);
        }
    }

    return conn;
}
@end

//
//  BuzzalotAppDelegate.h
//  Buzzalot
//
//  Created by David E. Wheeler on 2/2/10.
//  Copyright Kineticode, Inc. 2010. All rights reserved.
//

#define kDBFilename               @"buzzalot.db"
#define kUserNameKey              @"PrimaryEmail"
#define kCacheRefreshIntervalKey  @"CacheRefreshInterval"

#import <sqlite3.h>

@interface BuzzalotAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
	UINavigationController *navController;
    NSOperationQueue * iconQueue;
}

@property (nonatomic, retain) UIWindow *window;
@property (nonatomic, retain) UINavigationController *navController;
@property (retain) NSOperationQueue * iconQueue;

+ (sqlite3 *) getDBConnection;

@end


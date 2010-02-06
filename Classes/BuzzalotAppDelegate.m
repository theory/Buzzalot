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

- (void)applicationDidFinishLaunching:(UIApplication *)application {    
	window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
	
	RootViewController *viewController = [[RootViewController alloc] init];
	navController = [[UINavigationController alloc] initWithRootViewController:viewController];
	[viewController release];
	[window addSubview:[navController view]];
	[window makeKeyAndVisible];
}

- (void)dealloc {
	[navController release];
    [window release];
    [super dealloc];
}


@end

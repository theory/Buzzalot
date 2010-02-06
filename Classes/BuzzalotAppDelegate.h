//
//  BuzzalotAppDelegate.h
//  Buzzalot
//
//  Created by David E. Wheeler on 2/2/10.
//  Copyright Kineticode, Inc. 2010. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BuzzalotAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
	UINavigationController *navController;
}

@property (nonatomic, retain) UIWindow *window;
@property (nonatomic, retain) UINavigationController *navController;

@end


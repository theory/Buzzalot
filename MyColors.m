//
//  MyColors.m
//  Buzzalot
//
//  Created by David E. Wheeler on 2/4/10.
//  Copyright 2010 Kineticode, Inc.. All rights reserved.
//

#import "MyColors.h"

@implementation UIColor (NewColors)
+ (UIColor *)blueGrayColor {
    static UIColor *blueGrayColor = nil;
    if (! blueGrayColor)
        blueGrayColor = [[UIColor colorWithRed:0.596 green:0.655 blue:0.792 alpha:1.0] retain];
    return blueGrayColor;
}

+ (UIColor *)configTextColor {
    static UIColor *configTextColor = nil;
    if (! configTextColor)
        configTextColor = [[UIColor colorWithRed:0.290 green:0.392 blue:0.573 alpha:1.0] retain];
    return configTextColor;
}

+ (UIColor *)tweetieBlue {
    static UIColor *tweetieBlue = nil;
    if (! tweetieBlue)
        tweetieBlue = [[UIColor colorWithRed:0.886 green:0.906 blue:0.929 alpha:1.0] retain];
    return tweetieBlue;
}

@end
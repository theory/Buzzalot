//
//  main.m
//  Buzzalot
//
//  Created by David E. Wheeler on 2/2/10.
//  Copyright Kineticode, Inc. 2010. All rights reserved.
//

#import <UIKit/UIKit.h>

int main(int argc, char *argv[]) {
    
    NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
    int retVal = UIApplicationMain(argc, argv, nil, @"BuzzalotAppDelegate");
    [pool release];
    return retVal;
}

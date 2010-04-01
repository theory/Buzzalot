//
//  RootViewController.h
//  Buzzalot
//
//  Created by David E. Wheeler on 2/2/10.
//  Copyright 2010 Kineticode, Inc.. All rights reserved.
//

#import "ConfigViewController.h"
#import "ComposeViewController.h"
#import "BuzzerViewController.h"

@interface RootViewController : UITableViewController <ConfigViewControllerDelegate, ComposeViewControllerDelegate> {
    NSMutableArray *buzzers;
}

@property (nonatomic, retain) NSMutableArray *buzzers;

- (void)showConfig;

@end

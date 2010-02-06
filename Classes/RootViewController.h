//
//  RootViewController.h
//  Buzzalot
//
//  Created by David E. Wheeler on 2/2/10.
//  Copyright 2010 Kineticode, Inc.. All rights reserved.
//

#import "ConfigViewController.h"

@interface RootViewController : UITableViewController <ConfigViewControllerDelegate> {
    NSArray *buzzers;
}

@property (nonatomic, retain) NSArray *buzzers;

@end

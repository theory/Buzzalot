//
//  ConfigViewController.h
//  Buzzalot
//
//  Created by David E. Wheeler on 1/17/10.
//  Copyright 2010 Kineticode, Inc.. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ConfigViewControllerDelegate;

@interface ConfigViewController : UITableViewController {
	id <ConfigViewControllerDelegate> delegate;
}

@property (nonatomic, assign) id <ConfigViewControllerDelegate> delegate;
- (IBAction)done;
@end

@protocol ConfigViewControllerDelegate
- (void)configViewControllerDidFinish:(ConfigViewController *)controller;
@end


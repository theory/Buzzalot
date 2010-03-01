//
//  ConfigViewController.h
//  Buzzalot
//
//  Created by David E. Wheeler on 2/4/10.
//  Copyright 2010 Kineticode, Inc.. All rights reserved.
//

@protocol ConfigViewControllerDelegate;

@interface ConfigViewController : UITableViewController {
	id <ConfigViewControllerDelegate> delegate;
}

@property (nonatomic, assign) id <ConfigViewControllerDelegate> delegate;
- (void)done;

@end

@protocol ConfigViewControllerDelegate

- (void)configViewControllerDidFinish:(ConfigViewController *)controller;
- (void) emailChanged:(id)sender;

@end

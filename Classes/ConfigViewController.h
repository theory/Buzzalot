//
//  ConfigViewController.h
//  Buzzalot
//
//  Created by David E. Wheeler on 2/4/10.
//  Copyright 2010 Kineticode, Inc.. All rights reserved.
//

@protocol ConfigViewControllerDelegate;

@interface ConfigViewController : UITableViewController <UITextFieldDelegate> {
	id <ConfigViewControllerDelegate> delegate;
    NSMutableArray  *addresses;
    UIBarButtonItem *doneButton;
    UIBarButtonItem *editButton;
    UIBarButtonItem *addButton;
    UITextField     *nameField;
}

@property (nonatomic, assign) id <ConfigViewControllerDelegate> delegate;
@property (nonatomic, retain) NSMutableArray  *addresses;
@property (nonatomic, retain) UIBarButtonItem *doneButton;
@property (nonatomic, retain) UIBarButtonItem *editButton;
@property (nonatomic, retain) UIBarButtonItem *addButton;
@property (nonatomic, retain) UITextField     *nameField;

- (void)done;
- (void)bakgroundTap:(id)sender;

@end

@protocol ConfigViewControllerDelegate

- (void)configViewControllerDidFinish:(ConfigViewController *)controller;

@end

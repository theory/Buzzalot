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
    UIButton        *editButton;
    UIButton        *addButton;
    UITextField     *nameField;
    UIImage         *whiteButtonBg;
    UIImage         *blueButtonBg;
    UIView          *editView;
}

@property (nonatomic, assign) id <ConfigViewControllerDelegate> delegate;
@property (nonatomic, retain) NSMutableArray  *addresses;
@property (nonatomic, retain) UIBarButtonItem *doneButton;
@property (nonatomic, retain) UIButton        *editButton;
@property (nonatomic, retain) UIButton        *addButton;
@property (nonatomic, retain) UITextField     *nameField;
@property (nonatomic, retain) UIImage         *whiteButtonBg;
@property (nonatomic, retain) UIImage         *blueButtonBg;
@property (nonatomic, retain) UIView          *editView;

- (void)done;
- (void)bakgroundTap:(id)sender;

@end

@protocol ConfigViewControllerDelegate

- (void)configViewControllerDidFinish:(ConfigViewController *)controller;

@end

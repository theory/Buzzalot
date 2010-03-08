//
//  AddressViewController.h
//  Buzzalot
//
//  Created by David E. Wheeler on 3/5/10.
//  Copyright 2010 Kineticode, Inc.. All rights reserved.
//

//
//  RootViewController.h
//  Buzzalot
//
//  Created by David E. Wheeler on 2/2/10.
//  Copyright 2010 Kineticode, Inc.. All rights reserved.
//

@class AddressModel;

@interface AddressViewController : UITableViewController <UITextFieldDelegate> {
    AddressModel *address;
    UITextField  *emailField;
    UITextField  *codeField;
    UIButton     *submitButton;
    UIView       *submitView;
}

@property (nonatomic, retain) AddressModel *address;
@property (nonatomic, retain) UITextField *emailField;
@property (nonatomic, retain) UITextField *codeField;
@property (nonatomic, retain) UIButton    *submitButton;
@property (nonatomic, retain) UIView      *submitView;

- (void) emailChanged:(id)sender;
- (void) requestButtonTapped:(id)sender;
- (void) confirmButtonTapped:(id)sender;
- (void) setButtonToCofirm;
- (void) setButtonToRequest;

@end

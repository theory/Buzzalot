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
@class MBProgressHUD;

@interface AddressViewController : UITableViewController <UITextFieldDelegate, UIActionSheetDelegate> {
    AddressModel  *address;
    UITextField   *emailField;
    UITextField   *codeField;
    UIButton      *submitButton;
    UIView        *submitView;
    MBProgressHUD *hud;
}

@property (nonatomic, retain) AddressModel  *address;
@property (nonatomic, retain) UITextField   *emailField;
@property (nonatomic, retain) UITextField   *codeField;
@property (nonatomic, retain) UIButton      *submitButton;
@property (nonatomic, retain) UIView        *submitView;
@property (nonatomic, retain) MBProgressHUD *hud;

- (void) fieldChanged:(id)sender;
- (void) emailEdited:(id)sender;
- (void) emailExited:(id)sender;
- (void) requestButtonTapped:(id)sender;
- (void) requestButtonGo;
- (void) confirmButtonTapped:(id)sender;
- (void) setButtonToCofirm;
- (void) setButtonToRequest;
- (void) sendRequest;
- (void) sendConfirm;
- (void) switchToCodeField;
- (BOOL) validateEmail: (NSString *) email;

@end

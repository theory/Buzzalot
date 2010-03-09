//
//  AddressViewController.m
//  Buzzalot
//
//  Created by David E. Wheeler on 3/5/10.
//  Copyright 2010 Kineticode, Inc.. All rights reserved.
//

#import "AddressViewController.h"
#import "AddressModel.h"
#import "MyColors.h"

@implementation AddressViewController

@synthesize address, emailField, codeField, submitButton, submitView;

- (void)viewDidLoad {
    CGRect frame = CGRectMake(0, 0, 210.0, 24.0);
    self.title = self.address ? @"Confirm Address" : @"Add Address";
    self.emailField = [[UITextField alloc] initWithFrame:frame];
    emailField.placeholder = @"iam@example.com";
    emailField.autocorrectionType = UITextAutocorrectionTypeNo;
    emailField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    emailField.clearButtonMode = UITextFieldViewModeWhileEditing;
    emailField.returnKeyType = UIReturnKeyDone;
    emailField.enablesReturnKeyAutomatically = YES;
    emailField.keyboardType = UIKeyboardTypeEmailAddress;
    emailField.textColor = [UIColor configTextColor];
    emailField.delegate = self;
    [emailField addTarget:self action:@selector(emailChanged:) forControlEvents:UIControlEventEditingDidEnd];

    if (self.address) {
        emailField.text = self.address.email;
        emailField.enabled = NO;
        self.codeField = [[UITextField alloc] initWithFrame:frame];
        codeField.autocorrectionType = UITextAutocorrectionTypeNo;
        codeField.autocapitalizationType = UITextAutocapitalizationTypeNone;
        codeField.clearButtonMode = UITextFieldViewModeWhileEditing;
        codeField.returnKeyType = UIReturnKeyDone;
        codeField.enablesReturnKeyAutomatically = YES;
        codeField.keyboardType = UIKeyboardTypeNumberPad;
        codeField.textColor = [UIColor configTextColor];
        codeField.delegate = self;
        [codeField becomeFirstResponder];
    }

    self.submitButton = [UIButton buttonWithType:UIButtonTypeCustom];
    submitButton.frame = CGRectMake(5, 10, self.tableView.bounds.size.width-10, 44);
    CGRect screenRect = [[UIScreen mainScreen] applicationFrame];
    self.submitView = [[UIView alloc] initWithFrame:CGRectMake(10, 10, screenRect.size.width, 44.0)];
    [submitView addSubview:submitButton];

    [super viewDidLoad];
}

- (void)viewDidUnoad {
    self.emailField   = nil;
    self.codeField    = nil;
    self.submitButton = nil;
    [super viewDidUnload];
}

- (void)dealloc {
    [emailField   release];
    [codeField    release];
    [submitButton release];
    [super dealloc];
}

#pragma mark -

- (void) emailChanged:(id)sender {
}

- (void) startIndicatorWithMessage:(NSString *)message {
    UIAlertView *alert = [[[UIAlertView alloc]
            initWithTitle:message
                  message:nil
                 delegate:nil
        cancelButtonTitle:nil
        otherButtonTitles:nil] autorelease];
    [alert show];
    UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    alert.alpha = .20;
    
    // Adjust the indicator so it is up a few pixels from the bottom of the alert
    indicator.center = CGPointMake(alert.bounds.size.width / 2, alert.bounds.size.height - 50);
    [indicator startAnimating];
    [alert addSubview:indicator];
    [indicator release];
    [alert release];
//    [alert dismissWithClickedButtonIndex:0 animated:YES];
}

- (void) requestButtonTapped:(id)sender {
    [self.emailField resignFirstResponder];
    self.emailField.enabled = NO;
    [self startIndicatorWithMessage: @"Submitting…"];
}

- (void) confirmButtonTapped:(id)sender {
    [self.codeField resignFirstResponder];
    self.codeField.enabled = NO;
    [self startIndicatorWithMessage: @"Confirming…"];
//    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Title" message:@"Confirmed" delegate:self cancelButtonTitle:@"Ah-ite" otherButtonTitles:nil];
//	[alertView show];
//	[alertView release];
}

#pragma mark -
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown;
}

#pragma mark -

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return section == 0 && self.address ? 2 : 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"AddressCell";

    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;        
    }

    if (indexPath.row == 0) {
        cell.textLabel.text = @"Email";
        cell.accessoryView = self.emailField;
    } else {
        cell.textLabel.text = @"Code";
        cell.accessoryView = self.codeField;
    }

    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    // Without this, the edit button is unclickable!
    return 49;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    if (self.address) {
        self.setButtonToCofirm;
    } else {
        self.setButtonToRequest;
    }
    return submitView;
}

- (void) setButtonToCofirm {
    UIImage *bg = [[UIImage imageNamed:@"green_button.png"] stretchableImageWithLeftCapWidth:12.0 topCapHeight:0.0];
    [submitButton setBackgroundImage:bg forState:UIControlStateNormal];
    [submitButton setTitle:@"Confirm Address" forState:UIControlStateNormal];
    [submitButton addTarget:self action:@selector(confirmButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
}

- (void) setButtonToRequest {
    UIImage *bg = [[UIImage imageNamed:@"blue_button.png"] stretchableImageWithLeftCapWidth:12.0 topCapHeight:0.0];
    [submitButton setBackgroundImage:bg forState:UIControlStateNormal];
    [submitButton setTitle:@"Submit Address" forState:UIControlStateNormal];
    [submitButton addTarget:self action:@selector(requestButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
}





@end

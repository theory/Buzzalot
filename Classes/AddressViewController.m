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
#import "MBProgressHUD.h"

@implementation AddressViewController

@synthesize address, emailField, codeField, submitButton, submitView, hud;

- (void) viewWillDisappear:(BOOL)animated {
    UITableViewController *config = (UITableViewController *) [self.navigationController.viewControllers objectAtIndex:0];
    [config.tableView reloadData];
}

- (void)viewDidLoad {
    CGRect frame = CGRectMake(0, 0, 210.0, 24.0);
    self.title = self.address ? @"Confirm Address" : @"Add Address";
    self.emailField = [[UITextField alloc] initWithFrame:frame];
    emailField.placeholder = @"iam@example.com";
    emailField.autocorrectionType = UITextAutocorrectionTypeNo;
    emailField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    emailField.clearButtonMode = UITextFieldViewModeWhileEditing;
    emailField.returnKeyType = UIReturnKeySend;
    emailField.enablesReturnKeyAutomatically = YES;
    emailField.keyboardType = UIKeyboardTypeEmailAddress;
    emailField.textColor = [UIColor configTextColor];
    emailField.delegate = self;
    [emailField addTarget:self action:@selector(emailEdited:) forControlEvents:UIControlEventEditingDidEnd];
    [emailField addTarget:self action:@selector(emailExited:) forControlEvents:UIControlEventEditingDidEndOnExit];
    [emailField addTarget:self action:@selector(fieldChanged:) forControlEvents:UIControlEventEditingChanged];

    self.codeField = [[UITextField alloc] initWithFrame:frame];
    codeField.autocorrectionType = UITextAutocorrectionTypeNo;
    codeField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    codeField.clearButtonMode = UITextFieldViewModeWhileEditing;
    codeField.returnKeyType = UIReturnKeySend;
    codeField.enablesReturnKeyAutomatically = YES;
    codeField.keyboardType = UIKeyboardTypeNumberPad;
    codeField.textColor = [UIColor configTextColor];
    codeField.delegate = self;
    [codeField addTarget:self action:@selector(confirmButtonTapped:) forControlEvents:UIControlEventEditingDidEndOnExit];
    [codeField addTarget:self action:@selector(fieldChanged:) forControlEvents:UIControlEventEditingChanged];

    if (self.address) {
        emailField.text = self.address.email;
        emailField.enabled = NO;
        [codeField becomeFirstResponder];
    }

    self.submitButton = [UIButton buttonWithType:UIButtonTypeCustom];
    submitButton.frame = CGRectMake(5, 10, self.tableView.bounds.size.width-10, 44);
    submitButton.enabled = NO;
    CGRect screenRect = [[UIScreen mainScreen] applicationFrame];
    self.submitView = [[UIView alloc] initWithFrame:CGRectMake(10, 10, screenRect.size.width, 44.0)];
    [submitView addSubview:submitButton];

    [super viewDidLoad];
}

- (void)viewDidUnoad {
    self.emailField   = nil;
    self.codeField    = nil;
    self.submitButton = nil;
    self.submitView   = nil;
    self.hud          = nil;
    [super viewDidUnload];
}

- (void)dealloc {
    [emailField   release];
    [codeField    release];
    [submitButton release];
    [submitView   release];
    [hud          release];
    [super dealloc];
}

#pragma mark -

- (void) emailEdited:(id)sender {
    if (!self.address)
        self.address = [[[AddressModel alloc] init] autorelease];
    self.address.email = self.emailField.text;
}

- (void) emailExited:(id)sender {
    [self emailEdited:sender];
    [self requestButtonTapped:sender];
}

- (void) fieldChanged:(id)sender {
    submitButton.enabled = emailField.text.length > 0 ? YES : NO;
}

- (void) startHudWithMessage:(NSString *)message executing:(SEL)selector{
    self.hud = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:hud];
    hud.opacity = 0.9;
    hud.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.4];
    hud.labelText = message;
    [hud showWhileExecuting:selector onTarget:self withObject:nil animated:YES];
}

- (void) requestButtonTapped:(id)sender {
    [self.emailField resignFirstResponder];
    submitButton.enabled = NO;
    [self.address add];
    [self startHudWithMessage:@"Sending…" executing:@selector(sendRequest)];
}

- (void) confirmButtonTapped:(id)sender {
    [self.codeField resignFirstResponder];
    submitButton.enabled = NO;
    [self startHudWithMessage:@"Confirming…" executing:@selector(sendConfirm)];
}

- (void) sendRequest {
    sleep(2);
    [self.submitButton removeTarget:self action:@selector(requestButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
    emailField.enabled = NO;
    hud.labelText = @"Done.";
    hud.detailsLabelText = @"Check email for confirmation code.";
    sleep(2);
    [self setButtonToCofirm];
    [self.tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:1 inSection:0]] withRowAnimation:UITableViewRowAnimationBottom];
    [self performSelectorOnMainThread:@selector(switchToCodeField) withObject:nil waitUntilDone:NO];
}

- (void) sendConfirm {
    sleep(2);
    [self.address confirm];
    hud.labelText = @"Done.";
    hud.detailsLabelText = @"You may now use this address.";
    sleep(2);
    [self.navigationController popViewControllerAnimated:YES];
}

- (void) switchToCodeField {
    [codeField becomeFirstResponder];
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

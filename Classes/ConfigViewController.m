//
//  ConfigViewController.m
//  Buzzalot
//
//  Created by David E. Wheeler on 2/4/10.
//  Copyright 2010 Kineticode, Inc.. All rights reserved.
//

#import "ConfigViewController.h"
#import "SFHFKeychainUtils.h"
#import "BuzzalotAppDelegate.h"
#import "IconFinder.h"
#import "AddressModel.h"
#import "MyColors.h"

#define kButtonWidth   55.0
#define kButtonHeight  40.0

@implementation ConfigViewController
@synthesize delegate, addresses, editButton, doneButton, addButton, nameField, whiteButtonBg, blueButtonBg, editView;

- (void)viewDidLoad {
	self.title = NSLocalizedString(@"Who are you?", nil);
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.addresses = [AddressModel selectAll];

	self.doneButton = [[ UIBarButtonItem alloc ]
                       initWithBarButtonSystemItem: UIBarButtonSystemItemDone
                       target: self
                       action:@selector(done)
                       ];
	self.navigationItem.leftBarButtonItem = doneButton;

    self.editButton = [[ UIBarButtonItem alloc ]
                       initWithBarButtonSystemItem: UIBarButtonSystemItemEdit
                       target: self
                       action:@selector(toggleEdit)
                       ];
//	if ([self.addresses count] > 1) self.navigationItem.rightBarButtonItem = editButton;

    self.whiteButtonBg = [[UIImage imageNamed:@"whiteButton.png"] stretchableImageWithLeftCapWidth:12.0 topCapHeight:0.0];
    self.blueButtonBg = [[UIImage imageNamed:@"blueButton.png"] stretchableImageWithLeftCapWidth:12.0 topCapHeight:0.0];

    self.editButton = [UIButton buttonWithType:UIButtonTypeCustom];
    editButton.frame = CGRectMake(10, 5, kButtonWidth, kButtonHeight);
    [editButton setBackgroundImage:self.whiteButtonBg forState:UIControlStateNormal];
    [editButton setBackgroundImage:self.blueButtonBg forState:UIControlStateHighlighted];

    [editButton setImage:[UIImage imageNamed:@"shuffle.png"] forState:UIControlStateNormal];
    [editButton setAccessibilityLabel:NSLocalizedString(@"Edit", @"")];
    editButton.backgroundColor = [UIColor clearColor];
    [editButton addTarget:self action:@selector(toggleEdit) forControlEvents:UIControlEventTouchUpInside];

    CGRect screenRect = [[UIScreen mainScreen] applicationFrame];
    self.editView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screenRect.size.width, 44.0)];
    [editView addSubview:self.editButton];

    CGRect frame = CGRectMake(0, 0, 210.0, 24.0);
    self.nameField = [[UITextField alloc] initWithFrame:frame];
    nameField.placeholder = @"Barack Obama";
    nameField.autocorrectionType = UITextAutocorrectionTypeNo;
    nameField.autocapitalizationType = UITextAutocapitalizationTypeWords;
    nameField.returnKeyType = UIReturnKeyDone;
    nameField.text = [[NSUserDefaults standardUserDefaults] stringForKey:kUserNameKey];
    nameField.textColor = [UIColor configTextColor];
    nameField.clearButtonMode = UITextFieldViewModeWhileEditing;
    nameField.delegate = self;
    [nameField addTarget:self action:@selector(nameChanged:) forControlEvents:UIControlEventEditingDidEnd];
    [super viewDidLoad];
}

- (void)viewDidUnload {
    self.doneButton = nil;
    self.addButton  = nil;
    self.editButton = nil;
    self.nameField = nil;
    self.whiteButtonBg = nil;
    self.blueButtonBg = nil;
}

- (void)dealloc {
    [addresses     release];
    [doneButton    release];
    [addButton     release];
    [editButton    release];
    [nameField     release];
    [whiteButtonBg release];
    [blueButtonBg  release];
    [super dealloc];
}

#pragma mark -

- (void)done {
    [nameField resignFirstResponder];
	[self.delegate configViewControllerDidFinish:self];	
}

#pragma mark -

-(void) toggleEdit {
    if (self.tableView.editing) {
        [self.tableView setEditing:NO animated:YES];
        [editButton setBackgroundImage:self.whiteButtonBg forState:UIControlStateNormal];
        [editButton setBackgroundImage:self.blueButtonBg forState:UIControlStateHighlighted];
    } else {
        [nameField resignFirstResponder];
        [self.tableView setEditing:YES animated:YES];
        [editButton setBackgroundImage:self.blueButtonBg forState:UIControlStateNormal];
        [editButton setBackgroundImage:self.whiteButtonBg forState:UIControlStateHighlighted];
    }
}

- (void) nameChanged:(id)sender {
    [[NSUserDefaults standardUserDefaults] setObject: nameField.text forKey: kUserNameKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [nameField resignFirstResponder];

    // Find the image for this email address.
    //    if (![IconFinder getForEmail: textField.text]) {
    //        BuzzalotAppDelegate * app = (BuzzalotAppDelegate *)([UIApplication sharedApplication].delegate);
    //        NSInvocationOperation * findOp = [[NSInvocationOperation alloc] initWithTarget:[IconFinder class] selector:@selector(findForEmail:) object:textField.text];
    //        [app.iconQueue addOperation:findOp];
    //        [findOp release];
    //    }
}

// TODO: Figure out how to trigger this on background tap.
- (void)bakgroundTap:(id)sender {
    [nameField resignFirstResponder];
}

#pragma mark -
#pragma mark Text Field Delegate Methods

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
	// the user pressed the "Done" button, so dismiss the keyboard
	[textField resignFirstResponder];
	return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    if (self.tableView.editing) [self toggleEdit];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

#pragma mark -
#pragma mark Table Delegate Methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return section == 0 ? 1 : [self.addresses count] + 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    // Without this, the edit button is unclickable!
    if (section == 1) return kButtonHeight + 5;
    return self.tableView.sectionFooterHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *cellIdentifier = indexPath.section == 1 ? @"AddressCell" : @"ConfigCell";
    
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier] autorelease];
    }

    switch (indexPath.section) {
        case 0: {
			cell.textLabel.text = @"Name";
			cell.accessoryView = self.nameField;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            break;
        } case 1: {
            if (cellIdentifier == @"AddressCell") cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            if (indexPath.row == [self.addresses count]) {
                cell.textLabel.text = @"Add Address…";
                cell.textLabel.textColor = [UIColor blackColor];
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            } else {
                cell.textLabel.text = [[self.addresses objectAtIndex:indexPath.row] email];
                if ([[self.addresses objectAtIndex:indexPath.row] confirmed]) {
                    cell.textLabel.textColor = [UIColor blackColor];
                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
                    cell.accessoryType = UITableViewCellAccessoryCheckmark;
                } else {
                    cell.textLabel.textColor = [UIColor grayColor];
                    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                }

            }
            break;
        }
    }

    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    if (section == 1 && [self.addresses count] > 1) return self.editView;
    return nil;
}

#pragma mark -
#pragma mark Table Data Source Methods

-(void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
    AddressModel *addr = [[self.addresses objectAtIndex:fromIndexPath.row] retain];
    [self.addresses removeObjectAtIndex:fromIndexPath.row];
    [self.addresses insertObject:addr atIndex:toIndexPath.row];
    [addr release];
    [AddressModel reorderAddressesFrom:self.addresses];
}

- (void)tableView:(UITableView *)tableView
commitEditingStyle:(UITableViewCellEditingStyle)editingStyle
forRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.addresses removeObjectAtIndex:indexPath.row];
    [AddressModel reorderAddressesFrom:self.addresses];
    [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation: UITableViewRowAnimationFade];
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return indexPath.section == 1 && indexPath.row != [self.addresses count];
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    AddressModel *addr = [self.addresses objectAtIndex:indexPath.row];
    if (addr.confirmed) {
        // The primary address (the first confirmed address) is not deletable.
        for (AddressModel *tmp in addresses) {
            if (tmp.confirmed) {
                if (addr == tmp) {
                    return UITableViewCellEditingStyleNone;
                } else {
                    return UITableViewCellEditingStyleDelete;
                }
            }
        }
    }
    return UITableViewCellEditingStyleDelete;
}

- (BOOL)tableView:(UITableView *)tableView shouldIndentWhileEditingRowAtIndexPath:(NSIndexPath *)indexPath {
    return NO;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
//    BuzzerViewController *buzzerViewController = [BuzzerViewController alloc];
//    [buzzerViewController initWithBuzzer: (BuzzerModel *)[self.buzzers objectAtIndex:indexPath.row]];
//	[self.navigationController pushViewController:buzzerViewController animated:YES];
}

@end

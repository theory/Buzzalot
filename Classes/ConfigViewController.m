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

@implementation ConfigViewController
@synthesize delegate;

- (void)viewDidLoad {
	self.title = NSLocalizedString(@"Settings", nil);
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];

	UIBarButtonItem *doneButton = [[ UIBarButtonItem alloc ] 
                                   initWithBarButtonSystemItem: UIBarButtonSystemItemDone 
                                   target: self 
                                   action:@selector(done)
                                   ];
	self.navigationItem.leftBarButtonItem = doneButton;
	[doneButton release];
    [super viewDidLoad];
}

- (void)viewDidUnload {
    // self.foo = nil
}

- (void)dealloc {
    [super dealloc];
}

- (void)done {
	[self.delegate configViewControllerDidFinish:self];	
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"ConfigCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:CellIdentifier] autorelease];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
	// Configure the cell.
    NSString *cellText = nil;
    CGRect frame = CGRectMake(0.0, 0.0, 210.0, 24.0);
    UITextField *textField = [[UITextField alloc] initWithFrame:frame];
    textField.autocorrectionType = UITextAutocorrectionTypeNo;

    switch (indexPath.row) {
        case 0:
            cellText = NSLocalizedString(@"Email", @"Email label");
            textField.placeholder = NSLocalizedString(@"you@example.com", @"Email placeholder");
            textField.text = [[NSUserDefaults standardUserDefaults] stringForKey:kPrimaryEmailKey];
            textField.keyboardType = UIKeyboardTypeEmailAddress;
            [textField addTarget:self action:@selector(emailChanged:) forControlEvents:UIControlEventEditingDidEnd];
            break;
        case 1:
            cellText = NSLocalizedString(@"Password", @"Password label");
            textField.secureTextEntry = YES;
            textField.placeholder = @"•••••••••••";
            textField.keyboardType = UIKeyboardTypeDefault;
            break;
        case 2:
            cellText = NSLocalizedString(@"Code", @"Code label");
            textField.keyboardType = UIKeyboardTypeNumberPad;
            break;
        default:
            break;
    }
    cell.textLabel.text = cellText;
    cell.accessoryView = textField;
	
    return cell;
}

//- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
//    NSString *title = nil;
//    switch (section) {
//        case 0:
//            title = NSLocalizedString(@"Account", @"Account section title");
//            break;
//		case 1:
//			break;
//        case 2:
//            title = NSLocalizedString(@"Style", @"Genre section title");
//            break;
//        default:
//            break;
//    }
//    return title;
//}

- (void) emailChanged:(id)sender {
    UITextField *textField = sender;
    [[NSUserDefaults standardUserDefaults] setObject: textField.text forKey: kPrimaryEmailKey];
    [[NSUserDefaults standardUserDefaults] synchronize];

    // Find the image for this email address.
    if (![IconFinder getForEmail: textField.text]) {
        BuzzalotAppDelegate * app = (BuzzalotAppDelegate *)([UIApplication sharedApplication].delegate);
        NSInvocationOperation * findOp = [[NSInvocationOperation alloc] initWithTarget:[IconFinder class] selector:@selector(findForEmail:) object:textField.text];
        [app.iconQueue addOperation:findOp];
        [findOp release];
    }
}

@end

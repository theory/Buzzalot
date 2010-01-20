//
//  ConfigViewController.m
//  Buzzalot
//
//  Created by David E. Wheeler on 1/17/10.
//  Copyright 2010 Kineticode, Inc.. All rights reserved.
//

#import "ConfigViewController.h"

@implementation ConfigViewController

@synthesize delegate;

/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        // Custom initialization
    }
    return self;
}
*/

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
	self.title = NSLocalizedString(@"Settings", @"Settings view navigation title");
	UIBarButtonItem *doneButton = [[ UIBarButtonItem alloc ] 
									initWithBarButtonSystemItem: UIBarButtonSystemItemDone 
									target: self 
									action:@selector(done)
									];
	self.navigationItem.leftBarButtonItem = doneButton;
	[doneButton release];
	[self.navigationController setToolbarHidden:NO];
    [super viewDidLoad];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
	/*
	 The number of rows varies by section.
	 */
    NSInteger rows = 0;
    switch (section) {
        case 0:
            rows = 3;
            break;
        case 1:
            rows = 1;
            break;
        default:
            break;
    }
    return rows;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:CellIdentifier] autorelease];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
	// Configure the cell.
	if (indexPath.section == 0) {
		NSString *cellText = nil;
		CGRect frame = CGRectMake(0.0, 0.0, 210.0, 24.0);
		UITextField *textField = [[UITextField alloc] initWithFrame:frame];
		textField.autocorrectionType = UITextAutocorrectionTypeNo;
//		textField.borderStyle = UITextBorderStyleBezel;
//		[textField addTarget:self action:@selector(textChanged:) forControlEvents:UIControlEventValueChanged];

		switch (indexPath.row) {
			case 0:
				cellText = NSLocalizedString(@"Email", @"Email label");
				textField.placeholder = NSLocalizedString(@"you@example.com", @"Email placeholder");
				textField.keyboardType = UIKeyboardTypeEmailAddress;
				break;
			case 1:
				cellText = NSLocalizedString(@"Password", @"Password label");
				textField.secureTextEntry = YES;
				textField.placeholder = NSLocalizedString(@"•••••••••••", @"Password placeholder");
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
	}

    return cell;
}
//- (void) textChanged:(UITextField *)source {
////    self.savedValue = source.text;
//}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    
    NSString *title = nil;
    switch (section) {
        case 0:
            title = NSLocalizedString(@"Account", @"Account section title");
            break;
        case 1:
            title = NSLocalizedString(@"Style", @"Genre section title");
            break;
        default:
            break;
    }
    return title;
}

//@"Enter your email address and a password and then check your email for the confirmation code";


/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}

- (IBAction)done {
	[self.delegate configViewControllerDidFinish:self];	
}

@end

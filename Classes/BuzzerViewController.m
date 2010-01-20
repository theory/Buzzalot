//
//  BuzzerViewController.m
//  Buzzalot
//
//  Created by David E. Wheeler on 1/17/10.
//  Copyright 2010 Kineticode, Inc.. All rights reserved.
//

#import "BuzzerViewController.h"


@implementation BuzzerViewController

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
	// XXX Fill in with the Buzzer's name. The OS automatically truncates as appropriate for the space.
	self.title = NSLocalizedString(@"Theory", @"Buzzer view navigation title");
	UIBarButtonItem *replyItem = [ [ UIBarButtonItem alloc ]
									initWithBarButtonSystemItem: UIBarButtonSystemItemReply
									target: self
									action: nil
									];
	UIBarButtonItem *trashItem = [ [ UIBarButtonItem alloc ]
									initWithBarButtonSystemItem: UIBarButtonSystemItemTrash
									target: self
									action: nil
									];
	UIBarButtonItem *refreshItem = [ [ UIBarButtonItem alloc ]
									initWithBarButtonSystemItem: UIBarButtonSystemItemRefresh
									target: self
									action: nil
									];
	UIBarButtonItem *flexItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];

	[self.navigationController setToolbarHidden:NO];
	[self setToolbarItems: [NSArray arrayWithObjects: refreshItem, flexItem, trashItem, flexItem, replyItem, nil] animated: YES];

	self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
	[replyItem release];
	[flexItem release];
	[refreshItem release];
	[super viewDidLoad];
}

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

@end

//
//  BuzzerViewController.m
//  Buzzalot
//
//  Created by David E. Wheeler on 1/17/10.
//  Copyright 2010 Kineticode, Inc.. All rights reserved.
//

#import "BuzzerViewController.h"

@implementation BuzzerViewController
@synthesize messageCell;

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
//	UIBarButtonItem *refreshItem = [ [ UIBarButtonItem alloc ]
//									initWithBarButtonSystemItem: UIBarButtonSystemItemRefresh
//									target: self
//									action: nil
//									];
	UIBarButtonItem *flexItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];

	[self.navigationController setToolbarHidden:NO];
	[self setToolbarItems: [NSArray arrayWithObjects: trashItem, flexItem, replyItem, nil] animated: YES];

	self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
	[replyItem release];
	[flexItem release];
//	[refreshItem release];
	[super viewDidLoad];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	//	id <NSFetchedResultsSectionInfo> sectionInfo = [[fetchedResultsController sections] objectAtIndex:section];
	//    return [sectionInfo numberOfObjects];
	return 9;
}

// XXX It annoys the shit out of me that the cell can't calculate its height
// itself. Grrr. This method is also called for all of the cells to be
// displayed before cellForRowAtIndexPath is called, so there's no cell to
// look at here, either. I tried to comment this out and get the cell to
// size itself, but that was just ignored. I guess the delegate class here
// should handle populating the cell and determining the size of things?
// It doesn't make much sense to me.
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	CGSize	textSize = { 246.0, 20000.0 };		// width and height of text area
	CGSize size = [[self textForRowAtIndexPath:indexPath] sizeWithFont:[UIFont systemFontOfSize:14.0] constrainedToSize:textSize lineBreakMode:UILineBreakModeWordWrap];
	return size.height + 28;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"MessageCell";
	// XXX Will want to create a custom cell class in order to format the image how I want. This will do for now.
	// http://stackoverflow.com/questions/1812305/how-to-set-the-cell-imageview-frame
	// To transform and store an image, see http://vocaro.com/trevor/blog/2009/10/12/resize-a-uiimage-the-right-way/.
    MessageCell *cell = (MessageCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        [[NSBundle mainBundle] loadNibNamed:cellIdentifier owner:self options:nil];
		cell = self.messageCell;
		self.messageCell = nil;
		[cell configure];
	}

	NSString *body = [self textForRowAtIndexPath:indexPath];

	if (body != nil) {
		[cell setBody:body icon:@"duncan.jpg" on:[NSDate date] fromMe:indexPath.row % 2 == 0];
	}
	return cell;
}

-(NSString *)textForRowAtIndexPath:(NSIndexPath *)indexPath {
	// XXX Switch to use a data store, of course.
	NSString *body = nil;
	switch (indexPath.row) {
		case 0:
			body = @"I'm gonn'a try (but I know zero about pg internals so I'd be surprised if I can help)";
			break;
		case 1:
			body = @"Are you helping with it?";
			break;
		case 2:
			body = @"Okay, thanks. I hope Andrew doesn't get stuck on the GUC problem that currently blocking his progress.";
			break;
		case 3:
			body = @"Enough of us expressed interest that Robert asked two of us to look at something else in the CF. Plus Andrew is aggressively shepherding it.";
			break;
		case 4:
			body = @"I hope you're right. I've not detected \"a lot of interest\" on pgsql-hackers. Seemed like an uphill struggle.";
			break;
		case 5:
			body = @"Yes, I'm going to try. I’m overcommitted these days. :-( There’s a *lot* of interest in your patches, though, so I doubt they’ll fall off.";
			break;
		case 6:
			body = @"Any chance you'd be able to review the plperl changes sometime soonish? I'm concerned that at least some will fall of the end of the 'fest";
			break;
		default:
			break;
	}
	return body;
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

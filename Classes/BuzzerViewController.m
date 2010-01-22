//
//  BuzzerViewController.m
//  Buzzalot
//
//  Created by David E. Wheeler on 1/17/10.
//  Copyright 2010 Kineticode, Inc.. All rights reserved.
//

#import "BuzzerViewController.h"

@implementation BuzzerViewController
@synthesize cellHeight;

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

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	NSLog(@"heightForRowAtIndexPath");
	CGSize	textSize = { 260.0, 20000.0 };		// width and height of text area
	CGSize size = [[self textForRowAtIndexPath:indexPath] sizeWithFont:[UIFont systemFontOfSize:13.0] constrainedToSize:textSize lineBreakMode:UILineBreakModeWordWrap];
	return size.height + 15;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	static NSString *CellIdentifier = @"MessageCell";
	NSLog(@"cellForRowAtIndexPath");
	UITableViewCell	*cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];

    if (cell == nil) {
		cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
		cell.textLabel.font = [UIFont systemFontOfSize:13.0];
		cell.textLabel.numberOfLines = 0;
		cell.textLabel.backgroundColor = [UIColor clearColor];
	}

	NSString *body = [self textForRowAtIndexPath:indexPath];

	if (body != nil) {
		BOOL sent = indexPath.row % 2 == 0;

		CGSize	textSize = { 260.0, 20000.0 };		// width and height of text area
		CGSize size = [body sizeWithFont:[UIFont systemFontOfSize:13.0] constrainedToSize:textSize lineBreakMode:UILineBreakModeWordWrap];

		UIImage *balloon = [[UIImage imageNamed:sent ? @"aqua.png" : @"purple.png"] stretchableImageWithLeftCapWidth:24  topCapHeight:15];
		UIImageView *iv = [[UIImageView alloc] initWithFrame:CGRectMake(sent ? 0 : cell.frame.size.width - size.width - 35, 0.0, size.width+35, size.height+15)];
		UIView *view =[[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, cell.frame.size.width, cell.frame.size.height)];
		[iv setImage:balloon];
		[view addSubview:iv];
		[cell setBackgroundView:view];
		self.cellHeight = size.height;
		
		if (sent) {
			iv.transform = CGAffineTransformMakeScale(-1, 1);
			cell.textLabel.backgroundColor = [UIColor clearColor];
		}

		cell.textLabel.text = body;
	
	}
	//	cell.textLabel.text = @"Howdy";
//	cell.textLabel.backgroundColor = [UIColor clearColor];
	return cell;
}

-(NSString *)textForRowAtIndexPath:(NSIndexPath *)indexPath {
	// XXX Switch to use a data store, of course.
	NSString *body = nil;
	switch (indexPath.row) {
		case 0:
			body = @"Any chance you'd be able to review the plperl changes sometime soonish? I'm concerned that at least some will fall of the end of hte 'fest";
			break;
		case 1:
			body = @"Yes, I'm going to try. I’m overcommitted these days. :-( There’s a *lot* of interest in your patches, though, so I doubt they’ll fall off.";
			break;
		case 2:
			body = @"I hope you're right. I've not detected \"a lot of interest\" on pgsql-hackers. Seemed like an uphill struggle.";
			break;
		case 3:
			body = @"Enough of us expressed interest that Robert asked two of us to look at something else in the CF. Plus Andrew is aggressively shepherding it.";
			break;
		case 4:
			body = @"Okay, thanks. I hope Andrew doesn't get stuck on the GUC problem that currently blocking his progress.";
			break;
		case 5:
			body = @"Are you helping with it?";
			break;
		case 6:
			body = @"I'm gonn'a try (but I know zero about pg internals so I'd be surprised if I can help)";
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

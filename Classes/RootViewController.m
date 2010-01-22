//
//  RootViewController.m
//  Buzzalot
//
//  Created by David E. Wheeler on 1/15/10.
//  Copyright Kineticode, Inc. 2010. All rights reserved.
//

#import "RootViewController.h"
#import "BuzzerViewController.h"
#import "ConfigViewController.h"

@implementation RootViewController

@synthesize fetchedResultsController, managedObjectContext;


#pragma mark -
#pragma mark View lifecycle


- (void)viewDidLoad {
    [super viewDidLoad];
	self.title = NSLocalizedString(@"Buzzalot", @"Master view navigation title");

	// Set up the info and edit and add buttons.
    self.navigationItem.rightBarButtonItem = self.editButtonItem;
	UIButton *modalViewButton = [UIButton buttonWithType:UIButtonTypeInfoLight];
	[modalViewButton addTarget:self action:@selector(showConfig) forControlEvents:UIControlEventTouchUpInside];
	UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithCustomView:modalViewButton];
    self.navigationItem.leftBarButtonItem = addButton;
    [addButton release];

	// Next, lay out the configuration modal window, hooking it up to the info button.
	UIBarButtonItem *composeItem = [ [ UIBarButtonItem alloc ] 
									initWithBarButtonSystemItem: UIBarButtonSystemItemCompose 
									target: self 
									action:@selector(ComposeMessage)
									];
//	UIBarButtonItem *refreshItem = [ [ UIBarButtonItem alloc ] 
//									initWithBarButtonSystemItem: UIBarButtonSystemItemRefresh 
//									target: self 
//									action: @selector(ComposeMessage)
//									];
	// flex item used to separate the left groups items and right grouped items
	UIBarButtonItem *flexItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
																			  target:nil
																			  action:nil];
	self.toolbarItems = [NSArray arrayWithObjects: flexItem, composeItem, nil];
	[self.navigationController setToolbarHidden:NO];
	[composeItem release];
	[flexItem release];
//	[refreshItem release];

	// Set up the back button.
	UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"Buzzers" style:UIBarButtonItemStyleDone target:nil action:nil];
	self.navigationItem.backBarButtonItem = backButton;
	[backButton release];
	
	NSError *error = nil;
	if (![[self fetchedResultsController] performFetch:&error]) {
		/*
		 Replace this implementation with code to handle the error appropriately.
		 
		 abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. If it is not possible to recover from the error, display an alert panel that instructs the user to quit the application by pressing the Home button.
		 */
		NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
		abort();
	}
}

- (IBAction)showConfig { 
	ConfigViewController *configViewController = [[ConfigViewController alloc] initWithStyle:UITableViewStyleGrouped];
	configViewController.delegate = self;
	UINavigationController*  configNavController = [[UINavigationController alloc] initWithRootViewController:configViewController];
	configNavController.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
	[self presentModalViewController:configNavController animated:YES];
	[configViewController release];
	[configNavController release];
}

- (void)configViewControllerDidFinish:(ConfigViewController *)controller {
	[self dismissModalViewControllerAnimated:YES];
}


/*
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}
*/
/*
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}
*/
/*
- (void)viewWillDisappear:(BOOL)animated {
	[super viewWillDisappear:animated];
}
*/
/*
- (void)viewDidDisappear:(BOOL)animated {
	[super viewDidDisappear:animated];
}
*/

- (void)viewDidUnload {
	// Relinquish ownership of anything that can be recreated in viewDidLoad or on demand.
	// For example: self.myOutlet = nil;
}

/*
 // Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	// Return YES for supported orientations.
	return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
 */


- (void)ComposeMessage {
	
}

#pragma mark -
#pragma mark Add a new object

- (void)insertNewObject {

	// Create a new instance of the entity managed by the fetched results controller.
	NSManagedObjectContext *context = [fetchedResultsController managedObjectContext];
	NSEntityDescription *entity = [[fetchedResultsController fetchRequest] entity];
	NSManagedObject *newManagedObject = [NSEntityDescription insertNewObjectForEntityForName:[entity name] inManagedObjectContext:context];
	
	// If appropriate, configure the new managed object.
	[newManagedObject setValue:[NSDate date] forKey:@"timeStamp"];
	
	// Save the context.
    NSError *error = nil;
    if (![context save:&error]) {
		/*
		 Replace this implementation with code to handle the error appropriately.
		 
		 abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. If it is not possible to recover from the error, display an alert panel that instructs the user to quit the application by pressing the Home button.
		 */
		NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
		abort();
    }
}


#pragma mark -
#pragma mark Table view methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [[fetchedResultsController sections] count];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//	id <NSFetchedResultsSectionInfo> sectionInfo = [[fetchedResultsController sections] objectAtIndex:section];
//    return [sectionInfo numberOfObjects];
	return 9;
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
	// XXX Will want to create a custom cell class in order to format the image how I want. This will do for now.
	// http://stackoverflow.com/questions/1812305/how-to-set-the-cell-imageview-frame
	// To transform and store an image, see http://vocaro.com/trevor/blog/2009/10/12/resize-a-uiimage-the-right-way/.
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

		cell.textLabel.font = [UIFont boldSystemFontOfSize:12.0];
		cell.detailTextLabel.font = [UIFont systemFontOfSize:12.0];
		cell.detailTextLabel.numberOfLines = 2;
		cell.detailTextLabel.textColor = [UIColor blackColor];
	}
    
	// Configure the cell.
//	NSManagedObject *managedObject = [fetchedResultsController objectAtIndexPath:indexPath];
//	cell.textLabel.text = [[managedObject valueForKey:@"timeStamp"] description];

	// XXX Replace this with a database query, as above. Probably in its own method.
	switch (indexPath.row) {
		case 0:
			cell.textLabel.text = @"James Duncan Davidson";
			cell.detailTextLabel.text = @"Love to, but I'm sick with a fever right now. Not much fun. :(";
			cell.imageView.image = [UIImage imageNamed:@"duncan.jpg"];
			break;
		case 1:
			cell.textLabel.text = @"Tim Bunce";
			cell.detailTextLabel.text = @"I'm gonn'a try (but I know zero about pg internals so I'd be surprised if I can help)";
			cell.imageView.image = [UIImage imageNamed:@"timbunce.jpg"];
			break;
		case 2:
			cell.textLabel.text = @"Casey West";
			cell.detailTextLabel.text = @"Bah. I'm not going to be around much this afternoon, alas, as I'm taking Anna to the Children’s Museum. Ping me though, maybe I can talk.";
			cell.imageView.image = [UIImage imageNamed:@"caseywest.jpg"];
			break;
		case 3:
			cell.textLabel.text = @"Rick Turoczy";
			cell.detailTextLabel.text = @"Crap.  Thank you. I was really trying not to make that one :(";
			cell.imageView.image = [UIImage imageNamed:@"turoczy.jpg"];
			break;
		case 4:
			cell.textLabel.text = @"Julie Wheeler";
			cell.detailTextLabel.text = @"Gab says 80s nite tomorrow if you want to go.";
			cell.imageView.image = [UIImage imageNamed:@"strongrrl.jpg"];
			break;
		case 5:
			cell.textLabel.text = @"Rick LePage";
			cell.detailTextLabel.text = @"To whom was that directed? I was just about to meet Duncan at Hot Lips.";
			cell.imageView.image = [UIImage imageNamed:@"rlepage.jpg"];
			break;
		case 6:
			cell.textLabel.text = @"Duke Leto";
			cell.detailTextLabel.text = @"my g # is  209.691.3853 aka 209.691.DUKE :)";
			cell.imageView.image = [UIImage imageNamed:@"dukeleto.jpg"];
			break;
		case 7:
			cell.textLabel.text = @"Pete Krawczyk";
			cell.detailTextLabel.text = @"RJBS has sent me one. Thanks!";
			cell.imageView.image = [UIImage imageNamed:@"sachmet.jpg"];
			break;
		case 8:
			cell.textLabel.text = @"Gordon Meyer";
			cell.detailTextLabel.text = @"I have an invite, d me your email address.";
			cell.imageView.image = [UIImage imageNamed:@"gordonmeyer.jpg"];
			break;
		default:
			break;
	}

	
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	return 60.0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	// Create and push a correspondent view controller.
	BuzzerViewController *buzzerViewController = [BuzzerViewController alloc];
	// Pass the selected object to the new view controller.
	[self.navigationController pushViewController:buzzerViewController animated:YES];
	[buzzerViewController release];
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/


// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the managed object for the given index path
		NSManagedObjectContext *context = [fetchedResultsController managedObjectContext];
		[context deleteObject:[fetchedResultsController objectAtIndexPath:indexPath]];
		
		// Save the context.
		NSError *error = nil;
		if (![context save:&error]) {
			/*
			 Replace this implementation with code to handle the error appropriately.
			 
			 abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. If it is not possible to recover from the error, display an alert panel that instructs the user to quit the application by pressing the Home button.
			 */
			NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
			abort();
		}
	}   
}


- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // The table view should not be re-orderable.
    return NO;
}


#pragma mark -
#pragma mark Fetched results controller

- (NSFetchedResultsController *)fetchedResultsController {
    
    if (fetchedResultsController != nil) {
        return fetchedResultsController;
    }
    
    /*
	 Set up the fetched results controller.
	*/
	// Create the fetch request for the entity.
	NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
	// Edit the entity name as appropriate.
	NSEntityDescription *entity = [NSEntityDescription entityForName:@"Event" inManagedObjectContext:managedObjectContext];
	[fetchRequest setEntity:entity];
	
	// Set the batch size to a suitable number.
	[fetchRequest setFetchBatchSize:20];
	
	// Edit the sort key as appropriate.
	NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"timeStamp" ascending:NO];
	NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];
	
	[fetchRequest setSortDescriptors:sortDescriptors];
	
	// Edit the section name key path and cache name if appropriate.
    // nil for section name key path means "no sections".
	NSFetchedResultsController *aFetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:managedObjectContext sectionNameKeyPath:nil cacheName:@"Root"];
    aFetchedResultsController.delegate = self;
	self.fetchedResultsController = aFetchedResultsController;
	
	[aFetchedResultsController release];
	[fetchRequest release];
	[sortDescriptor release];
	[sortDescriptors release];
	
	return fetchedResultsController;
}    


// NSFetchedResultsControllerDelegate method to notify the delegate that all section and object changes have been processed. 
- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
	// In the simplest, most efficient, case, reload the table view.
	[self.tableView reloadData];
}

/*
 Instead of using controllerDidChangeContent: to respond to all changes, you can implement all the delegate methods to update the table view in response to individual changes.  This may have performance implications if a large number of changes are made simultaneously.

// Notifies the delegate that section and object changes are about to be processed and notifications will be sent. 
- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller {
	[self.tableView beginUpdates];
}

- (void)controller:(NSFetchedResultsController *)controller didChangeSection:(id <NSFetchedResultsSectionInfo>)sectionInfo atIndex:(NSUInteger)sectionIndex forChangeType:(NSFetchedResultsChangeType)type {
	// Update the table view appropriately.
}

- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type newIndexPath:(NSIndexPath *)newIndexPath {
	// Update the table view appropriately.
}

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
	[self.tableView endUpdates];
} 
 */


#pragma mark -
#pragma mark Memory management

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
	// Relinquish ownership of any cached data, images, etc that aren't in use.
}


- (void)dealloc {
	[fetchedResultsController release];
	[managedObjectContext release];
    [super dealloc];
}


@end


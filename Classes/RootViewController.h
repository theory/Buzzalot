//
//  RootViewController.h
//  Buzzalot
//
//  Created by David E. Wheeler on 1/15/10.
//  Copyright Kineticode, Inc. 2010. All rights reserved.
//

#import "ConfigViewController.h"
#import "BuzzerCell.h"

@interface RootViewController : UITableViewController <NSFetchedResultsControllerDelegate, ConfigViewControllerDelegate> {
	NSFetchedResultsController *fetchedResultsController;
	NSManagedObjectContext *managedObjectContext;
	BuzzerCell *buzzerCell;
}

@property (nonatomic, retain) NSFetchedResultsController *fetchedResultsController;
@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, assign) IBOutlet BuzzerCell *buzzerCell;

- (IBAction)showConfig;

@end

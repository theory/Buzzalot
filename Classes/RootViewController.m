//
//  RootViewController.m
//  Buzzalot
//
//  Created by David E. Wheeler on 2/2/10.
//  Copyright 2010 Kineticode, Inc.. All rights reserved.
//

#import "RootViewController.h"
#import "BuzzerCell.h"
#import "ConfigViewController.h"
#import "BuzzerViewController.h"
#import "BuzzalotAppDelegate.h"
#import "BuzzerModel.h"

@implementation RootViewController
@synthesize buzzers;

- (void)viewDidLoad {
	self.title = NSLocalizedString(@"Buzzalot", nil);
	UIButton *modalViewButton = [UIButton buttonWithType:UIButtonTypeInfoLight];
	[modalViewButton addTarget:self action:@selector(showConfig) forControlEvents:UIControlEventTouchUpInside];
	UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithCustomView:modalViewButton];
    self.navigationItem.leftBarButtonItem = addButton;
    [addButton release];

	UIBarButtonItem *composeItem = [ [ UIBarButtonItem alloc ] 
									initWithBarButtonSystemItem: UIBarButtonSystemItemCompose 
									target: self 
									action: @selector(compose)
									];
    self.navigationItem.rightBarButtonItem = composeItem;
    [composeItem release];

	// Set up the back button.
	UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"Buzzers" style:UIBarButtonItemStyleDone target:nil action:nil];
	self.navigationItem.backBarButtonItem = backButton;
	[backButton release];

    // Load the data and go!
    self.buzzers = [BuzzerModel selectBuzzers];
    [super viewDidLoad];
}

- (void)viewDidUnload {
//    self.buzzers = nil;
}

- (void)dealloc {
    [buzzers release];
    [super dealloc];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown;
}

- (void)showConfig { 
	ConfigViewController *configViewController = [[ConfigViewController alloc] init];
	configViewController.delegate = self;
	UINavigationController *configNavController = [[UINavigationController alloc] initWithRootViewController:configViewController];
	configNavController.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
	[self presentModalViewController:configNavController animated:YES];
    [configViewController release];
	[configNavController release];
}

- (void)configViewControllerDidFinish:(ConfigViewController *)controller {
	[self dismissModalViewControllerAnimated:YES];
}

- (void)compose {
    // TODO: Add code to bring up compose window.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.buzzers count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    CGSize size = [((BuzzerModel *) [self.buzzers objectAtIndex:indexPath.row]).body
             sizeWithFont:[UIFont systemFontOfSize:14.0]
        constrainedToSize:CGSizeMake(kBuzzerBodyWidth, 2000)
    ];
    return MAX(size.height + kBuzzerBodyY + 6, 60);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"BuzzerCell";

    BuzzerCell *cell = (BuzzerCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[BuzzerCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

    }

    cell.buzzer = [self.buzzers objectAtIndex:indexPath.row];

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
    // TODO: Why does releasing buzzerViewController cause a crash?
     BuzzerViewController *buzzerViewController = [BuzzerViewController alloc];
    [buzzerViewController initWithBuzzer: (BuzzerModel *)[self.buzzers objectAtIndex:indexPath.row]];
	[self.navigationController pushViewController:buzzerViewController animated:YES];
}

- (void)tableView:(UITableView *)tableView
        commitEditingStyle:(UITableViewCellEditingStyle)editingStyle
        forRowAtIndexPath:(NSIndexPath *)indexPath
{
    BuzzerModel *buzzer = [self.buzzers objectAtIndex:indexPath.row];
    [buzzer deleteBuzzer];
    [self.buzzers removeObjectAtIndex:indexPath.row];
    [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation: UITableViewRowAnimationFade];
}

@end

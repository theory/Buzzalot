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

@implementation RootViewController
@synthesize buzzers, buzzerViewController;

- (void)initBuzzerData {
    sqlite3 *db = [BuzzalotAppDelegate getDBConnection];
    sqlite3_stmt *statement;
    NSString *email, *name, *body, *when;
    BOOL from_me;
    NSDictionary *data;
    // TODO: Replace with address book lookup/local cache.
    NSDictionary *icons = [[NSDictionary alloc] initWithObjectsAndKeys:
                           @"duncan.jpg",      @"duncan@duncandavidson.com",
                           @"timbunce.jpg",    @"Tim.Bunce@pobox.com",
                           @"caseywest.jpg",   @"casey@geeknest.com",
                           @"strongrrl.jpg",   @"julie@strongrrl.com",
                           @"turoczy.jpg",     @"siliconflorist@gmail.com",
                           @"gordonmeyer.jpg", @"gmeyer@apple.com",
                           @"dukeleto.jpg",    @"duke@leto.com",
                           @"rlepage.jpg",     @"rick@lepage.com",
                           @"sachmet.jpg",     @"pete@krawczyk.com",
                           nil ];
    if (sqlite3_prepare_v2(db, "SELECT email, name, from_me, body, sent_at FROM most_recent ORDER BY sent_at DESC", -1, &statement, nil) == SQLITE_OK ) {
        while (sqlite3_step(statement) == SQLITE_ROW) {
            email = [[NSString alloc] initWithUTF8String:(char *)sqlite3_column_text(statement, 0)];
            name  = [[NSString alloc] initWithUTF8String:(char *)sqlite3_column_text(statement, 1)];
            from_me = sqlite3_column_int(statement, 2) == 1;
            body  = [[NSString alloc] initWithUTF8String:(char *)sqlite3_column_text(statement, 3)];
            when  = [[NSString alloc] initWithUTF8String:(char *)sqlite3_column_text(statement, 4)];
            data = [[NSDictionary alloc] initWithObjectsAndKeys:
                    email, @"email",
                    name, @"name",
                    body, @"body",
                    from_me ? @"yes" : @"no", @"from_me",
                    when, @"when",
                    [icons objectForKey:email], @"icon",
                    nil ];
            [buzzers addObject: data];
        }
        sqlite3_finalize(statement);
    }
    [email release];
    [name release];
    [body release];
    [when release];
    [data release];  
    [icons release];
}

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

	// Set up the back button.
	UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"Buzzers" style:UIBarButtonItemStyleDone target:nil action:nil];
	self.navigationItem.backBarButtonItem = backButton;
	[backButton release];

    // Load the data and go!
    self.buzzers = [[NSMutableArray alloc] init];
    [self initBuzzerData];
    [super viewDidLoad];
}

- (void)viewDidUnload {
//    self.buzzers = nil;
    [buzzerViewController release];
    self.buzzerViewController = nil;
}

- (void)dealloc {
    [buzzers release];
    [buzzerViewController release];
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
    NSString *body = [[self.buzzers objectAtIndex:indexPath.row] objectForKey:@"body"];
    CGSize size = [body sizeWithFont:[UIFont systemFontOfSize:14.0] constrainedToSize:CGSizeMake(kBuzzerBodyWidth, 2000)];
    return MAX(size.height + kBuzzerBodyY + 6, 60);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"BuzzerCell";

    BuzzerCell *cell = (BuzzerCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[BuzzerCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

    }

    NSDictionary *buzzer = [self.buzzers objectAtIndex:indexPath.row];
    cell.buzzerName = [buzzer objectForKey:@"name"];
    cell.bodyText   = [buzzer objectForKey:@"body"];
    cell.iconName   = [buzzer objectForKey:@"icon"];
    cell.whenText   = [buzzer objectForKey:@"when"];

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (buzzerViewController == nil)
        buzzerViewController = [BuzzerViewController alloc];
    buzzerViewController.title = [[self.buzzers objectAtIndex:indexPath.row] objectForKey:@"name"];
	[self.navigationController pushViewController:buzzerViewController animated:YES];
}

- (void)tableView:(UITableView *)tableView
        commitEditingStyle:(UITableViewCellEditingStyle)editingStyle
        forRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.buzzers removeObjectAtIndex:indexPath.row];
    [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation: UITableViewRowAnimationFade];
}

@end

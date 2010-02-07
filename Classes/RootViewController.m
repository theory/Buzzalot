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

@implementation RootViewController
@synthesize buzzers, buzzerViewController;

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

    NSDictionary *duncan = [[NSDictionary alloc] initWithObjectsAndKeys:
                            @"James Duncan Davidson", @"name",
                            @"Love to, but I'm sick with a fever right now. Not much fun. :(", @"body",
                            @"duncan.jpg", @"icon",
                            @"15 secs", @"when",
                            nil ];
    NSDictionary *tim = [[NSDictionary alloc] initWithObjectsAndKeys:
                         @"Tim Bunce", @"name",
                         @"I'm gonna try (but I know zero about pg internals so I'd be surprised if I can help)", @"body",
                         @"timbunce.jpg", @"icon",
                         @"38 mins", @"when",
                         nil ];

    NSDictionary *casey = [[NSDictionary alloc] initWithObjectsAndKeys:
                           @"Casey West", @"name",
                           @"Bah. I'm not going to be around much this afternoon, alas, as I'm taking Anna to the Children’s Museum. Ping me though, maybe I can talk.", @"body",
                           @"caseywest.jpg", @"icon",
                           @"1 hour", @"when",
                           nil ];

    NSDictionary *rick = [[NSDictionary alloc] initWithObjectsAndKeys:
                          @"Rick Turoczy", @"name",
                          @"Crap.  Thank you. I was really trying not to make that one :(", @"body",
                          @"turoczy.jpg", @"icon",
                          @"4 hours", @"when",
                          nil ];
    NSDictionary *julie = [[NSDictionary alloc] initWithObjectsAndKeys:
                           @"Julie Wheeler", @"name",
                           @"Gab says 80s nite tomorrow if you want to go.", @"body",
                           @"strongrrl.jpg", @"icon",
                           @"yesterday", @"when",
                           nil ];
    NSDictionary *lepage = [[NSDictionary alloc] initWithObjectsAndKeys:
                            @"Rick LePage", @"name",
                            @"To whom was that directed? I was just about to meet Duncan at Hot Lips.", @"body",
                            @"rlepage.jpg", @"icon",
                            @"Saturday", @"when",
                            nil ];
    NSDictionary *duke = [[NSDictionary alloc] initWithObjectsAndKeys:
                          @"Duke Leto", @"name",
                          @"my g # is  209.691.3853 aka 209.691.DUKE :)", @"body",
                          @"dukeleto.jpg", @"icon",
                          @"1/28/10", @"when",
                          nil ];
    NSDictionary *pete = [[NSDictionary alloc] initWithObjectsAndKeys:
                          @"Pete Krawczyk", @"name",
                          @"RJBS has sent me one. Thanks!", @"body",
                          @"sachmet.jpg", @"icon",
                          @"1/15/10 ", @"when",
                          nil ];
    NSDictionary *gord = [[NSDictionary alloc] initWithObjectsAndKeys:
                          @"Gordon Meyer", @"name",
                          @"I have an invite, d me your email address.", @"body",
                          @"gordonmeyer.jpg", @"icon",
                          @"12/19/09", @"when",
                          nil ];
    
    NSMutableArray *array = [[NSMutableArray alloc] initWithObjects:duncan, tim, casey, rick, julie, lepage, duke, pete, gord, nil];
    self.buzzers = array;
    
    [duncan release];
    [tim release];
    [casey release];
    [rick release];
    [julie release];
    [lepage release];
    [duke release];
    [pete release];
    [gord release];
    [array release];

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

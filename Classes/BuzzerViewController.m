//
//  BuzzerViewController.m
//  Buzzalot
//
//  Created by David E. Wheeler on 2/4/10.
//  Copyright 2010 Kineticode, Inc.. All rights reserved.
//

#import "BuzzerViewController.h"
#import "MessageCell.h"

@implementation BuzzerViewController
@synthesize messages;

- (void)viewDidLoad {
	self.title = NSLocalizedString(@"Tim Bunce", nil);
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;

    UIBarButtonItem *replyItem = [ [ UIBarButtonItem alloc ]
                                  initWithBarButtonSystemItem: UIBarButtonSystemItemReply
                                  target: self
                                  action: @selector(reply)
                                  ];
    self.navigationItem.rightBarButtonItem = replyItem;
	[replyItem release];

    NSDictionary *m0 = [[NSDictionary alloc] initWithObjectsAndKeys:
                          @"Actually that's plperlu. I'll ponder plperl more carefully and formulate a reply email.", @"body",
                          @"no", @"from_me",
                          @"10 minutes ago", @"when",
                          nil ];
    NSDictionary *m1 = [[NSDictionary alloc] initWithObjectsAndKeys:
                        @"a. Don't tell me! b. Reach me on IRC.", @"body",
                        @"yes", @"from_me",
                        @"15 minutes ago", @"when",
                        nil ];
    NSDictionary *m2 = [[NSDictionary alloc] initWithObjectsAndKeys:
                        @"Sure, there's nothing to stop plperl (or pltcl or plpython) closing file descriptors for example.", @"body",
                        @"no", @"from_me",
                        @"18 minutes ago", @"when",
                        nil ];
    NSDictionary *m3 = [[NSDictionary alloc] initWithObjectsAndKeys:
                       @"Andrew says see http://anoncvs.postgresql.org/cvsweb.cgi/pgsql/src/pl/plperl/plperl.c, rev 1.101.", @"body",
                       @"yes", @"from_me",
                       @"20 minutes ago", @"when",
                       nil ];
    NSDictionary *m4 = [[NSDictionary alloc] initWithObjectsAndKeys:
                       @"You need to address his complaints about Perl messing with PostgreSQL's internals. I asked for links to specific examples.", @"body",
                       @"yes", @"from_me",
                       @"21 minutes ago", @"when",
                       nil ];
    NSDictionary *m5 = [[NSDictionary alloc] initWithObjectsAndKeys:
                       @"Hi David. Any thoughts on Toms position re on_perl_init and END?", @"body",
                       @"no", @"from_me",
                       @"1 hour ago", @"when",
                       nil ];
    NSDictionary *m6 = [[NSDictionary alloc] initWithObjectsAndKeys:
                       @"I'm gonn'a try (but I know zero about pg internals so I'd be surprised if I can help)", @"body",
                       @"no", @"from_me",
                       @"2 days ago", @"when",
                       nil ];
    NSDictionary *m7 = [[NSDictionary alloc] initWithObjectsAndKeys:
                       @"Are you helping with it?", @"body",
                       @"yes", @"from_me",
                       @"2 days ago", @"when",
                       nil ];
    NSDictionary *m8 = [[NSDictionary alloc] initWithObjectsAndKeys:
                       @"Okay, thanks. I hope Andrew doesn't get stuck on the GUC problem that currently blocking his progress.", @"body",
                       @"no", @"from_me",
                       @"2 days ago", @"when",
                       nil ];
    NSDictionary *m9 = [[NSDictionary alloc] initWithObjectsAndKeys:
                       @"Enough of us expressed interest that Robert asked two of us to look at something else in the CF. Plus Andrew is aggressively shepherding it.", @"body",
                       @"yes", @"from_me",
                       @"2 days ago", @"when",
                       nil ];
    NSDictionary *m10 = [[NSDictionary alloc] initWithObjectsAndKeys:
                       @"I hope you're right. I've not detected \"a lot of interest\" on pgsql-hackers. Seemed like an uphill struggle.", @"body",
                       @"no", @"from_me",
                       @"22 days ago", @"when",
                       nil ];
    NSDictionary *m11 = [[NSDictionary alloc] initWithObjectsAndKeys:
                       @"Yes, I'm going to try. I’m overcommitted these days. :-( There’s a *lot* of interest in your patches, though, so I doubt they’ll fall off.", @"body",
                       @"yes", @"from_me",
                       @"23 days ago", @"when",
                       nil ];
    NSDictionary *m12 = [[NSDictionary alloc] initWithObjectsAndKeys:
                       @"Any chance you'd be able to review the plperl changes sometime soonish? I'm concerned that at least some will fall off the end of the 'fest", @"body",
                       @"no", @"from_me",
                       @"23 days ago", @"when",
                       nil ];
    NSArray *array = [[NSArray alloc] initWithObjects:m0, m1, m2, m3, m4, m5, m6, m7, m8, m9, m10, m11, m12, nil];
    self.messages = array;

    [m0 release];
    [m1 release];
    [m2 release];
    [m3 release];
    [m4 release];
    [m5 release];
    [m6 release];
    [m7 release];
    [m8 release];
    [m9 release];
    [m10 release];
    [m11 release];
    [m12 release];
    [array release];
}

- (void)viewDidUnload {
	self.messages = nil;
}

- (void)dealloc {
	[messages release];
    [super dealloc];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown;
}

- (void) reply {
    // TODO: Bring up screen to edit and send message.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.messages count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *body = [[self.messages objectAtIndex:indexPath.row] objectForKey:@"body"];
    CGSize size = [body sizeWithFont:[UIFont systemFontOfSize:14.0] constrainedToSize:CGSizeMake(kBubbleBodyWidth, 2000)];
    return MAX(size.height + kBubbleBodyY + 6, 60);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"MessageCell";
    
    MessageCell *cell = (MessageCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[MessageCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    NSDictionary *buzzer = [self.messages objectAtIndex:indexPath.row];
    cell.bodyText = [buzzer objectForKey:@"body"];
    cell.whenText = [buzzer objectForKey:@"when"];
    cell.fromMe = [buzzer objectForKey:@"from_me"] == @"yes";
    [cell setIconName:cell.fromMe ? @"theory.jpg" : @"timbunce.jpg"];
        
    return cell;
}

@end

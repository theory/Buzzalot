//
//  BuzzerViewController.m
//  Buzzalot
//
//  Created by David E. Wheeler on 2/4/10.
//  Copyright 2010 Kineticode, Inc.. All rights reserved.
//

#import "BuzzerViewController.h"
#import "MessageCell.h"
#import "BuzzerModel.h"
#import "MessageModel.h"
#import "IconFinder.h"
#import "BuzzalotAppDelegate.h"
#import "MyColors.h"
#import "UIViewController+Composer.h"

@implementation BuzzerViewController
@synthesize messages, myIcon, yourIcon, buzzer;

static float textWidth;

+ (void)initialize {
    if (self == [BuzzerViewController class]) {
        textWidth = [[UIScreen mainScreen] bounds].size.width - kBubbleTextWidthBuffer;
	}
}


- (void) initWithBuzzer:(BuzzerModel *)b {
    self.buzzer = b;
    self.title = buzzer.name;
    self.yourIcon = [IconFinder getForEmail:buzzer.email];
    self.myIcon = [IconFinder getForEmail:[[NSUserDefaults standardUserDefaults] stringForKey:kPrimaryEmailKey]];
    [self.messages release];
    self.messages = [MessageModel selectForBuzzer:buzzer];
}

- (void)viewDidLoad {
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;

    UIBarButtonItem *replyItem = [ [ UIBarButtonItem alloc ]
                                  initWithBarButtonSystemItem: UIBarButtonSystemItemReply
                                  target: self
                                  action: @selector(reply)
                                  ];
    self.navigationItem.rightBarButtonItem = replyItem;
    self.tableView.backgroundColor = [UIColor tweetieBlue];
	[replyItem release];
    [super viewDidLoad];
}

- (void)viewDidUnload {
	self.messages = nil;
    self.myIcon   = nil;
    self.yourIcon = nil;
    self.buzzer   = nil;
    [super viewDidUnload];
}

- (void)dealloc {
	[messages release];
    [myIcon   release];
    [yourIcon release];
    [buzzer   release];
    [super dealloc];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown;
}

- (void) reply {
    [self presentComposer];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.messages count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    CGSize size = [((MessageModel *) [self.messages objectAtIndex:indexPath.row]).body sizeWithFont:[UIFont systemFontOfSize:14.0] constrainedToSize:CGSizeMake(textWidth, 2000)];
    return MAX(size.height + kBubbleBodyY + 6, 60);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"MessageCell";
    
    MessageCell *cell = (MessageCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[MessageCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }

    cell.message = [self.messages objectAtIndex:indexPath.row];
    cell.icon = cell.message.fromMe ? self.myIcon : self.yourIcon;
    return cell;
}

- (void)tableView:(UITableView *)tableView
commitEditingStyle:(UITableViewCellEditingStyle)editingStyle
forRowAtIndexPath:(NSIndexPath *)indexPath
{
    //    if (editingStyle == UITableViewCellEditingStyleDelete) {
    MessageModel *message = [self.messages objectAtIndex:indexPath.row];
    [message deleteMessage];
    [self.messages removeObjectAtIndex:indexPath.row];
    [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation: UITableViewRowAnimationFade];
    //    }
}

@end

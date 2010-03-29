//
//  ComposeViewController.m
//  Buzzalot
//
//  Created by David E. Wheeler on 3/14/10.
//  Copyright 2010 Kineticode, Inc.. All rights reserved.
//

#import "ComposeViewController.h"

@implementation ComposeViewController
@synthesize delegate, bodyField, closeButton, sendButton, recipient;

/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
 - (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
 if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
 // Custom initialization
 }
 return self;
 }
 */

 - (void)loadView {
     self.view = [[UIView alloc]initWithFrame:[[UIScreen mainScreen] bounds]];
     self.view.backgroundColor = [UIColor whiteColor];
 }

- (void)viewDidLoad {
    [super viewDidLoad];

    CGSize size = [[UIScreen mainScreen] bounds].size;
    UINavigationBar *navBar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 0, size.width, 44)];
    [navBar pushNavigationItem:[[UINavigationItem alloc]initWithTitle:@"Send"]animated:NO];
    [self.view addSubview:navBar];

	self.closeButton = [[ UIBarButtonItem alloc ]
                        initWithTitle:@"Close" style:UIBarButtonItemStylePlain
                        target: self
                        action:@selector(closeButtonTapped)
                        ];
    navBar.topItem.leftBarButtonItem = closeButton;

    self.sendButton = [[ UIBarButtonItem alloc ]
                        initWithTitle:@"Send" style:UIBarButtonItemStylePlain
                        target: self
                        action:@selector(sendButtonTapped)
                        ];
    sendButton.enabled = NO;
    navBar.topItem.rightBarButtonItem = sendButton;
    
    [navBar release];

    self.bodyField = [[UITextView alloc] initWithFrame:CGRectMake(5, 49, size.width - 10, 220)];

    bodyField.autocapitalizationType = UITextAutocapitalizationTypeSentences;
    bodyField.font = [UIFont systemFontOfSize:17]; // XXX Should be default, why isn't it?
    [bodyField becomeFirstResponder];
    [self.view addSubview:bodyField];

}

/*
 // Override to allow orientations other than the default portrait orientation.
 - (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
 // Return YES for supported orientations
 return (interfaceOrientation == UIInterfaceOrientationPortrait);
 }
 */

- (void)viewDidUnload {
    self.closeButton = nil;
    self.sendButton  = nil;
    self.bodyField   = nil;
}


- (void)dealloc {
    [closeButton dealloc];
    [sendButton  dealloc];
    [bodyField   dealloc];
    [super dealloc];
}

- (void)closeButtonTapped {
	[self.delegate composeViewControllerDidFinish:self];
}

- (void)sendButtonTapped {
	[self.delegate composeViewControllerDidFinish:self];
}

@end

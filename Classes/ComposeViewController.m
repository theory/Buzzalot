//
//  ComposeViewController.m
//  Buzzalot
//
//  Created by David E. Wheeler on 3/14/10.
//  Copyright 2010 Kineticode, Inc.. All rights reserved.
//

#import "ComposeViewController.h"

@implementation ComposeViewController
@synthesize delegate, toField, bodyField, closeButton, sendButton, recipient;

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
    CGSize size = [[UIScreen mainScreen] bounds].size;
    UINavigationBar *navBar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 0, size.width, 44)];
//    [navBar pushNavigationItem:[[UINavigationItem alloc]initWithTitle:[NSString stringWithFormat:@"To %@", self.recipient.name]]animated:NO];
    [navBar pushNavigationItem:[[UINavigationItem alloc]initWithTitle:@"New Message"]animated:NO];
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

    self.toField = [[UITextField alloc] initWithFrame:CGRectMake(5, 53, size.width - 10, 22)];
    toField.returnKeyType = UIReturnKeyNext;
    toField.text = self.recipient.name;
//    toField.autoresizingMask = UIViewAutoresizingFlexibleWidth;
//    [toField sizeToFit];

    UILabel *toLabel = [[UILabel alloc] init];
    toLabel.text = @"To:";
    toLabel.textColor = [UIColor grayColor];
    [toLabel sizeToFit];
    toLabel.frame = CGRectInset(toLabel.frame, -2, 0);
    toField.leftView = toLabel;
    toField.leftViewMode = UITextFieldViewModeAlways;
    [toLabel release];

    [self.view addSubview:toField];

    UIView* separator = [[UIView alloc] initWithFrame:CGRectMake(0, 82, size.width, 1)];
    separator.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:separator];
    [separator release];
    
    self.bodyField = [[UITextView alloc] initWithFrame:CGRectMake(5, 87, size.width - 10, 180)];
    bodyField.autocapitalizationType = UITextAutocapitalizationTypeSentences;
    bodyField.font = [UIFont systemFontOfSize:17]; // XXX Should be default, why isn't it?
    bodyField.delegate = self;
    [self.view addSubview:bodyField];

    if (self.recipient) [bodyField becomeFirstResponder];
    else [toField becomeFirstResponder];


    [super viewDidLoad];
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
    self.recipient   = nil;
}


- (void)dealloc {
    [closeButton release];
    [sendButton  release];
    [bodyField   release];
    [recipient   release];
    [super dealloc];
}

- (void)closeButtonTapped {
	[self.delegate composeViewControllerDidFinish:self];
}

- (void)sendButtonTapped {
	[self.delegate composeViewControllerDidFinish:self];
}

@end

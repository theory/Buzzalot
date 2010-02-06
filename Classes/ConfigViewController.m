//
//  ConfigViewController.m
//  Buzzalot
//
//  Created by David E. Wheeler on 2/4/10.
//  Copyright 2010 Kineticode, Inc.. All rights reserved.
//

#import "ConfigViewController.h"

@implementation ConfigViewController
@synthesize delegate;

- (void)viewDidLoad {
	self.title = NSLocalizedString(@"Settings", nil);
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];

	UIBarButtonItem *doneButton = [[ UIBarButtonItem alloc ] 
                                   initWithBarButtonSystemItem: UIBarButtonSystemItemDone 
                                   target: self 
                                   action:@selector(done)
                                   ];
	self.navigationItem.leftBarButtonItem = doneButton;
	[doneButton release];

    CGContextRef context = UIGraphicsGetCurrentContext();
    
    //	[self.navigationController setToolbarHidden:NO];
    [super viewDidLoad];
}

- (void)viewDidUnload {
    // self.foo = nil
}

//- (void)loadView {
//    self.view = [[UIView alloc] init];
//}
//- (void)drawRect:(CGRect)r {
//	UIColor *backgroundColor = [UIColor whiteColor];
//    [backgroundColor set];
//}

- (void)dealloc {
    // [foo release];
    [super dealloc];
}

- (void)done {
	[self.delegate configViewControllerDidFinish:self];	
}

@end

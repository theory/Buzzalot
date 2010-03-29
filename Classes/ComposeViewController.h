//
//  ComposeViewController.h
//  Buzzalot
//
//  Created by David E. Wheeler on 3/14/10.
//  Copyright 2010 Kineticode, Inc.. All rights reserved.
//

@interface ComposeViewController : UIViewController {
    UIBarButtonItem *closeButton;
    UIBarButtonItem *sendButton;
    UITextView      *bodyField;
}

@property (nonatomic, retain) UIBarButtonItem *closeButton;
@property (nonatomic, retain) UIBarButtonItem *sendButton;
@property (nonatomic, retain) UITextView      *bodyField;

- (void)closeButtonTapped;
- (void)sendButtonTapped;

@end

//
//  ComposeViewController.h
//  Buzzalot
//
//  Created by David E. Wheeler on 3/14/10.
//  Copyright 2010 Kineticode, Inc.. All rights reserved.
//

typedef struct recipient {
    NSString *name;
    NSString *email;
} recipient;

@protocol ComposeViewControllerDelegate;

@interface ComposeViewController : UIViewController {
	id <ComposeViewControllerDelegate> delegate;
    UIBarButtonItem *closeButton;
    UIBarButtonItem *sendButton;
    UITextView      *bodyField;
    recipient       *recipient;
}

@property (nonatomic, assign) id <ComposeViewControllerDelegate> delegate;
@property (nonatomic, retain) UIBarButtonItem *closeButton;
@property (nonatomic, retain) UIBarButtonItem *sendButton;
@property (nonatomic, retain) UITextView      *bodyField;
@property                     recipient       *recipient;

- (void)closeButtonTapped;
- (void)sendButtonTapped;

@end

@protocol ComposeViewControllerDelegate

- (void)composeViewControllerDidFinish:(ComposeViewController *)controller;

@end

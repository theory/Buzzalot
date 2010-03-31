//
//  ComposeViewController.h
//  Buzzalot
//
//  Created by David E. Wheeler on 3/14/10.
//  Copyright 2010 Kineticode, Inc.. All rights reserved.
//

#include "BuzzerModel.h"

@protocol ComposeViewControllerDelegate;

@interface ComposeViewController : UIViewController <UITextViewDelegate> {
	id <ComposeViewControllerDelegate> delegate;
    UIBarButtonItem *closeButton;
    UIBarButtonItem *sendButton;
    UITextView      *bodyField;
    BuzzerModel     *recipient;
}

@property (nonatomic, assign) id <ComposeViewControllerDelegate> delegate;
@property (nonatomic, retain) UIBarButtonItem *closeButton;
@property (nonatomic, retain) UIBarButtonItem *sendButton;
@property (nonatomic, retain) UITextView      *bodyField;
@property (nonatomic, retain) BuzzerModel     *recipient;

- (void)closeButtonTapped;
- (void)sendButtonTapped;

@end

@protocol ComposeViewControllerDelegate

- (void)composeViewControllerDidFinish:(ComposeViewController *)controller;

@end

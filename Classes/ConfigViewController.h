//
//  ConfigViewController.h
//  Buzzalot
//
//  Created by David E. Wheeler on 2/4/10.
//  Copyright 2010 Kineticode, Inc.. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ConfigViewControllerDelegate;

@interface ConfigViewController : UIViewController {
	id <ConfigViewControllerDelegate> delegate;

}

@property (nonatomic, assign) id <ConfigViewControllerDelegate> delegate;
- (void)done;

@end

@protocol ConfigViewControllerDelegate

- (void)configViewControllerDidFinish:(ConfigViewController *)controller;

@end

//
//  ComposerProxy.h
//  three20test
//
//  Created by David E. Wheeler on 4/15/10.
//  Copyright 2010 Kineticode, Inc.. All rights reserved.
//


#import <AddressBookUI/AddressBookUI.h>
#import "Three20/TTMessageController.h"

@interface ComposerProxy : NSObject <TTMessageControllerDelegate, ABPeoplePickerNavigationControllerDelegate> {
    UIViewController *controller;
}

@property (nonatomic, retain) UIViewController *controller;

- (id) initWithController:(UIViewController *)c;
- (void) go;

@end

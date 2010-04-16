//
//  ComposerProxy.h
//  three20test
//
//  Created by David E. Wheeler on 4/15/10.
//  Copyright 2010 Kineticode, Inc.. All rights reserved.
//


#import <AddressBookUI/AddressBookUI.h>
#import "Three20/TTMessageController.h"

@interface UIViewController (Composer) <TTMessageControllerDelegate, ABPeoplePickerNavigationControllerDelegate>

- (void) presentComposer;
//- (void) presentComposerWithRecipient;

@end

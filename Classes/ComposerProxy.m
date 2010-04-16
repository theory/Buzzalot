//
//  ComposerProxy.m
//  three20test
//
//  Created by David E. Wheeler on 4/15/10.
//  Copyright 2010 Kineticode, Inc.. All rights reserved.
//

#import "ComposerProxy.h"
#import "Three20/TTMessageController.h"
#import "ABSearchSource.h"

@implementation ComposerProxy
@synthesize controller;

- (id) initWithController:(UIViewController *)c {
    if (self = [self init]) self.controller = c;
    return self;
}

- (void) go {
    TTMessageController* msgController = [[[TTMessageController alloc] init] autorelease];
    msgController.fields = [[NSArray alloc] initWithObjects:[msgController.fields objectAtIndex:0], nil];
    msgController.showsRecipientPicker = YES;
    msgController.dataSource = [[[ABSearchSource alloc] init] autorelease];
    msgController.delegate = self;
    UINavigationController* navController = [[[UINavigationController alloc] init] autorelease];
    [navController pushViewController: msgController animated: NO];
    [self.controller presentModalViewController: navController animated: YES];
}

- (void)dealloc {
    [controller release];
    [super dealloc];
}

#pragma mark TTMessageControllerDelegate

- (void)composeController:(TTMessageController*)controller didSendFields:(NSArray*)fields {
    [self.controller dismissModalViewControllerAnimated:YES];
}

- (void)composeControllerDidCancel:(TTMessageController*)controller {
    [self.controller dismissModalViewControllerAnimated:YES];
}

- (void)composeControllerShowRecipientPicker:(TTMessageController*)controller {
	ABPeoplePickerNavigationController *picker = [[ABPeoplePickerNavigationController alloc] init];
    picker.peoplePickerDelegate = self;
	// Display only a person's phone, email, and birthdate
	NSArray *displayedItems = [NSArray arrayWithObjects:[NSNumber numberWithInt:kABPersonEmailProperty], nil];	
	picker.displayedProperties = displayedItems;
	// Show the picker 
	[self.controller.modalViewController presentModalViewController:picker animated:YES];
    [picker release];	
}

#pragma mark ABPeoplePickerNavigationControllerDelegate

- (BOOL)peoplePickerNavigationController:(ABPeoplePickerNavigationController *)peoplePicker shouldContinueAfterSelectingPerson:(ABRecordRef)person {
    // TODO: Check if recipient has just one email address. If so, just use it.
    return YES;
}

- (BOOL)peoplePickerNavigationController:(ABPeoplePickerNavigationController *)peoplePicker shouldContinueAfterSelectingPerson:(ABRecordRef)person property:(ABPropertyID)property identifier:(ABMultiValueIdentifier)identifier {
    // TODO: Get the name and email address and return in a format suitable for the recipient field.
    [self.controller.modalViewController dismissModalViewControllerAnimated:YES];
    return NO;
}

- (void)peoplePickerNavigationControllerDidCancel:(ABPeoplePickerNavigationController *)peoplePicker {
    [self.controller.modalViewController dismissModalViewControllerAnimated:YES];
}

@end

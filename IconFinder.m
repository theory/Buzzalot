//
//  IconFinder.m
//  Buzzalot
//
//  Created by David E. Wheeler on 2/10/10.
//  Copyright 2010 Kineticode, Inc.. All rights reserved.
//

#import "IconFinder.h"
#import "UIImage+Resize.h"
#import <AddressBook/AddressBook.h>

@implementation IconFinder

+(NSArray *)findForEmails:(NSArray *)emails {
    NSDictionary *found = [[NSMutableDictionary alloc] initWithCapacity:[emails count]];

    ABAddressBookRef book = ABAddressBookCreate();
    CFArrayRef people = ABAddressBookCopyArrayOfAllPeople(book);
    
    NSString *emailAddr;
    
    for (CFIndex i = 0; i < ABAddressBookGetPersonCount(book); i++) {
        ABRecordRef rec = CFArrayGetValueAtIndex(people, i);
        if (!ABPersonHasImageData(rec))
            break;
        ABMutableMultiValueRef addrs = ABRecordCopyValue(rec, kABPersonEmailProperty);
        for (CFIndex i = 0; i < ABMultiValueGetCount(addrs); i++) {
            emailAddr = (NSString *) ABMultiValueCopyValueAtIndex(addrs, i);
            if ([emails containsObject:emailAddr]) {
                [found setValue:[[UIImage imageWithData:(NSData *)ABPersonCopyImageData(rec)] thumbnailImage:48 transparentBorder:0 cornerRadius:4 interpolationQuality:kCGInterpolationHigh] forKey:emailAddr];
                break;
            }
        }
//        CFRelease(rec);
//        CFRelease(addrs);
        if ([found count] == [emails count]) {
            break;
        }
    }

    NSMutableArray *icons = [NSMutableArray arrayWithCapacity:[emails count]];
    for (NSString *emailAddr in emails) {
        [icons addObject: [found objectForKey:emailAddr] == nil ? [UIImage imageNamed:@"silhouette.png"] : [found objectForKey:emailAddr]];
    }

    // Use silhouett.png as the default for any that are missing.
    CFRelease(book);
    CFRelease(people);
    [emailAddr release];
    [found release];
    return [icons autorelease];
}

@end

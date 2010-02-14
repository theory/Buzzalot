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

static NSString *docDir  = nil;

+ (void)initialize {
    if (self == [IconFinder class]) {
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        docDir = [[paths objectAtIndex:0] retain];
    }
}

+(NSString *)pngPathFor:(NSString *)email {
    return [docDir stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.png", email]];
}

+(void)saveImage:(UIImage *)img to:(NSString *)fn {
    [[NSFileManager defaultManager] createFileAtPath:fn contents:UIImagePNGRepresentation(img) attributes:nil];
}

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
                [found setValue:[[UIImage imageWithData:(NSData *)ABPersonCopyImageData(rec)]
                                 thumbnailImage:48
                                 transparentBorder:0
                                 cornerRadius:4
                                 interpolationQuality:kCGInterpolationHigh
                                 ] forKey:emailAddr];
                break;
            }
        }
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

+(UIImage *)findForEmail:(NSString *)email {
    UIImage *img = [[self findForEmails:[NSArray arrayWithObject: email]] objectAtIndex:0];
    return img;
}

+(UIImage *)loadForEmail:(NSString *)email {
    NSString *fn = [self pngPathFor:email];
    UIImage *img = [UIImage imageWithContentsOfFile:fn];
    if (img != nil)
        return img;
    img = [[self findForEmails:[NSArray arrayWithObject: email]] objectAtIndex:0];
    [self saveImage:img to: fn];
    return img;
}

+(void)updateThumbsForEmails:(NSArray *)emails {
    NSArray *images = [self findForEmails:emails];
    int i;
    for(i = 0; i < [emails count]; i++) {
        [self saveImage:[images objectAtIndex:i] to: [self pngPathFor:[emails objectAtIndex: i]]];
    }
    [images release];
}

@end

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

static NSString *cacheDir  = nil;
static NSMutableDictionary *cache = nil;

+ (void)initialize {
    if (self == [IconFinder class]) {
        cacheDir = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0] retain];
        cache = [[NSMutableDictionary dictionary] retain];
    }
}

+(NSString *)pngPathFor:(NSString *)email {
    return [cacheDir stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.png", email]];
}

+(void)saveImage:(UIImage *)img to:(NSString *)fn {
    [[NSFileManager defaultManager] createFileAtPath:fn contents:UIImagePNGRepresentation(img) attributes:nil];
}

+(NSArray *)findForEmails:(NSArray *)emails {
    NSString *emailAddr;
    NSMutableArray *lcemails = [NSMutableArray arrayWithCapacity:[emails count]];
    for (emailAddr in emails) {
        [lcemails addObject:[emailAddr lowercaseString]];
    }
    NSDictionary *found = [[NSMutableDictionary alloc] initWithCapacity:[emails count]];

    ABAddressBookRef book = ABAddressBookCreate();
    CFArrayRef people = ABAddressBookCopyArrayOfAllPeople(book);
    
    for (CFIndex i = 0; i < ABAddressBookGetPersonCount(book); i++) {
        ABRecordRef rec = CFArrayGetValueAtIndex(people, i);

        // No point if there's no image.
        if (!ABPersonHasImageData(rec))
            continue;

        // Examine the email addresses.
        ABMutableMultiValueRef addrs = ABRecordCopyValue(rec, kABPersonEmailProperty);
        for (CFIndex i = 0; i < ABMultiValueGetCount(addrs); i++) {
            emailAddr = [(NSString *) ABMultiValueCopyValueAtIndex(addrs, i) lowercaseString];
            if ([lcemails containsObject:emailAddr]) {
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
    for (emailAddr in lcemails) {
        [icons addObject: [found objectForKey:emailAddr] == nil ? [UIImage imageNamed:@"silhouette.png"] : [found objectForKey:emailAddr]];
    }

    // Use silhouett.png as the default for any that are missing.
    CFRelease(book);
    CFRelease(people);
    [emailAddr release];
    [found release];
    return [icons autorelease];
}

+(UIImage *)getForEmail:(NSString *)email {
    // Is it in the in-memory cache?
    UIImage *img = [cache objectForKey:email];
    if (img != nil) return img;

    // Is it cached in a file on the file system?
    img = [UIImage imageWithContentsOfFile:[self pngPathFor:email]];
    if (img != nil) [cache setObject:img forKey:email];
    return img;
}

+(void)findForEmail:(NSString *)email {
    // Is it cached locally already?
    UIImage *img = [self getForEmail:email];
    if (img != nil) return;

    // Search the address book for it.
    NSString *fn = [self pngPathFor:email];
    img = [[self findForEmails:[NSArray arrayWithObject: email]] objectAtIndex:0];
    [self saveImage:img to: fn];
    [cache setObject:img forKey:email];
}

+(void)updateThumbsForEmails:(NSArray *)emails {
    NSArray *images = [self findForEmails:emails];
    int i;
    for(i = 0; i < [emails count]; i++) {
        [self saveImage:[images objectAtIndex:i] to: [self pngPathFor:[emails objectAtIndex: i]]];
        [cache setObject:[images objectAtIndex:i] forKey:[emails objectAtIndex: i]];
    }
}

+(void)findAmongEmails:(NSArray *)emails cacheFor:(NSString *)addr {
    UIImage *def = [UIImage imageNamed:@"silhouette.png"];
    NSArray *icons = [self findForEmails:emails];
    for (UIImage *img in icons) {
        if (img == def) continue;
        [self saveImage:img to: [self pngPathFor:addr]];
        [cache setObject:img forKey:addr];
        return;
    }
    // If we get here, nothing was found. Just return if already have one.
    if (![self getForEmail:addr]) return;
    // Cache the default if nothing is already cached.
    [self saveImage:def to: [self pngPathFor:addr]];
    [cache setObject:def forKey:addr];
}

+(void)clearCache {
    [cache removeAllObjects];
}

@end

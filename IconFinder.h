//
//  IconFinder.h
//  Buzzalot
//
//  Created by David E. Wheeler on 2/10/10.
//  Copyright 2010 Kineticode, Inc.. All rights reserved.
//

@interface IconFinder : NSObject {

}

+(void)updateThumbsForEmails:(NSArray *)emails;

+(UIImage *)cachedForEmail:(NSString *)email;
+(void)cacheForEmail:(NSString *)email;


@end

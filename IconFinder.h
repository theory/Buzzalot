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

+(void)clearCache;
+(UIImage *)getForEmail:(NSString *)email;
+(void)findForEmail:(NSString *)email;

@end

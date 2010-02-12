//
//  UIImage+SaveTo.m
//  Buzzalot
//
//  Created by David E. Wheeler on 2/11/10.
//  Copyright 2010 Kineticode, Inc.. All rights reserved.
//

#import "UIImage+SaveTo.h"

@implementation UIImage (SaveTo)

-(void)savePNGAs:(NSString *)name {
    NSData *data = UIImagePNGRepresentation(self);
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask,  YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *fullPath = [documentsDirectory stringByAppendingPathComponent:name];
    [fileManager createFileAtPath:fullPath contents:data attributes:nil];
}

@end

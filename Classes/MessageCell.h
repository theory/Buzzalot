//
//  MessageCell.h
//  Buzzalot
//
//  Created by David E. Wheeler on 2/5/10.
//  Copyright 2010 Kineticode, Inc.. All rights reserved.
//

#import "ABTableViewCell.h"

#define kBubbleBodyWidth 230
#define kBubbleBodyY 25

@interface MessageCell : ABTableViewCell {
	NSString *bodyText;
    NSString *iconName;
    NSString *whenText;
    BOOL fromMe;
}

@property (nonatomic, copy) NSString *bodyText;
@property (nonatomic, copy) NSString *iconName;
@property (nonatomic, copy) NSString *whenText;
@property BOOL fromMe;

@end

//
//  MessageCell.h
//  Buzzalot
//
//  Created by David E. Wheeler on 2/5/10.
//  Copyright 2010 Kineticode, Inc.. All rights reserved.
//

#import "ABTableViewCell.h"
#import "MessageModel.h"

#define kBubbleBodyWidth 230
#define kBubbleBodyY 27

@interface MessageCell : ABTableViewCell {
    MessageModel *message;
    UIImage *icon;
}

@property (nonatomic, copy) MessageModel *message;
@property (nonatomic, retain) UIImage *icon;

@end

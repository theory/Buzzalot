//
//  MessageCell.m
//  Buzzalot
//
//  Created by David E. Wheeler on 1/24/10.
//  Copyright Kineticode, Inc. 2010. All rights reserved.
//

#import "MessageCell.h"


@implementation MessageCell
@synthesize iconView, myBubbleView, yourBubbleView, bodyLabel, timeLabel, dropShadow, bodyView;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        // Initialization code
    }
    return self;
}

//- (CGSize)sizeThatFits:(CGSize)size {
//	return CGSizeMake(size.width, size.height + 20);
//}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {

    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (void)dealloc {
    [super dealloc];
}


@end

//
//  BuzzerCell.m
//  Buzzalot
//
//  Created by David E. Wheeler on 1/23/10.
//  Copyright 2010 Kineticode, Inc.. All rights reserved.
//

#import "BuzzerCell.h"

@implementation BuzzerCell
@synthesize iconView, buzzerLabel, bodyLabel, timeLabel;


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        // Initialization code
    }
    return self;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (void)dealloc {
    [super dealloc];
}


@end

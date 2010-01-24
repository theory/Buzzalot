//
//  BuzzerCell.m
//  Buzzalot
//
//  Created by David E. Wheeler on 1/23/10.
//  Copyright 2010 Kineticode, Inc.. All rights reserved.
//

#import "BuzzerCell.h"

@implementation BuzzerCell
@synthesize iconView, buzzerLabel, bodyLabel, timeLabel, dropShadow;

- (void)configure {
	self.iconView.layer.masksToBounds = YES;
	self.iconView.layer.cornerRadius = 4.0;

	// XXX This might be better done with a real drop shadow rather than
	// faking it with another view, but this will do for now. See
	// http://stackoverflow.com/questions/1943087/i-am-trying-to-add-a-drop-shadow-to-a-uimageview.
	self.dropShadow.layer.masksToBounds = YES;
	self.dropShadow.layer.cornerRadius = 4.0;
}

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

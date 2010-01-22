//
//  TableViewCellBalloon.m
//  Buzzalot
//
//  Created by David E. Wheeler on 1/19/10.
//  Copyright 2010 Kineticode, Inc.. All rights reserved.
//

#import "TableViewCellBalloon.h"


@implementation TableViewCellBalloon

- (void)drawRect:(CGRect)rect {
	UIImage* balloon = [[UIImage imageNamed:@"/Applications/MobileSMS.app/Balloon_1.png"] stretchableImageWithLeftCapWidth:15  topCapHeight:15];
	[balloon drawInRect: rect];
}

@end

//
//  BuzzerCell.h
//  Buzzalot
//
//  Created by David E. Wheeler on 1/23/10.
//  Copyright 2010 Kineticode, Inc.. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h> // Required to round image corners.

@interface BuzzerCell : UITableViewCell {
    IBOutlet UIImageView *iconView;
    IBOutlet UILabel *buzzerLabel;
    IBOutlet UILabel *bodyLabel;
    IBOutlet UILabel *timeLabel;
	IBOutlet UIView  *dropShadow;
}

@property(retain) UIImageView *iconView;
@property(retain) UILabel *buzzerLabel;
@property(retain) UILabel *bodyLabel;
@property(retain) UILabel *timeLabel;
@property(retain) UIView *dropShadow;

-(void)configure;

@end

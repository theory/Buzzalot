//
//  BuzzerCell.h
//  Buzzalot
//
//  Created by David E. Wheeler on 1/23/10.
//  Copyright Kineticode, Inc. 2010. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h> // Required for graphical effects.

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

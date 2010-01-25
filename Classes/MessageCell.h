//
//  MessageCell.h
//  Buzzalot
//
//  Created by David E. Wheeler on 1/24/10.
//  Copyright Kineticode, Inc. 2010. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h> // Required for graphical effects.

@interface MessageCell : UITableViewCell {
    IBOutlet UILabel *timeLabel;
    IBOutlet UIImageView *iconView;
	IBOutlet UIView  *dropShadow;
	IBOutlet UIView  *bodyView;
	IBOutlet UIImageView *bubbleView;
    IBOutlet UILabel *bodyLabel;

}

@property(retain) UILabel *timeLabel;
@property(retain) UIImageView *iconView;
@property(retain) UIView *dropShadow;
@property(retain) UIView *bodyView;
@property(retain) UIImageView *bubbleView;
@property(retain) UILabel *bodyLabel;

-(void)configure;
-(void)setBody:(NSString *)body icon:(NSString *)icon on:(NSDate *)date fromMe:(BOOL)fromMe;

@end

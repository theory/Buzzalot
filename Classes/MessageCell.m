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

- (void)configure {
	self.iconView.layer.masksToBounds = YES;
	self.iconView.layer.cornerRadius = 4.0;
	self.myBubbleView.image = [[UIImage imageNamed:@"my_bubble.png"] stretchableImageWithLeftCapWidth:18 topCapHeight:18];
	self.yourBubbleView.image = [[UIImage imageNamed:@"your_bubble.png"] stretchableImageWithLeftCapWidth:18 topCapHeight:18];
	self.myBubbleView.transform = CGAffineTransformMakeScale(-1, 1);
	
	// XXX This might be better done with a real drop shadow rather than
	// faking it with another view, but this will do for now. See
	// http://stackoverflow.com/questions/1943087/i-am-trying-to-add-a-drop-shadow-to-a-uimageview.
	self.dropShadow.layer.masksToBounds = YES;
	self.dropShadow.layer.cornerRadius = 4.0;
}

-(void)setBody:(NSString *)body icon:(NSString *)icon  on:(NSDate *)date fromMe:(BOOL)fromMe {
	self.timeLabel.text = date.description;
	self.bodyLabel.text = body;
	[self.bodyLabel sizeToFit];
	CGSize textSize = [body sizeWithFont:[UIFont systemFontOfSize:14.0] constrainedToSize:CGSizeMake( 224.0, 20000.0 ) lineBreakMode:UILineBreakModeWordWrap];
//	self.bodyLabel.layer.borderWidth = 1.0;

	if (fromMe) {
		self.yourBubbleView.hidden = YES;
		self.myBubbleView.hidden = NO;
		self.myBubbleView.frame = CGRectMake(266, 20.0, -textSize.width - 24, textSize.height + 8);
		self.iconView.image = [UIImage imageNamed:@"theory.jpg"]; // XXX Replace
		self.iconView.frame = CGRectMake(268.0, 4.0, 48.0, 48.0);
		self.bodyLabel.frame = CGRectMake(251, 23.0, -textSize.width, textSize.height);
	} else {
		self.myBubbleView.hidden = YES;
		self.yourBubbleView.hidden = NO;
		self.yourBubbleView.frame = CGRectMake(55.0, 20.0, textSize.width + 24, textSize.height + 8);
		self.iconView.image = [UIImage imageNamed:icon];
		self.iconView.frame = CGRectMake(4.0, 4.0, 48.0, 48.0);
		self.bodyLabel.frame = CGRectMake(70.0, 23.0, textSize.width, textSize.height);
	}
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

//
//  MessageCell.m
//  Buzzalot
//
//  Created by David E. Wheeler on 1/24/10.
//  Copyright Kineticode, Inc. 2010. All rights reserved.
//

#import "MessageCell.h"


@implementation MessageCell
@synthesize iconView, bubbleView, bodyLabel, timeLabel, dropShadow, bodyView;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        // Initialization code
    }
    return self;
}

- (void)configure {
	self.iconView.layer.masksToBounds = YES;
	self.iconView.layer.cornerRadius = 4.0;
	
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
	CGSize size = self.bodyLabel.frame.size;
//	CGSize screen = [UIScreen mainScreen].bounds.size;

//	CGSize textSize = { 245.0, 20000.0 };		// width and height of text area
//	CGSize size = [body sizeWithFont:[UIFont systemFontOfSize:14.0] constrainedToSize:textSize lineBreakMode:UILineBreakModeWordWrap];
//	CGPoint o = self.bodyLabel.frame.origin;
//	self.bodyLabel.frame = CGRectMake(o.x, o.y, size.width, size.height);
//	self.bodyLabel.layer.borderWidth = 1.0;
//	o = self.bubbleView.frame.origin;
//	self.bubbleView.frame = CGRectMake(o.x, o.y, size.width, size.height);
//	o = self.frame.origin;

	
	//	self.bodyLabel.frame.size.height = size.height;
//	CGRect f = self.bodyLabel.frame;
//	self.bodyLabel.frame = CGRectMake(f.origin.x, f.y, size.width + 0.0, CGRectGetHeight(f));

//	UIImageView *iv = [[UIImageView alloc] initWithFrame:CGRectMake(sent ? 0 : cell.frame.size.width - size.width - 35, 0.0, size.width+35, size.height+15)];
//	UIView *view =[[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, cell.frame.size.width, cell.frame.size.height)];
//	[iv setImage:balloon];
//	[view addSubview:iv];
//	[cell setBackgroundView:view];
//	
//	if (sent) {
//		iv.transform = CGAffineTransformMakeScale(-1, 1);
//		cell.textLabel.backgroundColor = [UIColor clearColor];
//	}
	
	if (fromMe) {
		self.bubbleView.image = [[UIImage imageNamed:@"my_bubble.png"] stretchableImageWithLeftCapWidth:18 topCapHeight:18];
		self.bubbleView.transform = CGAffineTransformMakeScale(-1, 1);
		self.bubbleView.frame = CGRectMake(4.0, 20.0, 262.0, size.height + 8);
		self.iconView.image = [UIImage imageNamed:@"theory.jpg"]; // XXX Replace
		self.iconView.frame = CGRectMake(268.0, 4.0, 48.0, 48.0);
//		self.bodyLabel.frame = CGRectMake(10.0, 23.0, 240.0, size.height);
	} else {
		self.bubbleView.image = [[UIImage imageNamed:@"your_bubble.png"] stretchableImageWithLeftCapWidth:18 topCapHeight:18];
		self.bubbleView.frame = CGRectMake(55.0, 20.0, size.width + 15, size.height + 8);
		self.iconView.image = [UIImage imageNamed:icon];
		self.iconView.frame = CGRectMake(4.0, 4.0, 48.0, 48.0);
		self.dropShadow.frame = CGRectMake(3.0, 3.0, 50.0, 50.0);
//		self.bodyLabel.frame = CGRectMake(70.0, 23.0, 240.0, size.height);
	}
//	[self.bodyView sizeToFit];
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

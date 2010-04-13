//
//  MessageCell.m
//  Buzzalot
//
//  Created by David E. Wheeler on 2/5/10.
//  Copyright 2010 Kineticode, Inc.. All rights reserved.
//

#import "MessageCell.h"
#import "MyColors.h"

@implementation MessageCell
@synthesize message, icon;

static UIFont          *bodyTextFont = nil;
static UIFont          *whenTextFont = nil;
static UIImage         *myBubble     = nil;
static UIImage         *yourBubble   = nil;
static NSDateFormatter *df           = nil;
static float            textVPadding;
static float            myTextRMargin;
static float            myTBubRMargin;
static float            textWidth;

+ (void)initialize {
    if (self == [MessageCell class]) {
        bodyTextFont  = [[UIFont systemFontOfSize:14] retain];
        whenTextFont  = [[UIFont boldSystemFontOfSize:12] retain];
        myBubble      = [[[UIImage imageNamed:@"my_bubble.png"] stretchableImageWithLeftCapWidth:6 topCapHeight:22] retain];
        yourBubble    = [[[UIImage imageNamed:@"your_bubble.png"] stretchableImageWithLeftCapWidth:19 topCapHeight:22] retain];
        textVPadding  = 31 - [@"foo" sizeWithFont:bodyTextFont constrainedToSize:CGSizeMake(235, 120)].height;
        df            = [[[NSDateFormatter alloc] init] retain];
        df.dateStyle  = NSDateFormatterShortStyle;
        df.timeStyle  = NSDateFormatterShortStyle;
        float screenWidth = [[UIScreen mainScreen] bounds].size.width;
        textWidth     = screenWidth - kBubbleTextWidthBuffer;
        myTextRMargin = textWidth + 13;
        myTBubRMargin = textWidth + 3;
	}
}

- (void)dealloc {
    [message release];
    [super dealloc];
}

- (void)setMessage:(MessageModel *)m {
    if (message != m) {
        [message release];
        message = [m retain];
        [self setNeedsDisplay];
    }
}

- (void)drawContentView:(CGRect)r {
    CGContextRef context = UIGraphicsGetCurrentContext();
    
	UIColor *backgroundColor = [UIColor tweetieBlue];
	UIColor *textColor = [UIColor blueGrayColor];

	if (self.selected) {
		backgroundColor = [UIColor clearColor];
		textColor = [UIColor whiteColor];
	}
    
	[backgroundColor set];
	CGContextFillRect(context, r);
	[textColor set];
    
    // Draw date/time.
    NSString *sentAt = [df stringFromDate:message.sent];

    // Get body size.
    CGSize size = [message.body sizeWithFont:bodyTextFont constrainedToSize:CGSizeMake(textWidth, 2000)];

    if (message.fromMe) {
        // Draw date.
        [sentAt drawAtPoint:CGPointMake(myTBubRMargin - size.width + 2, 4) withFont:whenTextFont];

        // Draw bubble.
        [myBubble drawInRect:CGRectMake(myTBubRMargin - size.width, kBubbleY, size.width + kTextHPadding, size.height + textVPadding)];
        
        // Draw body.
        [textColor = [UIColor darkTextColor] set];
        // CGContextStrokeRect(context, CGRectMake(myTextRMargin - size.width, kBubbleBodyY, bubbleTextWidth, size.height));
        [message.body drawInRect:CGRectMake(myTextRMargin - size.width, kBubbleBodyY, textWidth, size.height) withFont:bodyTextFont];
        
        // Draw icon.
        [[UIImage imageNamed:@"icon_shadow.png"] drawInRect:CGRectMake(263, 7, 52, 52)];
        [self.icon drawInRect:CGRectMake(265, 8, 48, 48)];
    } else {
        // Draw date.
        [sentAt drawAtPoint:CGPointMake(68, 4) withFont:whenTextFont];

        // Draw bubble.
        [yourBubble drawInRect:CGRectMake(54, kBubbleY, size.width + kTextHPadding, size.height + textVPadding)];
        
        // Draw body.
        [textColor = [UIColor darkTextColor] set];
        // CGContextStrokeRect(context, CGRectMake(72, kBubbleBodyY, bubbleTextWidth, size.height));
        [message.body drawInRect:CGRectMake(75, kBubbleBodyY, textWidth, size.height) withFont:bodyTextFont];

        // Draw icon.
        [[UIImage imageNamed:@"icon_shadow.png"] drawInRect:CGRectMake(5, 7, 52, 52)];
        [self.icon drawInRect:CGRectMake(7, 8, 48, 48)];
    }
}

@end

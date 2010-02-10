//
//  MessageCell.m
//  Buzzalot
//
//  Created by David E. Wheeler on 2/5/10.
//  Copyright 2010 Kineticode, Inc.. All rights reserved.
//

#import "MessageCell.h"

@implementation MessageCell
@synthesize message;

static UIFont *bodyTextFont   = nil;
static UIFont *whenTextFont   = nil;
static UIImage *myBubble      = nil;
static UIImage *yourBubble    = nil;

+ (void)initialize {
    if (self == [MessageCell class]) {
        bodyTextFont = [[UIFont systemFontOfSize:14] retain];
        whenTextFont = [[UIFont systemFontOfSize:12] retain];
        myBubble     = [[[UIImage imageNamed:@"my_bubble.png"] stretchableImageWithLeftCapWidth:18 topCapHeight:18] retain];
        yourBubble   = [[[UIImage imageNamed:@"your_bubble.png"] stretchableImageWithLeftCapWidth:18 topCapHeight:18] retain];
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
    
	UIColor *backgroundColor = [UIColor whiteColor];
	UIColor *textColor = [UIColor darkGrayColor];

	if (self.selected) {
		backgroundColor = [UIColor clearColor];
		textColor = [UIColor whiteColor];
	}
    
	[backgroundColor set];
	CGContextFillRect(context, r);
	[textColor set];
    
    // Draw date/time.
	CGPoint p = {140, 4};
    [message.sent drawAtPoint:p withFont:whenTextFont];

    // Get body size.
    CGSize size = [message.body sizeWithFont:bodyTextFont constrainedToSize:CGSizeMake(235, 2000)];

    if (message.fromMe) {
        // Draw bubble.
        [myBubble drawInRect:CGRectMake(240 - size.width, 22, size.width + 22, size.height + 8)];
        
        // Draw body.
        [textColor = [UIColor darkTextColor] set];
        // CGContextStrokeRect(context, CGRectMake(248 - size.width, kBubbleBodyY, size.width, size.height));
        [message.body drawInRect:CGRectMake(248 - size.width, kBubbleBodyY, kBubbleBodyWidth, size.height) withFont:bodyTextFont];
        
        // Draw icon.
        UIImage *icon = [UIImage imageNamed:@"theory.jpg"]; // TODO: Get icon from address book.
        [icon drawInRect:CGRectMake(265, 7, 48, 48)];
    } else {
        // Draw bubble.
        [yourBubble drawInRect:CGRectMake(58, 22, size.width + 22, size.height + 8)];
        
        // Draw body.
        [textColor = [UIColor darkTextColor] set];
        // CGContextStrokeRect(context, CGRectMake(72, kBubbleBodyY, size.width, size.height));
        [message.body drawInRect:CGRectMake(72, kBubbleBodyY, kBubbleBodyWidth, size.height) withFont:bodyTextFont];

        // Draw icon.
        [message.icon drawInRect:CGRectMake(7, 7, 48, 48)];
    }
}

@end

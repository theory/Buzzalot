//
//  BuzzerCell.m
//  Buzzalot
//
//  Created by David E. Wheeler on 2/2/10.
//  Copyright 2010 Kineticode, Inc.. All rights reserved.
//

#import "BuzzerCell.h"
#import "MyColors.h"

@implementation BuzzerCell

@synthesize buzzerName, bodyText, iconName, whenText;

static UIFont *buzzerNameFont = nil;
static UIFont *bodyTextFont   = nil;
static UIFont *whenTextFont   = nil;

+ (void)initialize {
    if (self == [BuzzerCell class]) {
        buzzerNameFont = [[UIFont boldSystemFontOfSize:14] retain];
        bodyTextFont = [[UIFont systemFontOfSize:14] retain];
        whenTextFont = [[UIFont systemFontOfSize:14] retain];
        // this is a good spot to load any graphics you might be drawing in
        // -drawContentView: just load them and retain them here (ONLY if
        // they're small enough that you don't care about them wasting memory)
		// the idea is to do as LITTLE work (e.g. allocations) in
        // -drawContentView: as possible
	}
}

- (void)dealloc {
    [buzzerName release];
    [bodyText release];
    [iconName release];
    [whenText release];
    [super dealloc];
}

- (void)setBuzzerName:(NSString *)s {
    [buzzerName release];
    buzzerName = [s copy];
    [self setNeedsDisplay]; 
}

- (void)setBodyText:(NSString *)s {
    [bodyText release];
    bodyText = [s copy];
    [self setNeedsDisplay]; 
}

- (void)setIconName:(NSString *)s {
    [iconName release];
    iconName = [s copy];
    [self setNeedsDisplay]; 
}

- (void)setWhenText:(NSString *)s {
    [whenText release];
    whenText = [s copy];
    [self setNeedsDisplay]; 
}

- (void)drawContentView:(CGRect)r {
    CGContextRef context = UIGraphicsGetCurrentContext();

	UIColor *backgroundColor = [UIColor whiteColor];
	UIColor *textColor = [UIColor blackColor];
	
	if (self.selected) {
		backgroundColor = [UIColor clearColor];
		textColor = [UIColor whiteColor];
	}
	
	[backgroundColor set];
	CGContextFillRect(context, r);
	[textColor set];

    // Draw date/time.
    if (!self.selected) [textColor = [UIColor blueGrayColor] set];
    CGSize size = [whenText sizeWithFont:whenTextFont constrainedToSize:CGSizeMake(120, 2000)];
	CGPoint p = {296 - size.width, 4};
    [whenText drawAtPoint:p withFont:whenTextFont];
    
	// Draw buzzer name.
    if (!self.selected) [textColor = [UIColor darkTextColor] set];
    p.x = 60;
    p.y = 4;
    [buzzerName drawAtPoint:p forWidth: 232 - size.width withFont:buzzerNameFont lineBreakMode:UILineBreakModeWordWrap ];

//    CGContextStrokeRect(context, CGRectMake(60, 4, 232-size.width, 20));

    // Draw body.
    if (!self.selected) [textColor = [UIColor darkGrayColor] set];
    size = [bodyText sizeWithFont:bodyTextFont constrainedToSize:CGSizeMake(kBuzzerBodyWidth, 2000)];
    [bodyText drawInRect:CGRectMake(p.x, 22, 235, size.height) withFont:bodyTextFont];

//    CGContextStrokeRect(context, CGRectMake(p.x, kBuzzerBodyY, kBuzzerBodyWidth, size.height));
    
    UIImage *icon = [UIImage imageNamed:self.iconName];
    [icon drawInRect:CGRectMake(4, 4, 48, 48)];

    // Need to figure out how to round the corners and add the frame. Somehow
    // involves a clip to mask, I'm sure.
    // Or maybe layer drawing? http://developer.apple.com/iphone/library/documentation/GraphicsImaging/Conceptual/drawingwithquartz2d/dq_layers/dq_layers.html#//apple_ref/doc/uid/TP30001066-CH219-TPXREF101
    // UIImage *frame = [UIImage imageNamed:@"icon_frame.png"];
    // [frame drawInRect:CGRectMake(4, 4, 52, 52)];
}

@end

//
//  BuzzerCell.h
//  Buzzalot
//
//  Created by David E. Wheeler on 2/2/10.
//  Copyright 2010 Kineticode, Inc.. All rights reserved.
//

#import "ABTableViewCell.h"
#define kBuzzerBodyWidth 235
#define kBuzzerBodyY 22

@interface BuzzerCell : ABTableViewCell {
	NSString *buzzerName;
	NSString *bodyText;
    NSString *iconName;
    NSString *whenText;
}

@property (nonatomic, copy) NSString *buzzerName;
@property (nonatomic, copy) NSString *bodyText;
@property (nonatomic, copy) NSString *iconName;
@property (nonatomic, copy) NSString *whenText;

@end

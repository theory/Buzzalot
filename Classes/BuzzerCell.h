//
//  BuzzerCell.h
//  Buzzalot
//
//  Created by David E. Wheeler on 2/2/10.
//  Copyright 2010 Kineticode, Inc.. All rights reserved.
//

#import "ABTableViewCell.h"
#import "Buzzer.h"
#define kBuzzerBodyWidth 235
#define kBuzzerBodyY 22

@interface BuzzerCell : ABTableViewCell {
    Buzzer *buzzer;
}

@property (nonatomic, copy) Buzzer *buzzer;

@end

//
//  BuzzerViewController.h
//  Buzzalot
//
//  Created by David E. Wheeler on 2/4/10.
//  Copyright 2010 Kineticode, Inc.. All rights reserved.
//

@class Buzzer;
@interface BuzzerViewController : UITableViewController {
    NSMutableArray *messages;
}

@property (nonatomic, retain) NSMutableArray *messages;

-(void)initWithBuzzer:(Buzzer *)buzzer;

@end

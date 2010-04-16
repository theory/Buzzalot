//
//  BuzzerViewController.h
//  Buzzalot
//
//  Created by David E. Wheeler on 2/4/10.
//  Copyright 2010 Kineticode, Inc.. All rights reserved.
//

@class BuzzerModel;
@interface BuzzerViewController : UITableViewController {
    NSMutableArray *messages;
    UIImage *myIcon;
    UIImage *yourIcon;
    BuzzerModel *buzzer;
}

@property (nonatomic, retain) NSMutableArray *messages;
@property (nonatomic, retain) UIImage     *myIcon;
@property (nonatomic, retain) UIImage     *yourIcon;
@property (nonatomic, retain) BuzzerModel *buzzer;

- (void) initWithBuzzer:(BuzzerModel *)b;
- (void) reply;

@end

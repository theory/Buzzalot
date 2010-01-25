//
//  BuzzerViewController.h
//  Buzzalot
//
//  Created by David E. Wheeler on 1/17/10.
//  Copyright 2010 Kineticode, Inc.. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MessageCell.h"

@interface BuzzerViewController : UITableViewController {
	MessageCell *messageCell;
}

@property (nonatomic, assign) IBOutlet MessageCell *messageCell;

-(NSString *)textForRowAtIndexPath:(NSIndexPath *)indexPath;
@end

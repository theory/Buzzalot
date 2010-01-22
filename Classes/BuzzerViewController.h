//
//  BuzzerViewController.h
//  Buzzalot
//
//  Created by David E. Wheeler on 1/17/10.
//  Copyright 2010 Kineticode, Inc.. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface BuzzerViewController : UITableViewController {
	CGFloat cellHeight;
}

@property (nonatomic) CGFloat cellHeight;

-(NSString *)textForRowAtIndexPath:(NSIndexPath *)indexPath;
@end

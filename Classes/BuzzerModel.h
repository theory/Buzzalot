//
//  Buzzer.h
//  Buzzalot
//
//  Created by David E. Wheeler on 2/8/10.
//  Copyright 2010 Kineticode, Inc.. All rights reserved.
//

@interface BuzzerModel : NSObject {
    NSString *email;
    NSString *name;
    NSString *body;
    NSInteger when;
}

@property (nonatomic, retain) NSString *email;
@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSString *body;
@property NSInteger when;

+(NSMutableArray *) selectBuzzers;
-(BuzzerModel *)initWithEmail:(char *)e name:(char *)n when:(int)w body:(char *)b;
-(void)deleteBuzzer;

@end

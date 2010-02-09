//
//  Message.h
//  Buzzalot
//
//  Created by David E. Wheeler on 2/8/10.
//  Copyright 2010 Kineticode, Inc.. All rights reserved.
//

#import "Buzzer.h"

@interface Message : NSObject {
    NSString *message_id;
    NSString *sent;
    NSString *body;
    UIImage  *icon;
    BOOL     fromMe;
}

@property (nonatomic, retain) NSString *message_id;
@property (nonatomic, retain) NSString *sent;
@property (nonatomic, retain) NSString *body;
@property (nonatomic, retain) UIImage  *icon;
@property BOOL fromMe;

+(NSMutableArray *) selectForBuzzer:(Buzzer *)buzzer;
-(Message *) initWithId:(char *)i sent:(char *)s body:(char *)b fromMe:(int)f icon:(UIImage *)m;
-(void)deleteMessage;

@end

//
//  Message.h
//  Buzzalot
//
//  Created by David E. Wheeler on 2/8/10.
//  Copyright 2010 Kineticode, Inc.. All rights reserved.
//

#import "BuzzerModel.h"

@interface MessageModel : NSObject {
    NSString *message_id;
    NSString *sent;
    NSString *body;
    BOOL     fromMe;
}

@property (nonatomic, retain) NSString *message_id;
@property (nonatomic, retain) NSString *sent;
@property (nonatomic, retain) NSString *body;
@property BOOL fromMe;

+(NSMutableArray *) selectForBuzzer:(BuzzerModel *)buzzer;
-(MessageModel *) initWithId:(char *)i sent:(char *)s body:(char *)b fromMe:(int)f;
-(void)deleteMessage;

@end

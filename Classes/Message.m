//
//  Message.m
//  Buzzalot
//
//  Created by David E. Wheeler on 2/8/10.
//  Copyright 2010 Kineticode, Inc.. All rights reserved.
//

#import "Message.h"
#import "BuzzalotAppDelegate.h"

@implementation Message
@synthesize message_id, sent, body, icon, fromMe;

+(NSMutableArray *) selectForBuzzer:(Buzzer *)buzzer {
    sqlite3 *db = [BuzzalotAppDelegate getDBConnection];
    sqlite3_stmt *sth;
    NSMutableArray *messages = [[NSMutableArray alloc] init];
    if (sqlite3_prepare_v2(db, "SELECT message_id, sent_at, body, from_me FROM messages WHERE email = ? ORDER BY sent_at DESC", -1, &sth, nil) == SQLITE_OK ) {
        sqlite3_bind_text(sth, 1, [buzzer.email UTF8String], -1, NULL);
        while (sqlite3_step(sth) == SQLITE_ROW) {
            [messages addObject: [[Message alloc]
                                 initWithId: (char *) sqlite3_column_text(sth, 0)
                                       sent: (char *) sqlite3_column_text(sth, 1)
                                       body: (char *) sqlite3_column_text(sth, 2)
                                     fromMe: sqlite3_column_int(sth, 3)
                                       icon: buzzer.icon
            ]];
        }
        sqlite3_finalize(sth);
    }
    return messages;    
}

-(Message *) initWithId:(char *)i sent:(char *)s body:(char *)b fromMe:(int)f icon:(UIImage *)m {
    if (self = [super init]) {
        self.message_id = [[NSString alloc] initWithUTF8String:i];
        self.sent       = [[NSString alloc] initWithUTF8String:s];
        self.body       = [[NSString alloc] initWithUTF8String:b];
        self.fromMe     = f == 1;
        self.icon       = m;
    }
    return self;
}

-(void)deleteMessage {
    sqlite3 *db = [BuzzalotAppDelegate getDBConnection];
    sqlite3_stmt *sth;
    // Delete messages.
    if (sqlite3_prepare_v2(db, "DELETE FROM messages WHERE message_id = ?", -1, &sth, nil) == SQLITE_OK ) {
        sqlite3_bind_text(sth, 1, [self.message_id UTF8String], -1, NULL);
    }
    
    sqlite3_step(sth);
    sqlite3_finalize(sth);
}

@end

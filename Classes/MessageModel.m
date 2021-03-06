//
//  Message.m
//  Buzzalot
//
//  Created by David E. Wheeler on 2/8/10.
//  Copyright 2010 Kineticode, Inc.. All rights reserved.
//

#import "MessageModel.h"
#import "BuzzalotAppDelegate.h"

@implementation MessageModel
@synthesize message_id, sent, body, fromMe;

+(NSMutableArray *) selectForBuzzer:(BuzzerModel *)buzzer {
    sqlite3 *db = [BuzzalotAppDelegate getDBConnection];
    sqlite3_stmt *sth;
    NSMutableArray *messages = [[NSMutableArray alloc] init];
    if (sqlite3_prepare_v2(db, "SELECT message_id, strftime('%s', sent_at, 'localtime'), body, from_me FROM messages WHERE email = ? ORDER BY sent_at DESC", -1, &sth, nil) == SQLITE_OK ) {
        sqlite3_bind_text(sth, 1, [buzzer.email UTF8String], -1, NULL);
        while (sqlite3_step(sth) == SQLITE_ROW) {
            [messages addObject: [[MessageModel alloc]
                                 initWithId: (char *) sqlite3_column_text(sth, 0)
                                       sent: sqlite3_column_int64(sth, 1)
                                       body: (char *) sqlite3_column_text(sth, 2)
                                     fromMe: sqlite3_column_int(sth, 3)
            ]];
        }
        sqlite3_finalize(sth);
    }
    return [messages autorelease];
}

-(MessageModel *) initWithId:(char *)i sent:(NSInteger)s body:(char *)b fromMe:(int)f {
    if (self = [super init]) {
        self.message_id = [[NSString alloc] initWithUTF8String:i];
        self.sent       = [NSDate dateWithTimeIntervalSince1970:s];
        self.body       = [[NSString alloc] initWithUTF8String:b];
        self.fromMe     = f == 1;
    }
    return self;
}

-(void)deleteMessage {
    sqlite3 *db = [BuzzalotAppDelegate getDBConnection];
    sqlite3_stmt *sth;
    char *errorMsg;

    // Delete messages.
    if (sqlite3_prepare_v2(db, "DELETE FROM messages WHERE message_id = ?", -1, &sth, nil) != SQLITE_OK ) {
        sqlite3_close(db);
        NSAssert1(0, @"Error deleting correspondent: %s", errorMsg);
    }
    
    sqlite3_bind_text(sth, 1, [self.message_id UTF8String], -1, NULL);
    sqlite3_step(sth);
    sqlite3_finalize(sth);
}

- (void)dealloc {
    [message_id release];
    [sent release];
    [body release];
    [super dealloc];
}

@end

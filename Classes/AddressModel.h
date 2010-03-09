//
//  Message.h
//  Buzzalot
//
//  Created by David E. Wheeler on 2/8/10.
//  Copyright 2010 Kineticode, Inc.. All rights reserved.
//

@interface AddressModel : NSObject {
    NSString  *email;
    BOOL      confirmed;
}

@property (nonatomic, retain) NSString *email;
@property BOOL confirmed;

+ (NSMutableArray *) selectAll;
+ (void) reorderAddressesFrom:(NSArray *)a;
- (AddressModel *) initWithEmail:(char *)e confirmed:(int)c;
- (void) confirm;

@end

#import <Three20/Three20.h>
#import <AddressBook/AddressBook.h>

@interface ABDataSource : NSObject <TTModel> {
    NSMutableArray*  _delegates;
    ABAddressBookRef addressBook;
    CFArrayRef       people;
}

@property ABAddressBookRef addressBook;
@property CFArrayRef people;
- (void)search:(NSString*)text;
- (NSMutableArray *) fetchResults;

@end

@interface ABSearchSource : TTSectionedDataSource {
  ABDataSource* _addressBook;
}

@property(nonatomic,readonly) ABDataSource* addressBook;

@end

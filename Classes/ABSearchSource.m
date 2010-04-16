
#import "ABSearchSource.h"

@implementation ABDataSource

@synthesize addressBook, people;

#pragma mark NSObject

- (id)init {
    if (self = [super init]) {
        self.addressBook = ABAddressBookCreate();
    }
    return self;
}

- (void)dealloc {
    CFRelease(self.addressBook);
    if (self.people) CFRelease(self.people);
    [super dealloc];
}

#pragma mark TTModel

- (NSMutableArray*)delegates {
    if (!_delegates) {
        _delegates = TTCreateNonRetainingArray();
    }
    return _delegates;
}

- (BOOL)isLoadingMore {
    return NO;
}

- (BOOL)isOutdated {
    return NO;
}

- (BOOL)isLoaded {
    return !!self.people;
}

- (BOOL)isLoading {
    return NO;
}

- (BOOL)isEmpty {
    return !self.people || CFArrayGetCount(people) == 0;
}

- (void)load:(TTURLRequestCachePolicy)cachePolicy more:(BOOL)more {
}

- (void)invalidate:(BOOL)erase {
}

- (void)cancel {
}

#pragma mark public
- (void)search:(NSString*)text {
  [self cancel];

    if (text.length) {
        self.people = ABAddressBookCopyPeopleWithName( self.addressBook, (CFStringRef)text );
    } else if (self.people) {
        CFRelease(self.people);
        self.people = nil;
    }
    [_delegates perform:@selector(modelDidFinishLoad:) withObject:self];
}

- (NSMutableArray *) fetchResults {
    NSMutableArray *items = [NSMutableArray array];
	if (people != nil) {
        for (CFIndex i = 0; i < CFArrayGetCount(people); i++) {
            ABRecordRef person = CFArrayGetValueAtIndex(people, i);
            NSString *firstName   = (NSString *)ABRecordCopyValue(person, kABPersonFirstNameProperty);
            NSString *middleName  = (NSString *)ABRecordCopyValue(person, kABPersonMiddleNameProperty);
            NSString *lastName    = (NSString *)ABRecordCopyValue(person, kABPersonLastNameProperty);
            NSString *fullName    = nil;
            if (firstName && lastName) {
                if (ABPersonGetCompositeNameFormat() == kABPersonCompositeNameFormatFirstNameFirst)
                    fullName = middleName
                        ? [NSString stringWithFormat:@"%@ %@ %@", firstName, middleName, lastName]
                        : [NSString stringWithFormat:@"%@ %@", firstName, lastName];
                    else
                    fullName = middleName
                        ? [NSString stringWithFormat:@"%@, %@ %@", lastName, firstName, middleName]
                        : [NSString stringWithFormat:@"%@, %@", lastName, firstName];
            } else if (lastName) {
                if (middleName)
                    fullName = ABPersonGetCompositeNameFormat() == kABPersonCompositeNameFormatFirstNameFirst
                        ? [NSString stringWithFormat:@"%@ %@", middleName, lastName]
                        : [NSString stringWithFormat:@"%@ %@", lastName, middleName];
                else
                    fullName = lastName;
            } else {
                fullName = middleName
                    ? [NSString stringWithFormat:@"%@ %@", firstName, middleName]
                    : firstName;
            }

            ABMutableMultiValueRef addrs = ABRecordCopyValue(person, kABPersonEmailProperty);
            for (CFIndex i = 0; i < ABMultiValueGetCount(addrs); i++) {
                NSString *emailAddr = (NSString *) ABMultiValueCopyValueAtIndex(addrs, i);
                TTTableSubtitleItem *item = [TTTableSubtitleItem itemWithText:fullName subtitle:emailAddr];
                [items addObject:item];
            }
        }
	}
    return items;
}

@end

#pragma mark -
@implementation ABSearchSource

@synthesize addressBook = _addressBook;

#pragma mark NSObject

- (id)init {
    if (self = [super init]) {
        _addressBook = [[ABDataSource alloc] init];
        self.model = _addressBook;
    }
    return self;
}

- (void)dealloc {
  TT_RELEASE_SAFELY(_addressBook);
  [super dealloc];
}

#pragma mark TTTableViewDataSource

- (void)tableViewDidLoadModel:(UITableView*)tableView {
    self.items = [_addressBook fetchResults];
}

- (void)search:(NSString*)text {
  [_addressBook search:text];
}

@end

//
// Created by akinsella on 01/04/13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "XBBasicDataMerger.h"
#import "XBDataMapper.h"

@interface XBBasicDataMerger()

@property(nonatomic, strong)NSString *rootKeyPath;

@end

@implementation XBBasicDataMerger

+ (id)dataMergerWithRootKeyPath:(NSString *)rootKeyPath {
    return [[self alloc] initWithRootKeyPath:rootKeyPath];
}

- (id)initWithRootKeyPath:(NSString *)rootKeyPath {
    self = [super init];
    if (self) {
        self.rootKeyPath = rootKeyPath;
    }

    return self;
}

- (id)mergeDataFromSource:(id)srcData toDest:(id)destData {
    id mutableDestData = [destData mutableCopy];

    NSMutableArray *destMappedData = self.rootKeyPath ? [mutableDestData valueForKeyPath:self.rootKeyPath] : mutableDestData;
    NSMutableArray *srcMappedData = self.rootKeyPath ? [srcData valueForKeyPath:self.rootKeyPath] : srcData;

    [destMappedData addObjectsFromArray:srcMappedData];

    return mutableDestData;
}

@end
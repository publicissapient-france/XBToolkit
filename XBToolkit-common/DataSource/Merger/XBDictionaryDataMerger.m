//
// Created by akinsella on 01/04/13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "XBDictionaryDataMerger.h"
#import "NSDictionary+XBAdditions.h"

@interface XBDictionaryDataMerger ()

@property(nonatomic, strong)NSString *rootKeyPath;

@end

@implementation XBDictionaryDataMerger

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

- (id)mergeDataFromSource:(NSDictionary *)srcData toDest:(NSDictionary *)destData {
    NSMutableDictionary *mutableDestData = [destData deepMutableCopy];

    NSMutableArray *destMutableData = self.rootKeyPath ? [mutableDestData valueForKeyPath:self.rootKeyPath] : mutableDestData;

    NSMutableArray *srcMutableData = self.rootKeyPath ? [srcData valueForKeyPath:self.rootKeyPath] : srcData;

    [destMutableData addObjectsFromArray:srcMutableData];

    return mutableDestData;
}

@end
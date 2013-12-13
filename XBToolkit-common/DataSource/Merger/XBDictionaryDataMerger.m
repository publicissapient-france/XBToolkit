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

- (id)initWithRootKeyPath:(NSString *)rootKeyPath
{
    self = [super init];
    if (self) {
        self.rootKeyPath = rootKeyPath;
    }

    return self;
}

+ (instancetype)dataMergerWithRootKeyPath:(NSString *)rootKeyPath
{
    return [[self alloc] initWithRootKeyPath:rootKeyPath];
}

- (id)mergeDataOfSource:(id)dataSource1 withSource:(id)dataSource2
{
    NSMutableDictionary *mutableDestData = [dataSource2 deepMutableCopy];

    NSMutableArray *destMutableData = self.rootKeyPath ? [mutableDestData valueForKeyPath:self.rootKeyPath] : mutableDestData;

    NSMutableArray *srcMutableData = self.rootKeyPath ? [dataSource1 valueForKeyPath:self.rootKeyPath] : dataSource1;

    [destMutableData addObjectsFromArray:srcMutableData];

    return mutableDestData;
}

@end
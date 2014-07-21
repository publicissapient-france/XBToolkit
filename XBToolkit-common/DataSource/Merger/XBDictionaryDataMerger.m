//
// Created by akinsella on 01/04/13.
//


#import "XBDictionaryDataMerger.h"
#import "NSDictionary+XBAdditions.h"


@interface XBDictionaryDataMerger ()

@property (nonatomic, strong) NSString *rootKeyPath;

@end


@implementation XBDictionaryDataMerger

- (instancetype)initWithRootKeyPath:(NSString *)rootKeyPath
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
    NSDictionary *copyOfDataSource2 = [dataSource2 deepMutableCopy];

    NSMutableArray *destMutableData = [copyOfDataSource2 valueForKeyPath:self.rootKeyPath];

    NSMutableArray *srcMutableData = [dataSource1 valueForKeyPath:self.rootKeyPath];

    [destMutableData addObjectsFromArray:srcMutableData];

    return copyOfDataSource2;
}

@end
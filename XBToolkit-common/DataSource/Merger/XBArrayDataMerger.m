//
// Created by akinsella on 01/04/13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "XBArrayDataMerger.h"

@implementation XBArrayDataMerger

+ (id)dataMerger {
    return [[self alloc] init];
}

- (id)mergeDataFromSource:(NSArray *)srcData toDest:(NSArray *)destData {

    NSMutableArray *destMutableData = [destData mutableCopy];
    NSMutableArray *srcMutableData = [srcData mutableCopy];

    [destMutableData addObjectsFromArray:srcMutableData];

    return destMutableData;
}

@end
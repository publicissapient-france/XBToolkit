//
// Created by akinsella on 01/04/13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "XBArrayDataMerger.h"

@implementation XBArrayDataMerger

+ (instancetype)dataMerger
{
    return [[self alloc] init];
}

- (id)mergeDataOfSource:(id)dataSource1 withSource:(id)dataSource2
{
    NSMutableArray *destMutableData = [dataSource2 mutableCopy];
    NSMutableArray *srcMutableData = [dataSource1 mutableCopy];

    [destMutableData addObjectsFromArray:srcMutableData];

    return destMutableData;
}

@end
//
// Created by akinsella on 29/03/13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "XBArrayDataSource.h"

@interface XBArrayDataSource()

@property (nonatomic, strong) NSArray *sourceArray;
@property (nonatomic, strong) NSArray *filteredSortedArray;
@property (nonatomic, strong) XBPredicateBlock filterPredicate;
@property (nonatomic, assign) NSComparator sortComparator;

@end


@implementation XBArrayDataSource

- (id)initWithArray:(NSArray *)array
{
    return [self initWithArray: array filterPredicate: nil sortComparator:nil];
}

- (id)initWithArray:(NSArray *)array filterPredicate:(XBPredicateBlock)filterPredicate sortComparator:(NSComparator)sortComparator
{
    self = [super init];
    if (self) {
        self.sourceArray = array;
        self.filterPredicate = filterPredicate;
        self.sortComparator = sortComparator;
        [self filterData];
    }

    return self;
}

+ (instancetype)dataSourceWithArray:(NSArray *)array
{
    return [self dataSourceWithArray:array filterPredicate:nil sortComparator:nil];
}

+ (instancetype)dataSourceWithArray:(NSArray *)array filterPredicate:(XBPredicateBlock)filterPredicate sortComparator:(NSComparator)sortComparator
{
    return [[self alloc] initWithArray:array filterPredicate:filterPredicate sortComparator:sortComparator];
}

- (id)objectAtIndexedSubscript:(NSUInteger)idx
{
    return self.filteredSortedArray[idx];
}

- (NSArray *)array
{
    return self.filteredSortedArray;
}

- (void)setArray:(NSArray *)array
{
    self.sourceArray = array;
    [self filterData];
}

- (NSUInteger)count
{
    return self.filteredSortedArray.count;
}

- (void)filter:(XBPredicateBlock)filterPredicate
{
    self.filterPredicate = filterPredicate;
    [self filterData];
}

- (void)sort:(NSComparator)sortComparator
{
    self.sortComparator = sortComparator;
    [self sortData];
}

- (void)filterData
{
    NSMutableArray *result = [NSMutableArray arrayWithCapacity:self.array.count];

    for (id item in self.sourceArray) {
        if (!self.filterPredicate || self.filterPredicate(item) ? item : nil) {
            [result addObject:item];
        }
    }

    self.filteredSortedArray = [result copy];

    [self sortData];
}

- (void)sortData
{
    if (self.sortComparator) {
        self.filteredSortedArray = [self.filteredSortedArray sortedArrayUsingComparator:self.sortComparator];
    }
}

@end
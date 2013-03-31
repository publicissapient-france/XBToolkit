//
// Created by akinsella on 29/03/13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "XBArrayDataSource.h"

@implementation XBArrayDataSource {
    NSArray *_array;
    NSArray *_filteredArray;
}

+ (id)dataSourceWithArray:(NSArray *)array {
    return [[self alloc] initWithArray:array];
}

- (id)initWithArray:(NSArray *)array {
    self = [super init];
    if (self) {
        self.array = array;
    }

    return self;
}

- (id)objectAtIndexedSubscript:(NSUInteger)idx {
    return _filteredArray[idx];
}

- (NSArray *)array {
    return _filteredArray;
}

- (void)setArray:(NSArray *)array {
    _array = array;
    _filteredArray = [_array copy];
}

- (NSUInteger)count {
    return _filteredArray.count;
}

- (void)filter:(XBPredicateBlock)filter {
    NSMutableArray *result = [NSMutableArray arrayWithCapacity:_array.count];

    for (id obj in _array) {
        id mapped = filter(obj) ? obj : nil;

        if (mapped) {
            [result addObject:mapped];
        }
    }

    _filteredArray = [result copy];
}

@end
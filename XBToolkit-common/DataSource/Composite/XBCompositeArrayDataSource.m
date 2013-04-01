//
// Created by akinsella on 25/03/13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "XBCompositeArrayDataSource.h"
#import "XBCompositeArrayDataSource+protected.h"
#import "XBArrayDataSource.h"
#import "XBArrayDataSource+protected.h"
#import "XBReloadableArrayDataSource.h"
#import "XBReloadableArrayDataSource+protected.h"

@implementation XBCompositeArrayDataSource


+ (id)dataSourceWithFirstDataSource:(XBReloadableArrayDataSource *)firstDataSource
                   secondDataSource:(XBReloadableArrayDataSource *)secondDataSource {
    return [[self alloc] initWithFirstDataSource:firstDataSource secondDataSource:secondDataSource];
}

- (id)initWithFirstDataSource:(XBReloadableArrayDataSource *)firstDataSource
             secondDataSource:(XBReloadableArrayDataSource *)secondDataSource {
    self = [super init];
    if (self) {
        self.firstDataSource = firstDataSource;
        self.secondDataSource = secondDataSource;
    }

    return self;
}

- (id)objectAtIndexedSubscript:(NSUInteger)idx {
    return [self.secondDataSource objectAtIndexedSubscript:idx];
}

- (NSUInteger)count {
    return self.secondDataSource.count;
}

- (NSError *)error {
    return self.firstDataSource.error ? self.firstDataSource.error : self.secondDataSource.error;
}

- (id)rawData {
    return self.secondDataSource.rawData;
}

- (NSArray *)array {
    return self.secondDataSource.array;
}

- (void)filter:(XBPredicateBlock)filterPredicate {
    [self.secondDataSource filter:filterPredicate];
}

- (void)sort:(NSComparator)sortComparator {
    [self.secondDataSource sort:sortComparator];
}


- (void)loadDataWithCallback:(void (^)())callback {
    [self.firstDataSource loadDataWithCallback:^{
        if (self.firstDataSource.error) {
            if (callback) {
                callback();
            }
        }
        else {
            [self.secondDataSource loadDataWithCallback:callback];
        }
    }];
}

@end
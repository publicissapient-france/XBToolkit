//
// Created by akinsella on 25/03/13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "XBCompositeArrayDataSource.h"
#import "XBArrayDataSource+Protected.h"

@interface XBCompositeArrayDataSource ()

@property(nonatomic, strong) XBReloadableArrayDataSource * firstDataSource;
@property(nonatomic, strong) XBReloadableArrayDataSource * secondDataSource;

@end

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
    return [self.secondDataSource sourceArray];
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

- (void)loadData:(XBReloadableArrayDataSourceCompletionBlock)completion
{
    [self.firstDataSource loadData:^(id operation){
        if (self.firstDataSource.error) {
            if (completion) {
                completion(operation);
            }
        }
        else {
            [self.secondDataSource loadData:completion];
        }
    }];
}

@end
//
// Created by akinsella on 26/03/13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "XBArrayDataSource.h"
#import "XBCompositeArrayDataSource.h"
#import "XBPagedCompositeArrayDataSource.h"
#import "XBCompositeArrayDataSource+protected.h"


@implementation XBPagedCompositeArrayDataSource

+ (id)dataSourceWithFirstDataSource:(XBReloadableArrayDataSource *)firstDataSource
                   secondDataSource:(XBReloadableArrayDataSource *)secondDataSource {
    return [[self alloc] initWithFirstDataSource:firstDataSource secondDataSource:secondDataSource];
}

- (id)initWithFirstDataSource:(XBReloadableArrayDataSource *)firstDataSource
             secondDataSource:(XBReloadableArrayDataSource *)secondDataSource {

    if (![[secondDataSource class] isSubclassOfClass:[XBInfiniteScrollArrayDataSource class]]) {
        [NSException raise:NSInvalidArgumentException format:@"secondDataSource is a sub class of class XBInfiniteScrollArrayDataSource"];
    }

    return [super initWithFirstDataSource:firstDataSource secondDataSource:secondDataSource];
}

-(XBInfiniteScrollArrayDataSource *)pagedSecondDataSource {
    return (XBInfiniteScrollArrayDataSource *)[self secondDataSource];
}

- (NSUInteger)totalCount {
    return [self firstDataSource].count;
}

- (void)loadMoreDataWithCallback:(void (^)())callback {
    [[self pagedSecondDataSource] loadMoreDataWithCallback:callback];
}

- (Boolean)hasMoreData {
    return [[self pagedSecondDataSource] hasMoreData];
}

@end
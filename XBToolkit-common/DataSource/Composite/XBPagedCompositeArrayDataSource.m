//
// Created by akinsella on 26/03/13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "XBArrayDataSource.h"
#import "XBCompositeArrayDataSource.h"
#import "XBPagedCompositeArrayDataSource.h"
#import "XBCompositeArrayDataSource+Protected.h"


@implementation XBPagedCompositeArrayDataSource

- (id)initWithFirstDataSource:(XBReloadableArrayDataSource *)firstDataSource
             secondDataSource:(XBReloadableArrayDataSource *)secondDataSource
{

    if (![[secondDataSource class] isSubclassOfClass:[XBInfiniteArrayDataSource class]]) {
        [NSException raise:NSInvalidArgumentException format:@"SecondDataSource must be a sub class of class XBInfiniteArrayDataSource"];
    }

    return [super initWithFirstDataSource:firstDataSource secondDataSource:secondDataSource];
}

+ (instancetype)dataSourceWithFirstDataSource:(XBReloadableArrayDataSource *)firstDataSource
                   secondDataSource:(XBReloadableArrayDataSource *)secondDataSource
{
    return [[self alloc] initWithFirstDataSource:firstDataSource secondDataSource:secondDataSource];
}

- (XBInfiniteArrayDataSource *)pagedSecondDataSource
{
    return (XBInfiniteArrayDataSource *)[self secondDataSource];
}

- (NSUInteger)totalCount
{
    return [self firstDataSource].count;
}

- (void)loadMoreDataWithCallback:(XBReloadableArrayDataSourceCompletionBlock)callback
{
    [[self pagedSecondDataSource] loadMoreData:callback];
}

- (BOOL)hasMoreData
{
    return [[self pagedSecondDataSource] hasMoreData];
}

@end
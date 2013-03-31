//
// Created by akinsella on 26/03/13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "XBArrayDataSource.h"
#import "XBCompositeArrayDataSource.h"
#import "XBPagedCompositeArrayDataSource.h"
#import "XBPagedArrayDataSource.h"
#import "XBCompositeArrayDataSource+protected.h"


@implementation XBPagedCompositeArrayDataSource

+ (id)dataSourceWithFirstDataSource:(XBLoadableArrayDataSource *)firstDataSource
                   secondDataSource:(XBLoadableArrayDataSource *)secondDataSource {
    return [[self alloc] initWithFirstDataSource:firstDataSource secondDataSource:secondDataSource];
}

- (id)initWithFirstDataSource:(XBLoadableArrayDataSource *)firstDataSource
             secondDataSource:(XBLoadableArrayDataSource *)secondDataSource {

    if (![secondDataSource conformsToProtocol:@protocol(XBPagedArrayDataSource)]) {
        [NSException raise:NSInvalidArgumentException format:@"secondDataSource does not conform to XBPagedArrayDataSource protocol"];
    }
    return [super initWithFirstDataSource:firstDataSource secondDataSource:secondDataSource];
}

-(NSObject<XBPagedArrayDataSource> *)pagedSecondDataSource {
    return (NSObject<XBPagedArrayDataSource> *)[self secondDataSource];
}

- (NSUInteger)totalCount {
    return [self firstDataSource].count;
}

- (void)loadNextPageWithCallback:(void (^)())callback {
    [[self pagedSecondDataSource] loadNextPageWithCallback:callback];
}

- (Boolean)hasMorePages {
    return [[self pagedSecondDataSource] hasMorePages];
}

@end
//
// Created by akinsella on 26/03/13.
//


#import <Foundation/Foundation.h>
#import "XBArrayDataSource.h"
#import "XBInfiniteArrayDataSource.h"
#import "XBCompositeArrayDataSource.h"
#import "XBInfiniteArrayDataSource.h"


@interface XBPagedCompositeArrayDataSource : XBCompositeArrayDataSource

- (NSUInteger)totalCount;

- (void)loadMoreDataWithCallback:(XBReloadableArrayDataSourceCompletionBlock)callback;

- (BOOL)hasMoreData;

@end
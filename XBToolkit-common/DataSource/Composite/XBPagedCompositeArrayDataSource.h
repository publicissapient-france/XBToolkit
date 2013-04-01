//
// Created by akinsella on 26/03/13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>
#import "XBArrayDataSource.h"
#import "XBInfiniteScrollArrayDataSource.h"
#import "XBCompositeArrayDataSource.h"
#import "XBInfiniteScrollArrayDataSource.h"

@interface XBPagedCompositeArrayDataSource : XBCompositeArrayDataSource

- (NSUInteger)totalCount;

- (void)loadMoreDataWithCallback:(void (^)())callback;

- (Boolean)hasMoreData;

@end
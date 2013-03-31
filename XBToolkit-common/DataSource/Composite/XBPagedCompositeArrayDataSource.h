//
// Created by akinsella on 26/03/13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>
#import "XBArrayDataSource.h"
#import "XBPagedArrayDataSource.h"
#import "XBCompositeArrayDataSource.h"

@interface XBPagedCompositeArrayDataSource : XBCompositeArrayDataSource<XBPagedArrayDataSource>

- (NSObject <XBPagedArrayDataSource> *)pagedSecondDataSource;

- (NSUInteger)totalCount;

- (void)loadNextPageWithCallback:(void (^)())callback;

- (Boolean)hasMorePages;

@end
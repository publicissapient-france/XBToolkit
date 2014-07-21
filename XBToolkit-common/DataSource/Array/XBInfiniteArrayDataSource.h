//
// Created by akinsella on 26/03/13.
//


#import <Foundation/Foundation.h>
#import "XBInfiniteArrayDataSource.h"
#import "XBReloadableArrayDataSource.h"
#import "XBDataPager.h"
#import "XBDataMerger.h"


@interface XBInfiniteArrayDataSource : XBReloadableArrayDataSource

- (instancetype)initWithDataLoader:(id <XBDataLoader>)dataLoader dataMerger:(id <XBDataMerger>)dataMerger dataPager:(id <XBDataPager>)dataPager;

+ (instancetype)dataSourceWithDataLoader:(id <XBDataLoader>)dataLoader dataMerger:(id <XBDataMerger>)dataMerger dataPager:(id <XBDataPager>)dataPager;

- (id <XBDataPager>)dataPager;

- (id)mergeObjects:(id)responseObject;

- (void)loadMoreData:(XBReloadableArrayDataSourceCompletionBlock)completion;

- (void)loadMoreData:(XBReloadableArrayDataSourceCompletionBlock)completion queue:(dispatch_queue_t)queue;

- (BOOL)hasMoreData;

@end
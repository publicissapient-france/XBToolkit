//
// Created by akinsella on 26/03/13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>
#import "XBInfiniteArrayDataSource.h"
#import "XBReloadableArrayDataSource.h"
#import "XBDataPager.h"
#import "XBDataMerger.h"

@interface XBInfiniteArrayDataSource : XBReloadableArrayDataSource

- (id)initWithDataLoader:(id <XBDataLoader>)dataLoader dataMerger:(id <XBDataMerger>)dataMerger dataPager:(id <XBDataPager>)dataPager;

+ (instancetype)dataSourceWithDataLoader:(id <XBDataLoader>)dataLoader dataMerger:(id <XBDataMerger>)dataMerger dataPager:(id <XBDataPager>)dataPager;

- (id)mergeObjects:(id)responseObject;

- (void)loadMoreData:(XBReloadableArrayDataSourceCompletionBlock)completion;

- (BOOL)hasMoreData;

@end
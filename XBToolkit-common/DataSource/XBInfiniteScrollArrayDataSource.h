//
// Created by akinsella on 26/03/13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>
#import "XBInfiniteScrollArrayDataSource.h"
#import "XBReloadableArrayDataSource.h"
#import "XBPaginator.h"
#import "XBDataMerger.h"

@interface XBInfiniteScrollArrayDataSource : XBReloadableArrayDataSource

+ (id)sourceWithDataLoader:(NSObject <XBDataLoader> *)dataLoader dataMapper:(NSObject <XBDataMapper> *)dataMapper dataMerger:(NSObject <XBDataMerger> *)dataMerger paginator:(NSObject <XBPaginator> *)paginator;
- (id)initWithDataLoader:(NSObject <XBDataLoader> *)dataLoader dataMapper:(NSObject <XBDataMapper> *)dataMapper dataMerger:(NSObject <XBDataMerger> *)dataMerger paginator:(NSObject <XBPaginator> *)paginator;

- (id)mergeRawData:(id)rawData;

- (void)loadMoreDataWithCallback:(void(^)())callback;

- (BOOL)hasMoreData;

@end
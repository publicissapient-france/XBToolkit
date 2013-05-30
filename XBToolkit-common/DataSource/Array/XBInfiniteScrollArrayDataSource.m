//
// Created by akinsella on 26/03/13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <JSONKit/JSONKit.h>
#import "XBInfiniteScrollArrayDataSource.h"
#import "XBInfiniteScrollArrayDataSource+protected.h"
#import "XBReloadableArrayDataSource+protected.h"
#import "XBDataMerger.h"
#import "XBDictionaryDataMerger.h"
#import "XBLogging.h"

@interface XBInfiniteScrollArrayDataSource()

@property(nonatomic, strong)NSObject<XBDataPager> *dataPager;

@property(nonatomic, strong)NSObject<XBDataMerger> *dataMerger;

@end

@implementation XBInfiniteScrollArrayDataSource

+ (id)dataSourceWithDataLoader:(NSObject <XBDataLoader> *)dataLoader dataMapper:(NSObject <XBDataMapper> *)dataMapper dataMerger:(NSObject <XBDataMerger> *)dataMerger dataPager:(NSObject <XBDataPager> *)dataPager {
    return [[self alloc] initWithDataLoader:dataLoader dataMapper:dataMapper dataMerger:dataMerger dataPager:dataPager];
}

- (id)initWithDataLoader:(NSObject <XBDataLoader> *)dataLoader dataMapper:(NSObject <XBDataMapper> *)dataMapper dataMerger:(NSObject <XBDataMerger> *)dataMerger dataPager:(NSObject <XBDataPager> *)dataPager {
    self = [super initWithDataLoader:dataLoader dataMapper:dataMapper];
    if (self) {
        self.dataPager = dataPager;
        self.dataMerger = dataMerger;
    }

    return self;
}

- (BOOL)hasMoreData {
    return [self.dataPager hasMorePages];
}

- (void)loadDataWithCallback:(void (^)())callback {
    [self.dataPager resetPageIncrement];
    [self fetchDataFromSourceInternalWithCallback:callback merge:NO];
}


- (void)loadMoreDataWithCallback:(void (^)())callback {
    if ([self hasMoreData]) {
        [self fetchDataFromSourceInternalWithCallback:callback merge:YES];
    }
    else if (callback) {
        callback();
    }
}

- (void)fetchDataFromSourceInternalWithCallback:(void (^)())callback merge:(BOOL)merge {

    [self.dataLoader loadDataWithSuccess:^(id jsonFetched) {
        [self processSuccessWithRawData:jsonFetched merge:merge];
        if (callback) {
            callback();
        }
    } failure:^(NSError *error) {
        XBLogWarn(@"Error: %@", error);
        self.error = error;
        if (callback) {
            callback();
        }
    }];
}

- (void)processSuccessWithRawData:(id)rawData merge:(BOOL)merge {
    id mergedRawData = !merge ? rawData : [self mergeRawData:rawData];
    [super processSuccessWithRawData:mergedRawData];
}

- (id)mergeRawData:(id)rawData {
    return [self.dataMerger mergeDataFromSource:rawData toDest:self.rawData];
}

@end

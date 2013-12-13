//
// Created by akinsella on 26/03/13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "XBInfiniteArrayDataSource.h"
#import "XBReloadableArrayDataSource+protected.h"
#import "XBLogging.h"

@interface XBInfiniteArrayDataSource ()

@property(nonatomic, strong) id <XBDataPager> dataPager;
@property(nonatomic, strong) id <XBDataMerger> dataMerger;

@end

@implementation XBInfiniteArrayDataSource

- (id)initWithDataLoader:(id <XBDataLoader>)dataLoader dataMerger:(id <XBDataMerger>)dataMerger dataPager:(id <XBDataPager>)dataPager
{
    self = [super initWithDataLoader:dataLoader];
    if (self) {
        self.dataPager = dataPager;
        self.dataMerger = dataMerger;
    }

    return self;
}

+ (instancetype)dataSourceWithDataLoader:(id <XBDataLoader>)dataLoader dataMerger:(id <XBDataMerger>)dataMerger dataPager:(id <XBDataPager>)dataPager
{
    return [[self alloc] initWithDataLoader:dataLoader dataMerger:dataMerger dataPager:dataPager];
}

- (BOOL)hasMoreData
{
    return [self.dataPager hasMorePages];
}

- (void)loadDataWithCallback:(void (^)())callback
{
    [self.dataPager resetPageIncrement];
    [self fetchDataFromSourceWithCallback:callback merge:NO];
}

- (void)loadMoreDataWithCallback:(void (^)())callback
{
    if ([self hasMoreData]) {
        [self fetchDataFromSourceWithCallback:callback merge:YES];
    }
    else if (callback) {
        callback();
    }
}

- (void)fetchDataFromSourceWithCallback:(void (^)())callback merge:(BOOL)merge
{
    [self.dataLoader loadDataWithSuccess:^(NSOperation *operation, id jsonFetched) {
        [self processSuccessWithRawData:jsonFetched merge:merge callback:^{
            if (callback) {
                callback();
            }
        }];
    } failure:^(NSOperation *operation, id responseObject, NSError *error) {
        XBLogWarn(@"Error: %@", error);
        self.error = error;
        if (callback) {
            callback();
        }
    }];
}

- (void)processSuccessWithRawData:(id)rawData merge:(BOOL)merge callback:(void (^)())callback
{
    id mergedRawData = !merge ? rawData : [self mergeRawData:rawData];
    [super processSuccessForResponseObject:mergedRawData callback:^{
        if (callback) {
            callback();
        }
    }];
}

- (id)mergeRawData:(id)rawData
{
    return [self.dataMerger mergeDataFromSource:rawData toDest:self.rawData];
}

@end

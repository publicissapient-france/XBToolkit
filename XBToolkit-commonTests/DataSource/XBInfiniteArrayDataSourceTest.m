//
// Created by akinsella on 01/04/13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "XBInfiniteArrayDataSource.h"
#import "GHUnit.h"
#import "XBTestUtils.h"
#import "XBHttpMappedDataLoader.h"
#import "XBJsonToArrayDataMapper.h"
#import "XBArrayDataSource+Protected.h"
#import "XBDictionaryDataMerger.h"
#import "XBArrayDataSourcePager.h"
#import "XBDataPagerHttpQueryDataBuilder.h"
#import "XBArrayDataMerger.h"

#define kNetworkTimeout 30.0f

@interface XBInfiniteArrayDataSourceTest : GHAsyncTestCase @end

@implementation XBInfiniteArrayDataSourceTest

- (void)testInfiniteArrayDataSource
{
    [self prepare];

    id httpClient = [XBTestUtils fakeHttpClientWithSuccessiveSuccessCallbackWithData:@[
            [XBTestUtils getAuthors:2 asArrayWithPage:1],
            [XBTestUtils getAuthors:2 asArrayWithPage:2],
            [XBTestUtils getAuthors:2 asArrayWithPage:3]
    ] parameterName:@"page"];


    XBArrayDataSourcePager *dataPager = [XBArrayDataSourcePager pagerWithItemsPerPage:2 totalNumberOfItems:5];
    
    XBDataPagerHttpQueryDataBuilder *httpQueryDataBuilder = [XBDataPagerHttpQueryDataBuilder builderWithDataPager:dataPager pageParameterName:@"page"];
    
    XBJsonToArrayDataMapper *dataMapper = [XBJsonToArrayDataMapper mapperWithRootKeyPath:@"authors" typeClass:[WPAuthor class]];
    XBHttpMappedDataLoader *dataLoader = [XBHttpMappedDataLoader dataLoaderWithHTTPClient:httpClient resourcePath:@"/wp-json-api/get_author_index/" dataMapper:dataMapper httpQueryParamBuilder:httpQueryDataBuilder];

    XBArrayDataMerger *dataMerger = [XBArrayDataMerger dataMerger];

    XBInfiniteArrayDataSource *dataSource = [XBInfiniteArrayDataSource dataSourceWithDataLoader:dataLoader dataMerger:dataMerger dataPager:dataPager];

    dataPager.dataSource = dataSource;

    void (^completed)() = ^() {
        [self notify:kGHUnitWaitStatusSuccess forSelector:@selector(testInfiniteArrayDataSource)];
    };
    
    [dataSource loadData:^(id operation){
        GHAssertTrue([dataSource hasMoreData], nil);

        [dataSource loadMoreData:^(id operation) {
            GHAssertTrue([dataSource hasMoreData], nil);
            
            [dataSource loadMoreData:^(id operation) {                
                completed();
            }];
        }];
    }];

    [self waitForStatus:kGHUnitWaitStatusSuccess timeout:kNetworkTimeout];

    GHAssertFalse([dataSource hasMoreData], nil);
    GHAssertNil(dataSource.error, [NSString stringWithFormat:@"Error[code: '%li', domain: '%@'", (long) dataSource.error.code, dataSource.error.domain]);
    GHAssertEquals([dataSource count], 5u, nil);

    WPAuthor *author = [XBTestUtils findAuthorInArray:dataSource.array ById:50];

    GHAssertEquals([author.identifier intValue], 50, nil);
    GHAssertEqualStrings(author.name, @"Alexis Kinsella", nil);
}

@end
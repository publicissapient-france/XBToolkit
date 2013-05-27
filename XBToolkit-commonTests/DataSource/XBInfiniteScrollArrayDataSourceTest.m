//
// Created by akinsella on 01/04/13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "XBInfiniteScrollArrayDataSource.h"
#import "GHUnit.h"
#import "XBTestUtils.h"
#import "XBHttpJsonDataLoader.h"
#import "XBJsonToArrayDataMapper.h"
#import "XBArrayDataSource+protected.h"
#import "XBDictionaryDataMerger.h"
#import "XBArrayDataSourceDataPager.h"
#import "XBDataPagerHttpQueryDataBuilder.h"

#define kNetworkTimeout 30.0f

@interface XBInfiniteScrollArrayDataSourceTest : GHAsyncTestCase @end

@implementation XBInfiniteScrollArrayDataSourceTest

-(void)testInfiniteScroll {
    [self prepare];

    id httpClient = [XBTestUtils fakeHttpClientWithSuccessiveSuccessCallbackWithData:@[
            [XBTestUtils getAuthorsAsJsonWithPage:1],
            [XBTestUtils getAuthorsAsJsonWithPage:2],
            [XBTestUtils getAuthorsAsJsonWithPage:3]
    ] parameterName:@"page"];


    XBArrayDataSourceDataPager *dataPager = [XBArrayDataSourceDataPager paginatorWithItemByPage:25];
    XBDataPagerHttpQueryDataBuilder *httpQueryDataBuilder = [XBDataPagerHttpQueryDataBuilder builderWithDataPager:dataPager pageParameterName:@"page"];

    XBHttpJsonDataLoader *dataLoader = [XBHttpJsonDataLoader dataLoaderWithHttpClient:httpClient
                                                                    httpQueryParamBuilder:httpQueryDataBuilder
                                                                         resourcePath:@"/wp-json-api/get_author_index/"];

    XBJsonToArrayDataMapper * dataMapper = [XBJsonToArrayDataMapper mapperWithRootKeyPath:@"authors" typeClass:[WPAuthor class]];

    XBDictionaryDataMerger * dataMerger = [XBDictionaryDataMerger dataMergerWithRootKeyPath: @"authors"];

    XBInfiniteScrollArrayDataSource *dataSource = [XBInfiniteScrollArrayDataSource dataSourceWithDataLoader:dataLoader
                                                                                                 dataMapper:dataMapper
                                                                                                 dataMerger:dataMerger
                                                                                                  dataPager:dataPager];

    dataPager.dataSource = dataSource;

    [dataSource loadDataWithCallback:^() {
        GHAssertTrue([dataSource hasMoreData], nil);

        [dataSource loadMoreDataWithCallback:^{
            [self notify:kGHUnitWaitStatusSuccess forSelector:@selector(testInfiniteScroll)];
        }];
    }];

    [self waitForStatus:kGHUnitWaitStatusSuccess timeout:kNetworkTimeout];

    GHAssertNil(dataSource.error, [NSString stringWithFormat:@"Error[code: '%li', domain: '%@'", (long) dataSource.error.code, dataSource.error.domain]);
    GHAssertEquals(dataSource.count, [@60 unsignedIntegerValue], nil);

    WPAuthor *author = [XBTestUtils findAuthorInArray:dataSource.array ById:50];

    GHAssertEquals([author.identifier intValue], 50, nil);
    GHAssertEqualStrings(author.slug, @"akinsella", nil);
    GHAssertEqualStrings(author.name, @"Alexis Kinsella", nil);
    GHAssertEqualStrings(author.first_name, @"Alexis", nil);
    GHAssertEqualStrings(author.last_name, @"Kinsella", nil);
    GHAssertEqualStrings(author.nickname, @"akinsella", nil);
    GHAssertEqualStrings(author.url, @"http://www.xebia.fr", nil);
    GHAssertEqualStrings(author.description_, @"", nil);
}

@end
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
#import "XBArrayDataSource+protected.h"
#import "XBDictionaryDataMerger.h"
#import "XBArrayDataSourceDataPager.h"
#import "XBDataPagerHttpQueryDataBuilder.h"
#import "XBArrayDataMerger.h"

#define kNetworkTimeout 30.0f

@interface XBInfiniteScrollArrayDataSourceTest : GHAsyncTestCase @end

@implementation XBInfiniteScrollArrayDataSourceTest

- (void)testInfiniteScroll
{
    [self prepare];

    id httpClient = [XBTestUtils fakeHttpClientWithSuccessiveSuccessCallbackWithData:@[
            [XBTestUtils getAuthors:2 asArrayWithPage:1],
            [XBTestUtils getAuthors:2 asArrayWithPage:2],
            [XBTestUtils getAuthors:2 asArrayWithPage:3]
    ] parameterName:@"page"];


    XBArrayDataSourceDataPager *dataPager = [XBArrayDataSourceDataPager paginatorWithItemsPerPage:2 totalNumberOfItems:5];
    
    XBDataPagerHttpQueryDataBuilder *httpQueryDataBuilder = [XBDataPagerHttpQueryDataBuilder builderWithDataPager:dataPager pageParameterName:@"page"];
    
    XBJsonToArrayDataMapper *dataMapper = [XBJsonToArrayDataMapper mapperWithRootKeyPath:@"authors" typeClass:[WPAuthor class]];
    XBHttpMappedDataLoader *dataLoader = [XBHttpMappedDataLoader dataLoaderWithHttpClient:httpClient resourcePath:@"/wp-json-api/get_author_index/" dataMapper:dataMapper httpQueryParamBuilder:httpQueryDataBuilder];

    XBArrayDataMerger *dataMerger = [XBArrayDataMerger dataMerger];

    XBInfiniteArrayDataSource *dataSource = [XBInfiniteArrayDataSource dataSourceWithDataLoader:dataLoader dataMerger:dataMerger dataPager:dataPager];

    dataPager.dataSource = dataSource;

    [dataSource loadDataWithCallback:^() {
        GHAssertTrue([dataSource hasMoreData], nil);

        [dataSource loadMoreDataWithCallback:^{
            [self notify:kGHUnitWaitStatusSuccess forSelector:@selector(testInfiniteScroll)];
        }];
    }];

    [self waitForStatus:kGHUnitWaitStatusSuccess timeout:kNetworkTimeout];

    GHAssertNil(dataSource.error, [NSString stringWithFormat:@"Error[code: '%li', domain: '%@'", (long) dataSource.error.code, dataSource.error.domain]);
    GHAssertEquals([dataSource count], 5u, nil);

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
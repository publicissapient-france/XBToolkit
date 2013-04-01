//
// Created by akinsella on 19/03/13.
//
// To change the template use AppCode | Preferences | File Templates.
//

#import "GHUnit.h"
#import "XBInfiniteScrollArrayDataSource.h"
#import "WPAuthor.h"
#import "XBHttpJsonDataLoader.h"
#import "XBJsonToArrayDataMapper.h"
#import "JSONKit.h"
#import "XBTestUtils.h"
#import "Underscore.h"
#import "XBArrayDataSource+protected.h"

#define kNetworkTimeout 30.0f

@interface XBHttpArrayDataSourceTest : GHAsyncTestCase @end

@implementation XBHttpArrayDataSourceTest

- (void)testFetchDataResult {
    [self prepare];

    id httpClient = [XBTestUtils fakeHttpClientWithSuccessCallbackWithData:[XBTestUtils getAuthorsAsJson]];

    XBHttpJsonDataLoader *dataLoader = [XBHttpJsonDataLoader dataLoaderWithHttpClient:httpClient
                                                                         resourcePath:@"/wp-json-api/get_author_index/"];

    XBJsonToArrayDataMapper * dataMapper = [XBJsonToArrayDataMapper mapperWithRootKeyPath:@"authors" typeClass:[WPAuthor class]];

    XBReloadableArrayDataSource *dataSource = [XBReloadableArrayDataSource dataSourceWithDataLoader:dataLoader
                                                                                         dataMapper:dataMapper];

    [dataSource loadDataWithCallback:^() {
        [self notify:kGHUnitWaitStatusSuccess forSelector:@selector(testFetchDataResult)];
    }];

    [self waitForStatus:kGHUnitWaitStatusSuccess timeout:kNetworkTimeout];

    GHAssertNil(dataSource.error, [NSString stringWithFormat:@"Error[code: '%li', domain: '%@'", (long) dataSource.error.code, dataSource.error.domain]);
    GHAssertEquals(dataSource.count, [@70 unsignedIntegerValue], nil);

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
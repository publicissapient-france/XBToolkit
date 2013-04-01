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

- (void)testFetchSearchIndexResult {
    [self prepare];
//    [[AFHTTPRequestOperationLogger sharedLogger] startLogging];

    id httpClient = [XBTestUtils fakeHttpClientWithSuccessCallbackWithData:[XBTestUtils getAuthorsAsJson]];

    XBHttpJsonDataLoader *dataLoader = [XBHttpJsonDataLoader dataLoaderWithHttpClient:httpClient
                                                                         resourcePath:@"/wp-json-api/get_author_index/"];

    XBJsonToArrayDataMapper * dataMapper = [XBJsonToArrayDataMapper mapperWithRootKeyPath:@"authors" typeClass:[WPAuthor class]];

    XBReloadableArrayDataSource *wpAuthorDS = [XBReloadableArrayDataSource dataSourceWithDataLoader:dataLoader
                                                                                         dataMapper:dataMapper];

    [wpAuthorDS loadDataWithCallback:^() {
        [self notify:kGHUnitWaitStatusSuccess forSelector:@selector(testFetchSearchIndexResult)];
    }];

    // Wait for the async activity to complete
    [self waitForStatus:kGHUnitWaitStatusSuccess timeout:kNetworkTimeout];
//    [self waitForStatus:kGHUnitWaitStatusSuccess timeout:kNetworkTimeout];

    GHAssertNil(wpAuthorDS.error, [NSString stringWithFormat:@"Error[code: '%li', domain: '%@'", (long)wpAuthorDS.error.code, wpAuthorDS.error.domain]);
    GHAssertEquals(wpAuthorDS.count, [@70 unsignedIntegerValue], @"Response should be different from 0");

    WPAuthor *wpAuthor = [XBTestUtils findAuthorInArray:wpAuthorDS.array ById:50];

    GHAssertEquals([wpAuthor.identifier intValue], 50, nil);
    GHAssertEqualStrings(wpAuthor.slug, @"akinsella", nil);
    GHAssertEqualStrings(wpAuthor.name, @"Alexis Kinsella", nil);
    GHAssertEqualStrings(wpAuthor.first_name, @"Alexis", nil);
    GHAssertEqualStrings(wpAuthor.last_name, @"Kinsella", nil);
    GHAssertEqualStrings(wpAuthor.nickname, @"akinsella", nil);
    GHAssertEqualStrings(wpAuthor.url, @"http://www.xebia.fr", nil);
    GHAssertEqualStrings(wpAuthor.description_, @"", nil);
}

@end
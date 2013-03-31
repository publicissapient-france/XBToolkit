//
// Created by akinsella on 19/03/13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "GHUnit.h"
#import "XBHttpArrayDataSource.h"
#import "XBPagedHttpArrayDataSource.h"
#import "WPAuthor.h"
#import "AFHTTPRequestOperationLogger.h"

#define kNetworkTimeout 30.0f

@interface XBHttpArrayDataSourceTest : GHAsyncTestCase @end

@implementation XBHttpArrayDataSourceTest

- (void)testFetchSearchIndexResult {
    [self prepare];
//    [[AFHTTPRequestOperationLogger sharedLogger] startLogging];

    XBHttpClient *httpClient = [[XBHttpClient alloc] initWithBaseUrl:@"http://blog.xebia.fr"];

    XBHttpArrayDataSourceConfiguration *configuration =
        [XBHttpArrayDataSourceConfiguration configurationWithResourcePath:@"/wp-json-api/get_author_index/"
                                                          storageFileName:@"wp-author"
                                                                typeClass:[WPAuthor class]
                                                              rootKeyPath:@"authors"];

    configuration.httpQueryParamBuilder = [XBBasicHttpQueryParamBuilder builderWithDictionary:@{@"count": @"10"}];

    XBHttpArrayDataSource *wpAuthorDS =
        [XBHttpArrayDataSource dataSourceWithConfiguration:configuration
                                                httpClient:httpClient];

    [wpAuthorDS loadDataWithForceReload:YES callback:^() {
        [self notify:kGHUnitWaitStatusSuccess forSelector:@selector(testFetchSearchIndexResult)];
    }];

    // Wait for the async activity to complete
    [self waitForStatus:kGHUnitWaitStatusSuccess timeout:kNetworkTimeout];
//    [self waitForStatus:kGHUnitWaitStatusSuccess timeout:kNetworkTimeout];

    GHAssertNil(wpAuthorDS.error, [NSString stringWithFormat:@"Error[code: '%li', domain: '%@'", (long)wpAuthorDS.error.code, wpAuthorDS.error.domain]);
    GHAssertTrue(wpAuthorDS.count > 0, @"Response should be different from 0");
}

@end
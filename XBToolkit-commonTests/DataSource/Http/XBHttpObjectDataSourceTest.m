//
// Created by Simone Civetta on 5/30/13.
//

#import "GHAsyncTestCase.h"
#import "XBTestUtils.h"
#import "XBHttpJsonDataLoader.h"
#import "WPPost.h"
#import "XBReloadableObjectDataSource.h"
#import "XBObjectDataSource+protected.h"
#import "XBJsonToObjectDataMapper.h"

#define kNetworkTimeout 30.0f

@interface XBHttpObjectDataSourceTest : GHAsyncTestCase @end

@implementation XBHttpObjectDataSourceTest

- (void)testFetchDataResult {

    [self prepare];

    id httpClient = [XBTestUtils fakeHttpClientWithSuccessCallbackWithData:[XBTestUtils getSinglePostAsJson]];

    XBHttpJsonDataLoader *dataLoader = [XBHttpJsonDataLoader dataLoaderWithHttpClient:httpClient
                                                                         resourcePath:@"/wp-json-api/get_post/?slug=whats-new-in-android"];

    XBJsonToObjectDataMapper * dataMapper = [XBJsonToObjectDataMapper mapperWithRootKeyPath:@"post" typeClass:[WPPost class]];

    XBReloadableObjectDataSource *dataSource = [XBReloadableObjectDataSource dataSourceWithDataLoader:dataLoader
                                                                                           dataMapper:dataMapper];

    [dataSource loadDataWithCallback:^() {
        [self notify:kGHUnitWaitStatusSuccess forSelector:@selector(testFetchDataResult)];
    }];

    [self waitForStatus:kGHUnitWaitStatusSuccess timeout:kNetworkTimeout];

    GHAssertNil(dataSource.error, [NSString stringWithFormat:@"Error[code: '%li', domain: '%@'", (long) dataSource.error.code, dataSource.error.domain]);

    WPPost *post = dataSource.object;

    GHAssertEquals([post.identifier intValue], 14332, nil);
    GHAssertEqualStrings(post.status, @"publish", nil);
    GHAssertEqualStrings(post.slug, @"whats-new-in-android", nil);
    GHAssertEqualStrings(post.type, @"post", nil);
    GHAssertEqualStrings(post.title, @"What's new in Android ?", nil);
    GHAssertEqualStrings(post.title_plain, @"What's new in Android ?", nil);
}

@end
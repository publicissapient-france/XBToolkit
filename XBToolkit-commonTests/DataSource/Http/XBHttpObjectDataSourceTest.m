//
// Created by Simone Civetta on 5/30/13.
//

#import "GHAsyncTestCase.h"
#import "XBTestUtils.h"
#import "XBHttpMappedDataLoader.h"
#import "WPPost.h"
#import "XBReloadableObjectDataSource.h"
#import "XBObjectDataSource+Protected.h"
#import "XBJsonToObjectDataMapper.h"

#define kNetworkTimeout 30.0f

@interface XBHttpObjectDataSourceTest : GHAsyncTestCase @end

@implementation XBHttpObjectDataSourceTest

- (void)testFetchDataResult {

    [self prepare];

    id httpClient = [XBTestUtils fakeHttpClientWithSuccessCallbackWithData:[XBTestUtils getSinglePostAsObject]];

    XBJsonToObjectDataMapper *dataMapper = [XBJsonToObjectDataMapper mapperWithRootKeyPath:@"post" typeClass:[WPPost class]];
    
    XBHTTPMappedDataLoader *dataLoader = [XBHTTPMappedDataLoader dataLoaderWithHTTPClient:httpClient resourcePath:@"/wp-json-api/get_post/?slug=whats-new-in-android" dataMapper:dataMapper];

    XBReloadableObjectDataSource *dataSource = [XBReloadableObjectDataSource dataSourceWithDataLoader:dataLoader];

    [dataSource loadData:^(id operation) {
        [self notify:kGHUnitWaitStatusSuccess forSelector:@selector(testFetchDataResult)];
    }];

    [self waitForStatus:kGHUnitWaitStatusSuccess timeout:kNetworkTimeout];

    GHAssertNil(dataSource.error, [NSString stringWithFormat:@"Error[code: '%li', domain: '%@'", (long) dataSource.error.code, dataSource.error.domain]);

    WPPost *post = dataSource.object;

    GHAssertEquals([post.identifier intValue], 14332, nil);
    GHAssertEqualStrings(post.slug, @"whats-new-in-android", nil);
    GHAssertEqualStrings(post.title, @"What's new in Android ?", nil);
    GHAssertEqualStrings(post.content, @"Lorem ipsum dolor sit amet", nil);
}

@end
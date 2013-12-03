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

    id httpClient = [XBTestUtils fakeHttpClientWithSuccessCallbackWithData:[XBTestUtils getSinglePostAsObject]];

    XBJsonToObjectDataMapper *dataMapper = [XBJsonToObjectDataMapper mapperWithRootKeyPath:@"post" typeClass:[WPPost class]];
    
    XBHttpJsonDataLoader *dataLoader = [XBHttpJsonDataLoader dataLoaderWithHttpClient:httpClient dataMapper:dataMapper resourcePath:@"/wp-json-api/get_post/?slug=whats-new-in-android"];

    XBReloadableObjectDataSource *dataSource = [XBReloadableObjectDataSource dataSourceWithDataLoader:dataLoader
                                                                                           dataMapper:dataMapper];

    [dataSource loadDataWithCallback:^() {
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
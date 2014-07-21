//
// Created by akinsella on 19/03/13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "GHUnit.h"
#import "WPAuthor.h"
#import "XBBundleJsonDataLoader.h"
#import "XBJsonToArrayDataMapper.h"
#import "XBJsonToObjectDataMapper.h"
#import "WPPost.h"
#import "XBReloadableObjectDataSource.h"

#define kNetworkTimeout 30.0f

@interface XBBundleObjectDataSourceTest : GHAsyncTestCase @end

@implementation XBBundleObjectDataSourceTest

- (void)testLoadDataSourceFromBundle
{
    [self prepare];

    XBJsonToObjectDataMapper *dataMapper = [XBJsonToObjectDataMapper mapperWithRootKeyPath:@"post" typeClass:[WPPost class]];
    XBBundleJsonDataLoader *dataLoader = [XBBundleJsonDataLoader dataLoaderWithResourcePath:@"wp-post" resourceType:@"json" dataMapper:dataMapper];
    XBReloadableObjectDataSource *bundleDS = [XBReloadableObjectDataSource dataSourceWithDataLoader:dataLoader];

    [bundleDS loadData:^(id operation) {
        [self notify:kGHUnitWaitStatusSuccess forSelector:@selector(testLoadDataSourceFromBundle)];
    }];

    // Wait for the async activity to complete
    [self waitForStatus:kGHUnitWaitStatusSuccess timeout:kNetworkTimeout];

    GHAssertNil(bundleDS.error, [NSString stringWithFormat:@"Error[code: '%ld', domain: '%@'", (long)bundleDS.error.code, bundleDS.error.domain]);
    GHAssertNotNil(bundleDS.object, @"Response should not be nil");
}

@end
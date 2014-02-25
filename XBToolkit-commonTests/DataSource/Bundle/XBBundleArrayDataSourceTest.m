//
// Created by akinsella on 19/03/13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "GHUnit.h"
#import "XBReloadableArrayDataSource.h"
#import "WPAuthor.h"
#import "XBBundleJsonDataLoader.h"
#import "XBJsonToArrayDataMapper.h"

#define kNetworkTimeout 30.0f

@interface XBBundleArrayDataSourceTest : GHAsyncTestCase @end

@implementation XBBundleArrayDataSourceTest

- (void)testLoadDataSourceFromBundle
{
    [self prepare];

    XBJsonToArrayDataMapper *dataMapper = [XBJsonToArrayDataMapper mapperWithRootKeyPath:@"authors" typeClass:[WPAuthor class]];
    XBBundleJsonDataLoader *dataLoader = [XBBundleJsonDataLoader dataLoaderWithResourcePath:@"wp-author-index" resourceType:@"json" dataMapper:dataMapper];
    XBReloadableArrayDataSource *bundleDS = [XBReloadableArrayDataSource dataSourceWithDataLoader:dataLoader];

    [bundleDS loadData:^(id operation) {
        [self notify:kGHUnitWaitStatusSuccess forSelector:@selector(testLoadDataSourceFromBundle)];
    }];

    // Wait for the async activity to complete
    [self waitForStatus:kGHUnitWaitStatusSuccess timeout:kNetworkTimeout];

    GHAssertNil(bundleDS.error, [NSString stringWithFormat:@"Error[code: '%ld', domain: '%@'", (long)bundleDS.error.code, bundleDS.error.domain]);
    GHAssertTrue(bundleDS.count > 0, @"Response should not be nil");

    WPAuthor *author0 = bundleDS[0];
    GHAssertEqualStrings(author0.slug, @"ealliaume", nil);
    
    WPAuthor *author1 = bundleDS[1];
    GHAssertEqualStrings(author1.slug, @"yamsellem", nil);
}

@end
//
// Created by akinsella on 19/03/13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "GHUnit.h"
#import "XBHttpArrayDataSource.h"
#import "XBBundleArrayDataSource.h"
#import "WPAuthor.h"

#define kNetworkTimeout 30.0f

@interface XBBundleArrayDataSourceTest : GHAsyncTestCase @end

@implementation XBBundleArrayDataSourceTest

- (void)testLoadDataSourceFromBundle {
    [self prepare];

    XBBundleArrayDataSourceConfiguration *configuration =
            [XBBundleArrayDataSourceConfiguration configurationWithResourcePath:@"wp-author-index"
                                                                   resourceType:@"json"
                                                                      typeClass:[WPAuthor class]];
    configuration.rootKeyPath = @"authors";

    XBBundleArrayDataSource *bundleDS = [XBBundleArrayDataSource dataSourceWithConfiguration:configuration];

    [bundleDS loadDataWithCallback:^() {
        [self notify:kGHUnitWaitStatusSuccess forSelector:@selector(testLoadDataSourceFromBundle)];
    }];

    // Wait for the async activity to complete
    [self waitForStatus:kGHUnitWaitStatusSuccess timeout:kNetworkTimeout];
//    [self waitForStatus:kGHUnitWaitStatusSuccess timeout:kNetworkTimeout];

    GHAssertNil(bundleDS.error, [NSString stringWithFormat:@"Error[code: '%i', domain: '%@'", (long)bundleDS.error.code, bundleDS.error.domain]);
    GHAssertTrue(bundleDS.count > 0, @"Response should not be nil");
}

@end
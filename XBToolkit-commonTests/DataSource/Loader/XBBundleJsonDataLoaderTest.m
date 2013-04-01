//
// Created by akinsella on 01/04/13.
//
// To change the template use AppCode | Preferences | File Templates.
//




#import "XBBundleJsonDataLoader.h"
#import "GHUnit.h"
#import "XBTestUtils.h"

#define kNetworkTimeout 30.0f

@interface XBBundleJsonDataLoaderTest : GHAsyncTestCase @end

@implementation XBBundleJsonDataLoaderTest

- (void)testFetchDataResult {
    [self prepare];

    XBBundleJsonDataLoader *dataLoader = [XBBundleJsonDataLoader dataLoaderWithResourcePath:@"wp-author-index" resourceType:@"json"];

    __block NSDictionary *responseData;
    __block NSError *responseError;

    [dataLoader loadDataWithSuccess:^(NSDictionary * data) {
        responseData = data;
        [self notify:kGHUnitWaitStatusSuccess forSelector:@selector(testFetchDataResult)];
    } failure:^(NSError *error) {
        responseError = error;
        [self notify:kGHUnitWaitStatusSuccess forSelector:@selector(testFetchDataResult)];
    }];

    [self waitForStatus:kGHUnitWaitStatusSuccess timeout:kNetworkTimeout];

    GHAssertNil(responseError, [NSString stringWithFormat:@"Error[code: '%li', domain: '%@'", (long)responseError.code, responseError.domain]);

    NSString *status = responseData[@"status"];
    NSNumber *count = responseData[@"count"];
    NSArray *authors = responseData[@"authors"];

    GHAssertEqualStrings(status, @"ok", nil);
    GHAssertEquals([count intValue], 70, nil);
    GHAssertEquals(authors.count, [@70 unsignedIntegerValue], nil);
}


@end
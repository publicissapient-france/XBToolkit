//
// Created by akinsella on 01/04/13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "XBCacheableDataLoader.h"
#import "XBHttpJsonDataLoader.h"
#import "GHUnit.h"
#import "XBTestUtils.h"
#import "XBFileSystemCacheSupport.h"
#import "XBHttpDataLoaderCacheKeyBuilder.h"

#define kNetworkTimeout 30.0f


@interface XBCacheableDataLoaderTest : GHAsyncTestCase @end

@implementation XBCacheableDataLoaderTest


- (void)testFetchDataResult {
    [self prepare];

    id httpClient = [XBTestUtils fakeHttpClientWithSuccessCallbackWithData:[XBTestUtils getAuthorsAsJson]];

    XBHttpJsonDataLoader *httpJsonDataLoader = [XBHttpJsonDataLoader dataLoaderWithHttpClient:httpClient
                                                                         resourcePath:@"/wp-json-api/get_author_index/"];

    XBFileSystemCacheSupport * cacheSupport = [XBFileSystemCacheSupport cacheSupportWithFilename:@"author-cache"];

    XBCache *cache = [XBCache cacheWithCacheSupport:cacheSupport];
    XBHttpDataLoaderCacheKeyBuilder *cacheKeyBuilder = [XBHttpDataLoaderCacheKeyBuilder cacheKeyBuilder];
    XBCacheableDataLoader *dataLoader = [XBCacheableDataLoader dataLoaderWithDataLoader:httpJsonDataLoader
                                                                              cache:cache
                                                                           cacheKeyBuilder:cacheKeyBuilder
                                                                                ttl:0];
    
    __block NSDictionary *responseData;
    __block NSError *responseError;

    [dataLoader loadDataWithSuccess:^(NSDictionary *data) {
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
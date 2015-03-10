//
// Created by akinsella on 01/04/13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "XBCacheableDataLoader.h"
#import "XBHttpMappedDataLoader.h"
#import "GHUnit.h"
#import "XBTestUtils.h"
#import "XBFileSystemCacheSupport.h"
#import "XBHttpDataLoaderCacheKeyBuilder.h"
#import "XBCache.h"

#define kNetworkTimeout 30.0f


@interface XBCacheableDataLoaderTest : GHAsyncTestCase @end

@implementation XBCacheableDataLoaderTest

- (void)testFetchDataResult
{
    [self prepare];
    
    id httpClient = [XBTestUtils fakeHttpClientWithSuccessCallbackWithData:[XBTestUtils getAuthorsAsArray]];

    XBHttpMappedDataLoader *httpJsonDataLoader = [XBHttpMappedDataLoader dataLoaderWithHttpClient:httpClient resourcePath:@"/wp-json-api/get_author_index/" dataMapper:nil];

    XBFileSystemCacheSupport *cacheSupport = [XBFileSystemCacheSupport cacheSupportWithFilename:@"author-cache"];

    XBCache *cache = [XBCache cacheWithCacheSupport:cacheSupport];
    XBHttpDataLoaderCacheKeyBuilder *cacheKeyBuilder = [XBHttpDataLoaderCacheKeyBuilder cacheKeyBuilder];
    XBCacheableDataLoader *dataLoader = [XBCacheableDataLoader dataLoaderWithDataLoader:httpJsonDataLoader
                                                                                  cache:cache
                                                                        cacheKeyBuilder:cacheKeyBuilder
                                                                         expirationTime:0];
    
    __block NSArray *responseData;
    __block NSError *responseError;

    [dataLoader loadDataWithSuccess:^(NSOperation *operation, id data) {
        responseData = data;
        [self notify:kGHUnitWaitStatusSuccess forSelector:@selector(testFetchDataResult)];
    } failure:^(NSOperation *operation, id responseObject, NSError *error) {
        responseError = error;
        [self notify:kGHUnitWaitStatusSuccess forSelector:@selector(testFetchDataResult)];
    }];

    [self waitForStatus:kGHUnitWaitStatusSuccess timeout:kNetworkTimeout];

    GHAssertNil(responseError, [NSString stringWithFormat:@"Error[code: '%li', domain: '%@'", (long)responseError.code, responseError.domain]);

    GHAssertEquals(responseData.count, [@6 unsignedIntegerValue], nil);
}


@end
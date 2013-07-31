//
// Created by akinsella on 01/04/13.
//
// To change the template use AppCode | Preferences | File Templates.
//



#import "XBHttpJsonDataLoader.h"
#import "GHUnit.h"
#import "XBTestUtils.h"

#define kNetworkTimeout 30.0f

@interface XBHttpJsonDataLoaderTest : GHAsyncTestCase @end

@implementation XBHttpJsonDataLoaderTest

- (void)testFetchDataResult {
    [self prepare];

    id httpClient = [XBTestUtils fakeHttpClientWithSuccessCallbackWithData:[XBTestUtils getAuthorsAsJson]];

    XBHttpJsonDataLoader *dataLoader = [XBHttpJsonDataLoader dataLoaderWithHttpClient:httpClient
                                                                         resourcePath:@"/wp-json-api/get_author_index/"];

    __block NSDictionary *responseData;
    __block NSError *responseError;

    [dataLoader loadDataWithSuccess:^(NSDictionary * data) {
        responseData = data;
        [self notify:kGHUnitWaitStatusSuccess forSelector:@selector(testFetchDataResult)];
    } failure:^(NSError *error, id jsonFetched) {
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

- (void)testFetchWithError
{
    [self prepare];
    
    NSError *error = [NSError errorWithDomain:@"xebia" code:404 userInfo:nil];
    id httpClient = [XBTestUtils fakeHttpClientWithErrorCallbackWithError:error data:[XBTestUtils getAuthorsAsJson]];
    
    XBHttpJsonDataLoader *dataLoader = [XBHttpJsonDataLoader dataLoaderWithHttpClient:httpClient
                                                                         resourcePath:@"/wp-json-api/get_author_index/"];
    
    __block NSDictionary *responseData;
    __block NSError *responseError;
    
    [dataLoader loadDataWithSuccess:^(NSDictionary * data) {
        [self notify:kGHUnitWaitStatusSuccess forSelector:@selector(testFetchWithError)];
    } failure:^(NSError *error, id jsonFetched) {
        responseError = error;
        responseData = (NSDictionary *)jsonFetched;
        [self notify:kGHUnitWaitStatusSuccess forSelector:@selector(testFetchWithError)];
    }];
    
    [self waitForStatus:kGHUnitWaitStatusSuccess timeout:kNetworkTimeout];
    
    GHAssertNotNil(responseError, @"The response error should not be nil");
    
    NSString *status = responseData[@"status"];
    NSNumber *count = responseData[@"count"];
    NSArray *authors = responseData[@"authors"];
    
    GHAssertEqualStrings(status, @"ok", nil);
    GHAssertEquals([count intValue], 70, nil);
    GHAssertEquals(authors.count, [@70 unsignedIntegerValue], nil);
}

@end
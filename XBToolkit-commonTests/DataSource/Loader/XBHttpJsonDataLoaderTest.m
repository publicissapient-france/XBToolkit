//
// Created by akinsella on 01/04/13.
//
// To change the template use AppCode | Preferences | File Templates.
//



#import "XBHttpMappedDataLoader.h"
#import "GHUnit.h"
#import "XBTestUtils.h"
#import <AFNetworking/AFNetworking.h>
#import <AFNetworking/AFHTTPRequestOperation.h>
#import <AFNetworking/AFURLConnectionOperation.h>

#define kNetworkTimeout 30.0f

@interface XBHttpJsonDataLoaderTest : GHAsyncTestCase @end

@implementation XBHttpJsonDataLoaderTest

- (void)testFetchDataResult {
    [self prepare];

    id httpClient = [XBTestUtils fakeHttpClientWithSuccessCallbackWithData:[XBTestUtils getAuthorsAsArray]];

    XBHttpMappedDataLoader *dataLoader = [XBHttpMappedDataLoader dataLoaderWithHTTPClient:httpClient resourcePath:@"/wp-json-api/get_author_index/" dataMapper:nil];

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

    GHAssertEqualStrings([responseData[0] name], @"Alexis Kinsella", nil);
    GHAssertEquals(responseData.count, [@6 unsignedIntegerValue], nil);
}

- (void)testFetchWithError
{
    [self prepare];
    
    NSError *error = [NSError errorWithDomain:@"xebia" code:404 userInfo:nil];
    id httpClient = [XBTestUtils fakeHttpClientWithErrorCallbackWithError:error data:[XBTestUtils getAuthorsAsArray]];
    
    XBHttpMappedDataLoader *dataLoader = [XBHttpMappedDataLoader dataLoaderWithHTTPClient:httpClient resourcePath:@"/wp-json-api/get_author_index/" dataMapper:nil];
    
    __block NSDictionary *responseData;
    __block NSError *responseError;
    
    [dataLoader loadDataWithSuccess:^(AFHTTPRequestOperation *operation, NSDictionary *data) {
        [self notify:kGHUnitWaitStatusSuccess forSelector:@selector(testFetchWithError)];
    } failure:^(AFHTTPRequestOperation *operation, id responseObject, NSError *error) {
        responseError = error;
        responseData = responseObject;
        [self notify:kGHUnitWaitStatusSuccess forSelector:@selector(testFetchWithError)];
    }];
    
    [self waitForStatus:kGHUnitWaitStatusSuccess timeout:kNetworkTimeout];
    
    GHAssertNotNil(responseError, @"The response error should not be nil");
    
    NSString *status = responseData[@"status"];
    NSNumber *count = responseData[@"count"];
    NSArray *authors = responseData[@"authors"];
    
    GHAssertEqualStrings(status, @"ko", nil);
    GHAssertEquals([count intValue], 70, nil);
    GHAssertEquals(authors.count, [@6 unsignedIntegerValue], nil);
}

@end
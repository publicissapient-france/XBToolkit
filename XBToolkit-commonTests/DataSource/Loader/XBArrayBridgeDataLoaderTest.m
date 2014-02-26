//
// Created by akinsella on 01/04/13.
//
// To change the template use AppCode | Preferences | File Templates.
//




#import "XBBundleJsonDataLoader.h"
#import "GHUnit.h"
#import "XBTestUtils.h"
#import "XBArrayBridgeDataLoader.h"
#import "XBJsonToArrayDataMapper.h"
#import "XBHttpMappedDataLoader.h"
#import "XBReloadableArrayDataSource+Protected.h"

#define kNetworkTimeout 30.0f

@interface XBArrayBridgeDataLoaderTest : GHAsyncTestCase @end

@implementation XBArrayBridgeDataLoaderTest

- (void)testFetchDataResult {
    [self prepare];

    id httpClient = [XBTestUtils fakeHttpClientWithSuccessCallbackWithData:[XBTestUtils getAuthorsAsArray]];
    XBJsonToArrayDataMapper *dataMapper = [XBJsonToArrayDataMapper mapperWithRootKeyPath:@"authors" typeClass:[WPAuthor class]];
    XBHttpMappedDataLoader *dataLoader = [XBHttpMappedDataLoader dataLoaderWithHttpClient:httpClient resourcePath:@"/wp-json-api/get_author_index/" dataMapper:dataMapper];
    XBReloadableArrayDataSource *dataSource = [XBReloadableArrayDataSource dataSourceWithDataLoader:dataLoader];

    XBArrayBridgeDataLoader *bridgeDataLoader = [XBArrayBridgeDataLoader dataLoaderWithDataSource:dataSource];

    __block NSArray *responseData;
    __block NSError *responseError;

    [dataSource loadData:^(id operation){
        [bridgeDataLoader loadDataWithSuccess:^(NSOperation *operation, NSArray *data) {
            responseData = data;
        } failure:^(NSOperation *operation, id responseObject, NSError *error) {
            responseError = error;
        }];
        [self notify:kGHUnitWaitStatusSuccess forSelector:@selector(testFetchDataResult)];
    }];

    [self waitForStatus:kGHUnitWaitStatusSuccess timeout:kNetworkTimeout];

    GHAssertNil(responseError, [NSString stringWithFormat:@"Error[code: '%li', domain: '%@'", (long)responseError.code, responseError.domain]);

    GHAssertEquals(dataSource.count, [@6 unsignedIntegerValue], nil);
    WPAuthor *author = [XBTestUtils findAuthorInArray:dataSource.array ById:50];
    GHAssertEquals([author.identifier intValue], 50, nil);
    GHAssertEqualStrings(author.name, @"Alexis Kinsella", nil);
}


@end
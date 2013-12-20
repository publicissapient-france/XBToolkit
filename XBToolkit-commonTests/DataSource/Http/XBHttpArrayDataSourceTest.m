//
// Created by akinsella on 19/03/13.
//
// To change the template use AppCode | Preferences | File Templates.
//

#import "GHUnit.h"
#import "XBInfiniteArrayDataSource.h"
#import "WPAuthor.h"
#import "XBHttpMappedDataLoader.h"
#import "XBJsonToArrayDataMapper.h"
#import "XBTestUtils.h"
#import "Underscore.h"
#import "XBArrayDataSource+Protected.h"

#define kNetworkTimeout 30.0f

@interface XBHttpArrayDataSourceTest : GHAsyncTestCase @end

@implementation XBHttpArrayDataSourceTest

- (void)testFetchDataResult {
    [self prepare];

    id httpClient = [XBTestUtils fakeHttpClientWithSuccessCallbackWithData:[XBTestUtils getAuthorsAsArray]];

    XBJsonToArrayDataMapper *dataMapper = [XBJsonToArrayDataMapper mapperWithRootKeyPath:@"authors" typeClass:[WPAuthor class]];
    
    XBHTTPMappedDataLoader *dataLoader = [XBHTTPMappedDataLoader dataLoaderWithHTTPClient:httpClient resourcePath:@"/wp-json-api/get_author_index/" dataMapper:dataMapper];

    XBReloadableArrayDataSource *dataSource = [XBReloadableArrayDataSource dataSourceWithDataLoader:dataLoader];

    [dataSource loadData:^(id operation){
        [self notify:kGHUnitWaitStatusSuccess forSelector:@selector(testFetchDataResult)];
    }];

    [self waitForStatus:kGHUnitWaitStatusSuccess timeout:kNetworkTimeout];

    GHAssertNil(dataSource.error, [NSString stringWithFormat:@"Error[code: '%li', domain: '%@'", (long) dataSource.error.code, dataSource.error.domain]);
    GHAssertEquals(dataSource.count, [@6 unsignedIntegerValue], nil);

    WPAuthor *author = [XBTestUtils findAuthorInArray:dataSource.array ById:50];

    GHAssertEquals([author.identifier intValue], 50, nil);
    GHAssertEqualStrings(author.name, @"Alexis Kinsella", nil);
}

@end
//
// Created by akinsella on 01/04/13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "XBJsonToArrayDataMapper.h"
#import "GHUnit.h"
#import "WPAuthor.h"
#import "XBTestUtils.h"
#import "WPPost.h"

NSTimeInterval kNetworkTimeout = 30.0;

@interface XBJsonToArrayDataMapperTest : GHAsyncTestCase @end

@implementation XBJsonToArrayDataMapperTest

- (void)testCount {
    
    [self prepare];

    __block NSArray *wpAuthors;
    XBJsonToArrayDataMapper *dataMapper = [XBJsonToArrayDataMapper mapperWithRootKeyPath:@"authors" typeClass:[WPAuthor class]];
    [dataMapper mapData:[XBTestUtils getAuthorsAsJson] withCompletionCallback:^(id mappedData) {
        wpAuthors = mappedData;
        [self notify:kGHUnitWaitStatusSuccess forSelector:@selector(testCount)];
    }];

    [self waitForStatus:kGHUnitWaitStatusSuccess timeout:kNetworkTimeout];

    GHAssertEquals(wpAuthors.count, [@70U unsignedIntegerValue], nil);
}

- (void)testValues {
    [self prepare];

    XBJsonToArrayDataMapper *dataMapper = [XBJsonToArrayDataMapper mapperWithRootKeyPath:@"authors" typeClass:[WPAuthor class]];
    __block NSArray *authors;

    [dataMapper mapData:[XBTestUtils getAuthorsAsJson] withCompletionCallback:^(id mappedData) {
        authors = mappedData;
        [self notify:kGHUnitWaitStatusSuccess forSelector:@selector(testValues)];
    }];

    [self waitForStatus:kGHUnitWaitStatusSuccess timeout:kNetworkTimeout];

    WPAuthor *wpAuthor = [XBTestUtils findAuthorInArray:authors ById:50];

    GHAssertEquals([wpAuthor.identifier intValue], 50, nil);
    GHAssertEqualStrings(wpAuthor.slug, @"akinsella", nil);
    GHAssertEqualStrings(wpAuthor.name, @"Alexis Kinsella", nil);
    GHAssertEqualStrings(wpAuthor.first_name, @"Alexis", nil);
    GHAssertEqualStrings(wpAuthor.last_name, @"Kinsella", nil);
    GHAssertEqualStrings(wpAuthor.nickname, @"akinsella", nil);
    GHAssertEqualStrings(wpAuthor.url, @"http://www.xebia.fr", nil);
    
    WPAuthor *authorWithPost = [XBTestUtils findAuthorInArray:authors ById:18];
    GHAssertEquals([authorWithPost.posts count], 1u, nil);
    GHAssertTrue([authorWithPost.posts[0] isKindOfClass:[WPPost class]], nil);
    GHAssertEqualStrings([authorWithPost.posts[0] slug], @"whats-new-in-android", nil);
}

@end
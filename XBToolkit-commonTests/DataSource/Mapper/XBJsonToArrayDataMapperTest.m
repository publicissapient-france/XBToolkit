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
#import <OCMock/OCMock.h>

@interface XBJsonToArrayDataMapperTest : GHTestCase @end

@implementation XBJsonToArrayDataMapperTest

- (void)testCount {
    XBJsonToArrayDataMapper *dataMapper = [XBJsonToArrayDataMapper mapperWithRootKeyPath:@"authors" typeClass:[WPAuthor class]];
    NSArray *wpAuthors = [dataMapper mappedObjectFromData:[XBTestUtils getAuthorsAsJson] error:nil];

    GHAssertEquals(wpAuthors.count, [@70U unsignedIntegerValue], nil);
}

- (void)testResponse {
    id mockHttpUrlResponse = [OCMockObject niceMockForClass:[NSHTTPURLResponse class]];
    [[[mockHttpUrlResponse stub] andReturnValue:@(200)] statusCode];
    [[[mockHttpUrlResponse stub] andReturn:@"application/json"] MIMEType];
    [[[mockHttpUrlResponse stub] andReturn:[NSURL URLWithString:@"http://mysql"]] URL];
    XBJsonToArrayDataMapper *dataMapper = [XBJsonToArrayDataMapper mapperWithRootKeyPath:@"authors" typeClass:[WPAuthor class]];
    NSArray *wpAuthors = [dataMapper responseObjectForResponse:mockHttpUrlResponse data:[XBTestUtils getAuthorsAsData] error:nil];
    
    GHAssertEquals(wpAuthors.count, [@70U unsignedIntegerValue], nil);
}

- (void)testValues {

    XBJsonToArrayDataMapper *dataMapper = [XBJsonToArrayDataMapper mapperWithRootKeyPath:@"authors" typeClass:[WPAuthor class]];

    NSArray *authors = [dataMapper mappedObjectFromData:[XBTestUtils getAuthorsAsJson] error:nil];
    
    WPAuthor *wpAuthor = [XBTestUtils findAuthorInArray:authors ById:50];

    GHAssertEquals([wpAuthor.identifier intValue], 50, nil);
    GHAssertEqualStrings(wpAuthor.slug, @"akinsella", nil);
    GHAssertEqualStrings(wpAuthor.name, @"Alexis Kinsella", nil);
    GHAssertEqualStrings(wpAuthor.first_name, @"Alexis", nil);
    GHAssertEqualStrings(wpAuthor.last_name, @"Kinsella", nil);
    GHAssertEqualStrings(wpAuthor.nickname, @"akinsella", nil);
    GHAssertEqualStrings(wpAuthor.url, @"http://www.xebia.fr", nil);
    
    WPAuthor *authorWithPost = [XBTestUtils findAuthorInArray:authors ById:18];
    GHAssertEquals((NSInteger)[authorWithPost.posts count], (NSInteger)1, nil);
    GHAssertTrue([authorWithPost.posts[0] isKindOfClass:[WPPost class]], nil);
    GHAssertEqualStrings([authorWithPost.posts[0] slug], @"whats-new-in-android", nil);
}

@end
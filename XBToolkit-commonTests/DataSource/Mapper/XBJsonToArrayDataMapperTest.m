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
    NSArray *wpAuthors = [dataMapper mappedObjectFromRawObject:[XBTestUtils getAuthorsAsJson]];

    GHAssertEquals(wpAuthors.count, [@70U unsignedIntegerValue], nil);
}

- (void)testResponse {
    id mockHTTPURLResponse = [OCMockObject niceMockForClass:[NSHTTPURLResponse class]];
    [[[mockHTTPURLResponse stub] andReturnValue:@(200)] statusCode];
    [[[mockHTTPURLResponse stub] andReturn:@"application/json"] MIMEType];
    [[[mockHTTPURLResponse stub] andReturn:[NSURL URLWithString:@"http://mysql"]] URL];
    XBJsonToArrayDataMapper *dataMapper = [XBJsonToArrayDataMapper mapperWithRootKeyPath:@"authors" typeClass:[WPAuthor class]];
    NSArray *wpAuthors = [dataMapper responseObjectForResponse:mockHTTPURLResponse data:[XBTestUtils getAuthorsAsData] error:nil];
    
    GHAssertEquals(wpAuthors.count, [@70U unsignedIntegerValue], nil);
}

- (void)testValues {

    XBJsonToArrayDataMapper *dataMapper = [XBJsonToArrayDataMapper mapperWithRootKeyPath:@"authors" typeClass:[WPAuthor class]];

    NSArray *authors = [dataMapper mappedObjectFromRawObject:[XBTestUtils getAuthorsAsJson]];
    
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
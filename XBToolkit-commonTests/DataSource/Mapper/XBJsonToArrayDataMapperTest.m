//
// Created by akinsella on 01/04/13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "XBJsonToArrayDataMapper.h"
#import "GHUnit.h"
#import "WPAuthor.h"
#import "XBTestUtils.h"

@interface XBJsonToArrayDataMapperTest : GHTestCase @end

@implementation XBJsonToArrayDataMapperTest

- (void)testCount {
    XBJsonToArrayDataMapper *dataMapper = [XBJsonToArrayDataMapper mapperWithRootKeyPath:@"authors" typeClass:[WPAuthor class]];
    NSArray *wpAuthors = [dataMapper mapData:[XBTestUtils getAuthorsAsJson]];

    GHAssertEquals(wpAuthors.count, [@70U unsignedLongValue], nil);
}

- (void)testValues {
    XBJsonToArrayDataMapper *dataMapper = [XBJsonToArrayDataMapper mapperWithRootKeyPath:@"authors" typeClass:[WPAuthor class]];
    NSArray *authors = [dataMapper mapData:[XBTestUtils getAuthorsAsJson]];

    WPAuthor *wpAuthor = [XBTestUtils findAuthorInArray:authors ById:50];

    GHAssertEquals([wpAuthor.identifier intValue], 50, nil);
    GHAssertEqualStrings(wpAuthor.slug, @"akinsella", nil);
    GHAssertEqualStrings(wpAuthor.name, @"Alexis Kinsella", nil);
    GHAssertEqualStrings(wpAuthor.first_name, @"Alexis", nil);
    GHAssertEqualStrings(wpAuthor.last_name, @"Kinsella", nil);
    GHAssertEqualStrings(wpAuthor.nickname, @"akinsella", nil);
    GHAssertEqualStrings(wpAuthor.url, @"http://www.xebia.fr", nil);
    GHAssertEqualStrings(wpAuthor.description_, @"", nil);
}

@end
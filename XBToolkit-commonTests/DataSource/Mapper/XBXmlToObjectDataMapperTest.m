//
// Created by akinsella on 01/04/13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "XBXmlToObjectDataMapper.h"
#import "GHUnit.h"
#import "WPAuthor.h"
#import "XBTestUtils.h"
#import "CDActu.h"
#import "CDArticle.h"

@interface XBXmlToObjectDataMapperTest : GHAsyncTestCase @end

@implementation XBXmlToObjectDataMapperTest

- (void)testValues {
    
    [self prepare];

    __block CDActu *wpActu;
    XBXmlToObjectDataMapper *dataMapper = [XBXmlToObjectDataMapper mapperWithRootXPath:nil typeClass:[CDActu class]];
    [dataMapper mapData:[XBTestUtils getActusAsXml] withCompletionCallback:^(id mappedData) {
        wpActu = mappedData;
        [self notify:kGHUnitWaitStatusSuccess forSelector:@selector(testValues)];
    }];

    [self waitForStatus:kGHUnitWaitStatusSuccess timeout:30.0];

    GHAssertNotNil(wpActu, nil);
    GHAssertEqualStrings(wpActu.dbConnectionStatus, @"OK", nil);
    GHAssertGreaterThan([[wpActu articles] count], 0u, nil);
    
    CDArticle *article = [wpActu articles][0];
    GHAssertTrue([article isKindOfClass:[CDArticle class]], nil);
    NSLog(@"%@", wpActu.articles);
}

@end
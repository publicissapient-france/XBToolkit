//
// Created by akinsella on 01/04/13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "XBBasicHttpQueryParamBuilder.h"
#import "GHUnit.h"

@interface XBBasicHttpQueryParamBuilderTest : GHTestCase @end

@implementation XBBasicHttpQueryParamBuilderTest

-(void)testBuild {
    XBBasicHttpQueryParamBuilder *httpQueryParamBuilder = [XBBasicHttpQueryParamBuilder builderWithDictionary:@{
        @"count": @20,
        @"page": @10,
        @"slug":@"ios"
    }];

    NSDictionary *dictionary = [httpQueryParamBuilder build];

    GHAssertEqualStrings(dictionary[@"slug"], @"ios", nil);
    GHAssertEquals([dictionary[@"count"] intValue], 20, nil);
    GHAssertEquals([dictionary[@"page"] intValue], 10, nil);
}

@end
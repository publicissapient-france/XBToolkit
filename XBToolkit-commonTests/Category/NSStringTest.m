//
// Created by Alexis Kinsella on 08/04/13.
// Copyright (c) 2013 Xebia IT Architets. All rights reserved.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "NSString+XBAdditions.h"

#import <Foundation/Foundation.h>
#import "GHUnit.h"

@interface NSStringTest : GHTestCase @end


@implementation NSStringTest

-(void)testShouldConvertStringToIndexSet {
    NSIndexSet * indexSet = [@"23,34,45" asIndexSet];

    GHAssertEquals([indexSet count], (NSUInteger)3, nil);
    GHAssertEquals([indexSet firstIndex], (NSUInteger)23, nil);
    GHAssertEquals([indexSet indexGreaterThanIndex:23], (NSUInteger)34, nil);
    GHAssertEquals([indexSet lastIndex], (NSUInteger)45, nil);
}

-(void)testShouldConvertStringToOneValueIndexSet {
    NSIndexSet * indexSet = [@"23" asIndexSet];

    GHAssertEquals([indexSet count], (NSUInteger)1, nil);
    GHAssertEquals([indexSet firstIndex], (NSUInteger)23, nil);
}

@end

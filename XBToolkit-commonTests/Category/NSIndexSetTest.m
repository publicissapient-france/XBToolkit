//
// Created by Alexis Kinsella on 08/04/13.
// Copyright (c) 2013 Xebia IT Architets. All rights reserved.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "GHUnit.h"
#import "NSIndexSet+XBAdditions.h"

@interface NSIndexSetTest : GHTestCase
@end

@implementation NSIndexSetTest

-(void)shouldConvertIndexSetToString {
    NSMutableIndexSet * indexSet = [NSMutableIndexSet indexSet];
    [indexSet addIndex:23];
    [indexSet addIndex:34];
    [indexSet addIndex:45];

    NSString *result = [indexSet joinByString:@","];

    GHAssertEqualStrings(result, @"23,34,45", nil);
}

-(void)shouldConvertIndexSetWithOneValueToString {
    NSMutableIndexSet * indexSet = [NSMutableIndexSet indexSetWithIndex:23];

    NSString *result = [indexSet joinByString:@","];

    GHAssertEqualStrings(result, @"23", nil);
}

@end
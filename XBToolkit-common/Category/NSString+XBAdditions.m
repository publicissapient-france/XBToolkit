//
//  NSString+XBAdditions.m
//  LaCentrale
//
//  Created by Simone Civetta on 4/1/13.
//  Copyright (c) 2013 Xebia IT Architets. All rights reserved.
//

#import "NSString+XBAdditions.h"

@implementation NSString (XBAdditions)

- (BOOL)insensitiveContainsString:(NSString *)subString {
    return [[self uppercaseString] rangeOfString:[subString uppercaseString]].location != NSNotFound;
}

-(NSURL *) url {
    return [NSURL URLWithString:self];
}


- (NSIndexSet *)asIndexSet {
    NSArray* elements = [self componentsSeparatedByString: @","];
    NSMutableIndexSet *indexSet = [NSMutableIndexSet indexSet];

    for (NSString * element in elements) {
        [indexSet addIndex:(NSUInteger)[element integerValue]];
    }

    return [indexSet copy];
}


@end

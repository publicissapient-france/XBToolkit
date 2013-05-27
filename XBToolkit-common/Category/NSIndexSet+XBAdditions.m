//
// Created by Alexis Kinsella on 08/04/13.
// Copyright (c) 2013 Xebia IT Architets. All rights reserved.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "NSIndexSet+XBAdditions.h"


@implementation NSIndexSet (XBAdditions)

- (NSArray *)asArray {
    NSMutableArray * brandIndexes = [NSMutableArray arrayWithCapacity:self.count];

    NSUInteger currentIndex = [self firstIndex];
    do {
        if (currentIndex != NSNotFound) {
            [brandIndexes addObject:[NSNumber numberWithUnsignedInt:currentIndex]];
        }
        currentIndex = [self indexGreaterThanIndex:currentIndex];
    } while (currentIndex != NSNotFound);

    return brandIndexes;
}

- (NSString *)joinByString:(NSString *)joinString {
    return [[self asArray] componentsJoinedByString:joinString];
}

@end
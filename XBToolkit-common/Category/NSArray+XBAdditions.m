//
// Created by Alexis Kinsella on 28/03/2014.
// Copyright (c) 2014 Xebia. All rights reserved.
//

#import "NSArray+XBAdditions.h"
#import "Underscore.h"


@implementation NSArray (XBAdditions)

// http://stackoverflow.com/questions/5453481/how-to-do-true-deep-copy-for-nsarray-and-nsdictionary-with-have-nested-arrays-di
- (NSMutableDictionary *)deepMutableCopy
{
    return (__bridge NSMutableDictionary *) (CFPropertyListCreateDeepCopy(kCFAllocatorDefault,
            (__bridge CFPropertyListRef) self,
            kCFPropertyListMutableContainersAndLeaves));
}
- (NSDictionary *)deepImmutableCopy
{
    return (__bridge NSDictionary *) (CFPropertyListCreateDeepCopy(kCFAllocatorDefault,
            (__bridge CFPropertyListRef) self,
            kCFPropertyListImmutable));
}

@end
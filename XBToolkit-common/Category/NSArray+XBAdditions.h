//
// Created by Alexis Kinsella on 28/03/2014.
// Copyright (c) 2014 Xebia. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (XBAdditions)

- (NSMutableDictionary *)deepMutableCopy;
- (NSDictionary *)deepImmutableCopy;

@end
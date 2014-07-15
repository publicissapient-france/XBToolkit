//
// Created by Simone Civetta on 5/30/13.
// Copyright (c) 2013 Xebia. All rights reserved.
//


#import <Foundation/Foundation.h>

@class XBHttpClient;

/**
 *  The simplest form of a `dataSource`, it is basically a wrapper around an object.
 */
@interface XBObjectDataSource : NSObject

- (instancetype)initWithObject:(NSObject *)object;

+ (instancetype)dataSourceWithObject:(NSObject *)object;

- (id)object;

@end
//
// Created by Simone Civetta on 5/30/13.
// Copyright (c) 2013 Xebia. All rights reserved.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>

@class XBHttpClient;

@interface XBObjectDataSource : NSObject

- (id)initWithObject:(NSObject *)object;

+ (instancetype)dataSourceWithObject:(NSObject *)object;

- (id)object;

@end
//
// Created by Simone Civetta on 26/02/14.
// Copyright (c) 2014 Xebia. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XBDataLoader.h"

@class XBReloadableArrayDataSource;


@interface XBArrayBridgeDataLoader : NSObject<XBDataLoader>

- (instancetype)initWithDataSource:(XBReloadableArrayDataSource *)dataSource;
+ (instancetype)dataLoaderWithDataSource:(XBReloadableArrayDataSource *)dataSource;

@end
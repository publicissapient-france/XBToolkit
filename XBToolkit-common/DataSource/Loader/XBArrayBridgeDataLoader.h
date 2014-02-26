//
// Created by Simone Civetta on 26/02/14.
// Copyright (c) 2014 Xebia. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XBDataLoader.h"

@class XBReloadableArrayDataSource;

typedef NSArray *(^XBArrayBridgeDataLoaderTransformationBlock)(XBReloadableArrayDataSource *dataSource);

@interface XBArrayBridgeDataLoader : NSObject<XBDataLoader>

@property (nonatomic, copy) XBArrayBridgeDataLoaderTransformationBlock transformationBlock;

- (instancetype)initWithDataSource:(XBReloadableArrayDataSource *)dataSource;

- (instancetype)initWithDataSource:(XBReloadableArrayDataSource *)dataSource transformationBlock:(XBArrayBridgeDataLoaderTransformationBlock)transformationBlock;

+ (instancetype)dataLoaderWithDataSource:(XBReloadableArrayDataSource *)dataSource;

+ (instancetype)dataLoaderWithDataSource:(XBReloadableArrayDataSource *)dataSource transformationBlock:(XBArrayBridgeDataLoaderTransformationBlock)transformationBlock;

@end
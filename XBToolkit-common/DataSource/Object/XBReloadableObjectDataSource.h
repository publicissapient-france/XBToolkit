//
// Created by Simone Civetta on 5/30/13.
// Copyright (c) 2013 Xebia. All rights reserved.
//


#import <Foundation/Foundation.h>
#import "XBObjectDataSource.h"

@protocol XBDataLoader;
@protocol XBDataMapper;

@interface XBReloadableObjectDataSource : XBObjectDataSource

@property (nonatomic, strong, readonly)NSError *error;
@property (nonatomic, strong, readonly)id rawData;
@property (nonatomic, strong, readonly)id<XBDataLoader> dataLoader;
@property (nonatomic, strong, readonly)id<XBDataMapper> dataMapper;

+ (instancetype)dataSourceWithDataLoader:(id <XBDataLoader>)dataLoader dataMapper:(id <XBDataMapper>)dataMapper;

- (id)initWithDataLoader:(id <XBDataLoader>)dataLoader dataMapper:(id <XBDataMapper>)dataMapper;

- (void)loadData;

- (void)loadDataWithCallback:(void (^)())callback;

@end
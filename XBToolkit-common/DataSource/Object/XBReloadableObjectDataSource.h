//
// Created by Simone Civetta on 5/30/13.
// Copyright (c) 2013 Xebia. All rights reserved.
//


#import <Foundation/Foundation.h>
#import "XBObjectDataSource.h"

@protocol XBDataLoader;
@protocol XBDataMapper;

#warning The urlResponse object gets lost :(
@interface XBReloadableObjectDataSource : XBObjectDataSource

@property (nonatomic, strong, readonly)NSError *error;
@property (nonatomic, strong, readonly)id rawData;
@property (nonatomic, strong, readonly)id<XBDataLoader> dataLoader;

- (id)initWithDataLoader:(id <XBDataLoader>)dataLoader;

+ (instancetype)dataSourceWithDataLoader:(id <XBDataLoader>)dataLoader;

- (void)loadData;

- (void)loadDataWithCallback:(void (^)())callback;

- (void)loadDataWithHttpMethod:(NSString *)httpMethod
                  withCallback:(void (^)())callback;

@end
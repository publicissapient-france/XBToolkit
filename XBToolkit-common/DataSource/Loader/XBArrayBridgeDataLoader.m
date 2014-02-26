//
// Created by Simone Civetta on 26/02/14.
// Copyright (c) 2014 Xebia. All rights reserved.
//

#import "XBArrayBridgeDataLoader.h"
#import "XBReloadableArrayDataSource.h"

@interface XBArrayBridgeDataLoader ()

@property (nonatomic, strong) XBReloadableArrayDataSource *dataSource;

@end

@implementation XBArrayBridgeDataLoader

- (instancetype)initWithDataSource:(XBReloadableArrayDataSource *)dataSource
{
    self = [super init];
    if (self) {
        self.dataSource = dataSource;
    }

    return self;
}

- (instancetype)initWithDataSource:(XBReloadableArrayDataSource *)dataSource transformationBlock:(XBArrayBridgeDataLoaderTransformationBlock)transformationBlock
{
    self = [super init];
    if (self) {
        self.dataSource = dataSource;
        self.transformationBlock = transformationBlock;
    }

    return self;
}

+ (instancetype)dataLoaderWithDataSource:(XBReloadableArrayDataSource *)dataSource
{
    return [[self alloc] initWithDataSource:dataSource transformationBlock:nil];
}

+ (instancetype)dataLoaderWithDataSource:(XBReloadableArrayDataSource *)dataSource transformationBlock:(XBArrayBridgeDataLoaderTransformationBlock)transformationBlock
{
    return [[self alloc] initWithDataSource:dataSource transformationBlock:transformationBlock];
}

- (void)loadDataWithSuccess:(XBDataLoaderSuccessBlock)success failure:(XBDataLoaderFailureBlock)failure
{
    if (self.dataSource.error) {
        failure(nil, self.dataSource.array, self.dataSource.error);
    } else {
        if (self.transformationBlock) {
            __weak XBArrayBridgeDataLoader *weakSelf = self;
            success(nil, self.transformationBlock(weakSelf.dataSource));
        } else {
            success(nil, self.dataSource.array);
        }
    }
}

@end
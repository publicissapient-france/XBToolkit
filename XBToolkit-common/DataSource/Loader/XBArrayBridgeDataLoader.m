//
// Created by Simone Civetta on 26/02/14.
// Copyright (c) 2014 Xebia. All rights reserved.
//

#import "XBArrayBridgeDataLoader.h"
#import "XBReloadableArrayDataSource.h"
#import "XBArrayDataSource.h"
#import "XBArrayTransformationOperation.h"

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
    [self loadDataWithSuccess:success failure:failure queue:dispatch_get_main_queue()];
}

- (void)loadDataWithSuccess:(XBDataLoaderSuccessBlock)success failure:(XBDataLoaderFailureBlock)failure queue:(dispatch_queue_t)queue
{
    if (self.dataSource.error) {
        failure(nil, self.dataSource.array, self.dataSource.error);
        return;
    }

    if (!self.transformationBlock) {
        success(nil, self.dataSource.array);
        return;
    }

    XBArrayTransformationOperation *operation = [XBArrayTransformationOperation operationWithTransformationBlock:self.transformationBlock forDataSource:self.dataSource];

    [operation setCompletionBlockWithSuccess:^(XBArrayTransformationOperation *transformationOperation) {
        success(transformationOperation, transformationOperation.responseObject);
    } failure:^(XBArrayTransformationOperation *transformationOperation, NSError *error) {
        failure(transformationOperation, transformationOperation.responseObject, error);
    } queue:queue];
    [operation start];
}


@end
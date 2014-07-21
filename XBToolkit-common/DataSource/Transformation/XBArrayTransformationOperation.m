//
//  XBArrayTransformationOperation.m
//  XBToolkit-ios
//
//  Created by Simone Civetta on 03/12/13.
//  Copyright (c) 2013 Xebia. All rights reserved.
//

#import "XBArrayTransformationOperation.h"
#import "XBJsonToObjectDataMapper.h"
#import "AFURLResponseSerialization.h"
#import "XBDataMapper.h"
#import "XBArrayDataSource.h"


@interface XBArrayTransformationOperation ()

@property (nonatomic, copy) XBArrayBridgeDataLoaderTransformationBlock transformationBlock;
@property (nonatomic, strong) id responseObject;

@property (readwrite, nonatomic, strong) XBArrayDataSource *dataSource;
@property (readwrite, nonatomic, strong) id transformedData;
@property (readwrite, nonatomic, strong) NSRecursiveLock *lock;

@end

static dispatch_group_t array_transformation_operation_completion_group() {
    static dispatch_group_t xb_array_transformation_operation_completion_group;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        xb_array_transformation_operation_completion_group = dispatch_group_create();
    });

    return xb_array_transformation_operation_completion_group;
}

@implementation XBArrayTransformationOperation

+ (instancetype)operationWithTransformationBlock:(XBArrayBridgeDataLoaderTransformationBlock)transformationBlock forDataSource:(XBArrayDataSource *)dataSource
{
    return [[self alloc] initWithTransformationBlock:transformationBlock forDataSource:dataSource];
}

- (void)setCompletionBlockWithSuccess:(void (^)(XBArrayTransformationOperation *operation))success failure:(void (^)(XBArrayTransformationOperation *operation, NSError *error))failure
{
    [self setCompletionBlockWithSuccess:success failure:failure queue:dispatch_get_main_queue()];
}

- (void)setCompletionBlockWithSuccess:(void (^)(XBArrayTransformationOperation *operation))success failure:(void (^)(XBArrayTransformationOperation *operation, NSError *error))failure queue:(dispatch_queue_t)queue
{
    [self.lock lock];
    __weak XBArrayTransformationOperation *weakSelf = self;
    self.completionBlock = ^{

        __strong __typeof(weakSelf)strongSelf = weakSelf;
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wgnu"
        dispatch_group_t group = array_transformation_operation_completion_group();
#pragma clang diagnostic pop

        dispatch_group_async(group, queue, ^{
            success(weakSelf);
        });

        dispatch_group_notify(group, queue, ^{
            [strongSelf setCompletionBlock:nil];
        });
    };
    [self.lock unlock];
}


- (instancetype)initWithTransformationBlock:(XBArrayBridgeDataLoaderTransformationBlock)transformationBlock forDataSource:(XBArrayDataSource *)dataSource
{
    if (self = [super init]) {
        self.transformationBlock = transformationBlock;
        self.dataSource = dataSource;
    }
    return self;
}

- (void)main
{
    __weak XBArrayTransformationOperation *weakSelf = self;
    self.transformedData = self.transformationBlock(weakSelf.dataSource);
}

- (id)responseObject
{
    return self.transformedData;
}

@end

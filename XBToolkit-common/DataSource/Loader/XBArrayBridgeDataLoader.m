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

+ (instancetype)dataLoaderWithDataSource:(XBReloadableArrayDataSource *)dataSource
{
    return [[self alloc] initWithDataSource:dataSource];
}

- (void)loadDataWithSuccess:(XBDataLoaderSuccessBlock)success failure:(XBDataLoaderFailureBlock)failure
{
    if (self.dataSource.error) {
        failure(nil, self.dataSource.array, self.dataSource.error);
    } else {
        success(nil, self.dataSource.array);
    }
}

@end
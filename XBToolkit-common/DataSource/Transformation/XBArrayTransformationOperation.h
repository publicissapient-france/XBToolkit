//
//  XBArrayTransformationOperation.h
//  XBToolkit-ios
//
//  Created by Simone Civetta on 03/12/13.
//  Copyright (c) 2013 Xebia. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XBToolkitOperation.h"
#import "XBArrayBridgeDataLoader.h"

@class XBJsonToObjectDataMapper;
@protocol AFURLResponseSerialization;
@protocol XBDataMapper;
@class AFJSONResponseSerializer;

@interface XBArrayTransformationOperation : NSOperation<XBToolkitOperation>

+ (instancetype)operationWithTransformationBlock:(XBArrayBridgeDataLoaderTransformationBlock)transformationBlock forDataSource:(XBArrayDataSource *)dataSource;

- (void)setCompletionBlockWithSuccess:(void (^)(XBArrayTransformationOperation *operation))success
                              failure:(void (^)(XBArrayTransformationOperation *operation, NSError *error))failure;

@end

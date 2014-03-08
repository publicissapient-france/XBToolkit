//
//  XBBundleJsonReadingOperation.h
//  XBToolkit-ios
//
//  Created by Simone Civetta on 03/12/13.
//  Copyright (c) 2013 Xebia. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XBToolkitOperation.h"

@class XBJsonToObjectDataMapper;
@protocol AFURLResponseSerialization;
@protocol XBDataMapper;
@class AFJSONResponseSerializer;

@interface XBBundleJsonReadingOperation : NSOperation<XBToolkitOperation>

+ (instancetype)operationWithBundle:(NSBundle *)bundle resourcePath:(NSString *)resourcePath resourceType:(NSString *)resourceType;

@property (nonatomic, assign) NSDataReadingOptions dataReadingOptions;
@property (nonatomic, assign) NSJSONReadingOptions jsonReadingOptions;
@property (nonatomic, strong) AFJSONResponseSerializer<AFURLResponseSerialization, XBDataMapper> *dataMapper;

- (void)setCompletionBlockWithSuccess:(void (^)(XBBundleJsonReadingOperation *operation))success
                              failure:(void (^)(XBBundleJsonReadingOperation *operation, NSError *error))failure;

- (void)setCompletionBlockWithSuccess:(void (^)(XBBundleJsonReadingOperation *operation))success failure:(void (^)(XBBundleJsonReadingOperation *operation, NSError *error))failure queue:(dispatch_queue_t)queue;
@end

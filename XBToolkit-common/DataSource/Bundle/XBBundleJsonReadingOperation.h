//
//  XBBundleJsonReadingOperation.h
//  XBToolkit-ios
//
//  Created by Simone Civetta on 03/12/13.
//  Copyright (c) 2013 Xebia. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XBToolkitOperation.h"

@interface XBBundleJsonReadingOperation : NSOperation<XBToolkitOperation>

+ (instancetype)operationWithBundle:(NSBundle *)bundle resourcePath:(NSString *)resourcePath resourceType:(NSString *)resourceType;

@property (nonatomic, assign) NSJSONReadingOptions readingOptions;

- (void)setCompletionBlockWithSuccess:(void (^)(XBBundleJsonReadingOperation *operation))success
                              failure:(void (^)(XBBundleJsonReadingOperation *operation, NSError *error))failure;

@end

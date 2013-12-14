//
//  XBBundleJsonReadingOperation.m
//  XBToolkit-ios
//
//  Created by Simone Civetta on 03/12/13.
//  Copyright (c) 2013 Xebia. All rights reserved.
//

#import "XBBundleJsonReadingOperation.h"

@interface XBBundleJsonReadingOperation ()

@property (nonatomic, strong) NSBundle *bundle;
@property (nonatomic, strong) NSString *resourcePath;
@property (nonatomic, strong) NSString *resourceType;
@property (nonatomic, strong) id responseObject;
@property (nonatomic, strong) NSError *error;

@end

@implementation XBBundleJsonReadingOperation

+ (instancetype)operationWithBundle:(NSBundle *)bundle resourcePath:(NSString *)resourcePath resourceType:(NSString *)resourceType
{
    return [[self alloc] initWithBundle:bundle resourcePath:resourcePath resourceType:resourceType];
}

- (void)setCompletionBlockWithSuccess:(void (^)(XBBundleJsonReadingOperation *operation))success failure:(void (^)(XBBundleJsonReadingOperation *operation, NSError *error))failure
{
    __weak XBBundleJsonReadingOperation *weakSelf = self;
    self.completionBlock = ^{
        if (weakSelf.error) {
            failure(weakSelf, weakSelf.error);
        } else {
            success(weakSelf);
        }
    };
}

- (id)initWithBundle:(NSBundle *)bundle resourcePath:(NSString *)resourcePath resourceType:(NSString *)resourceType
{
    if (self = [super init]) {
        self.bundle = bundle;
        self.resourcePath = resourcePath;
        self.resourceType = resourceType;
    }
    return self;

}

- (void)main
{    
    NSString *file = [self.bundle pathForResource:self.resourcePath ofType:self.resourceType];
    NSError *error;
    NSData *jsonData = [NSData dataWithContentsOfFile:file options:0 error:&error];
    self.responseObject = [NSJSONSerialization JSONObjectWithData:jsonData options:self.readingOptions error:&error];
    self.error = error;
}

- (id)responseObject
{
    return _responseObject;
}

@end

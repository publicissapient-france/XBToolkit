//
//  XBBundleJsonReadingOperation.m
//  XBToolkit-ios
//
//  Created by Simone Civetta on 03/12/13.
//  Copyright (c) 2013 Xebia. All rights reserved.
//

#import "XBBundleJsonReadingOperation.h"
#import "XBJsonToObjectDataMapper.h"
#import "AFURLResponseSerialization.h"
#import "XBDataMapper.h"

@interface XBBundleJsonReadingOperation ()

@property (nonatomic, strong) NSBundle *bundle;
@property (nonatomic, strong) NSString *resourcePath;
@property (nonatomic, strong) NSString *resourceType;
@property (nonatomic, strong) id responseObject;
@property (nonatomic, strong) NSError *error;

@property (readwrite, nonatomic, strong) NSData *rawData;
@property (readwrite, nonatomic, strong) NSRecursiveLock *lock;

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
    self.rawData = [NSData dataWithContentsOfFile:file options:self.dataReadingOptions error:&error];
    self.error = error;
}

- (id)responseObject {
    
    if (!self.dataMapper) {
        if (!_responseObject) {
            NSError *error;
            _responseObject = [NSJSONSerialization JSONObjectWithData:self.rawData options:self.jsonReadingOptions error:&error];
            if (error) {
                self.error = error;
            }
        }
        
        return _responseObject;
    }
    
    [self.lock lock];
    if (!_responseObject && [self isFinished] && !self.error) {
        NSError *error = nil;
        self.responseObject = [self.dataMapper responseObjectForResponse:nil data:self.rawData error:&error];
        if (error) {
            self.error = error;
        }
    }
    [self.lock unlock];

    return _responseObject;
}

@end

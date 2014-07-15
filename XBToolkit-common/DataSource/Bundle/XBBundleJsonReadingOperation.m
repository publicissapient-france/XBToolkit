//
//  XBBundleJsonReadingOperation.m
//  XBToolkit-ios
//
//  Created by Simone Civetta on 03/12/13.
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


static dispatch_group_t bundle_json_reading_operation_completion_group() {
    static dispatch_group_t xb_bundle_json_reading_operation_completion_group;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        xb_bundle_json_reading_operation_completion_group = dispatch_group_create();
    });

    return xb_bundle_json_reading_operation_completion_group;
}


@implementation XBBundleJsonReadingOperation

+ (instancetype)operationWithBundle:(NSBundle *)bundle resourcePath:(NSString *)resourcePath resourceType:(NSString *)resourceType
{
    return [[self alloc] initWithBundle:bundle resourcePath:resourcePath resourceType:resourceType];
}

- (void)setCompletionBlockWithSuccess:(void (^)(XBBundleJsonReadingOperation *operation))success failure:(void (^)(XBBundleJsonReadingOperation *operation, NSError *error))failure {
    [self setCompletionBlockWithSuccess:success failure:failure queue:dispatch_get_main_queue()];
}

- (void)setCompletionBlockWithSuccess:(void (^)(XBBundleJsonReadingOperation *operation))success failure:(void (^)(XBBundleJsonReadingOperation *operation, NSError *error))failure queue:(dispatch_queue_t)queue
{
    [self.lock lock];
    __weak XBBundleJsonReadingOperation *weakSelf = self;
    self.completionBlock = ^{

        __strong __typeof(weakSelf)strongSelf = weakSelf;
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wgnu"
        dispatch_group_t group = bundle_json_reading_operation_completion_group();
#pragma clang diagnostic pop

        dispatch_group_async(group, queue, ^{
            if (weakSelf.error) {
                failure(weakSelf, weakSelf.error);
            } else {
                success(weakSelf);
            }
        });

        dispatch_group_notify(group, queue, ^{
            [strongSelf setCompletionBlock:nil];
        });
    };
    [self.lock unlock];
}

- (instancetype)initWithBundle:(NSBundle *)bundle resourcePath:(NSString *)resourcePath resourceType:(NSString *)resourceType
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

- (id)responseObject
{
    
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

//
// Created by akinsella on 31/03/13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "XBHttpJsonDataLoader.h"
#import "XBHttpQueryParamBuilder.h"
#import "XBBundleJsonDataLoader.h"
#import "XBLogging.h"
#import "XBBundleJsonReadingOperation.h"

@interface XBBundleJsonDataLoader()

@property (nonatomic, strong)NSString *resourcePath;
@property (nonatomic, strong)NSString *resourceType;

@end

@implementation XBBundleJsonDataLoader

- (id)initWithResourcePath:(NSString *)resourcePath resourceType:(NSString *)resourceType
{
    self = [super init];
    if (self) {
        self.resourcePath = resourcePath;
        self.resourceType = resourceType;
        self.readingOptions = 0;
    }

    return self;
}

+ (instancetype)dataLoaderWithResourcePath:(NSString *)resourcePath resourceType:(NSString *)resourceType
{
    return [[self alloc] initWithResourcePath:resourcePath resourceType:resourceType];
}

- (void)loadDataWithSuccess:(XBDataLoaderSuccessBlock)success failure:(XBDataLoaderFailureBlock)failure
{
    XBBundleJsonReadingOperation *operation = [XBBundleJsonReadingOperation operationWithBundle:[NSBundle mainBundle] resourcePath:self.resourcePath resourceType:self.resourceType];
    
    [operation setCompletionBlockWithSuccess:^(XBBundleJsonReadingOperation *operation) {
        XBLogVerbose(@"Json loaded from bundle: %@", operation.responseObject);
        success(operation, operation.responseObject);
    } failure:^(XBBundleJsonReadingOperation *operation, NSError *error) {
        failure(operation, operation.responseObject, error);
    }];
    [operation start];

}

@end
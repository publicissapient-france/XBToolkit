//
// Created by akinsella on 31/03/13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "XBHttpJsonDataLoader.h"
#import "XBHttpQueryParamBuilder.h"
#import "JSONKit.h"
#import "XBBundleJsonDataLoader.h"

@interface XBBundleJsonDataLoader()

@property (nonatomic, strong)NSString *resourcePath;
@property (nonatomic, strong)NSString *resourceType;

@end

@implementation XBBundleJsonDataLoader

+ (id)loaderWithResourcePath:(NSString *)resourcePath resourceType:(NSString *)resourceType {
    return [[self alloc] initWithResourcePath:resourcePath resourceType:resourceType];
}

- (id)initWithResourcePath:(NSString *)resourcePath resourceType:(NSString *)resourceType {
    self = [super init];
    if (self) {
        self.resourcePath = resourcePath;
        self.resourceType = resourceType;
    }

    return self;
}

- (void)loadDataWithSuccess:(void (^)(id))success failure:(void (^)(NSError *))failure {
    NSBundle *mainBundle = [NSBundle mainBundle];
    NSString *file = [mainBundle pathForResource:self.resourcePath ofType:self.resourceType];
    NSError *error;
    NSString *jsonLoaded = [NSString stringWithContentsOfFile:file encoding:NSUTF8StringEncoding error:&error];
    NSDictionary *json = [jsonLoaded objectFromJSONString];

    if (!error) {
        DDLogVerbose(@"Json loaded from bundle: %@", json);
        success(json);
    }
    else {
        failure(error);
    }

}

@end
//
// Created by akinsella on 31/03/13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "XBHttpJsonDataLoader.h"

@interface XBHttpJsonDataLoader()
@property (nonatomic, strong)NSString *resourcePath;
@property (nonatomic, strong)XBHttpClient *httpClient;
@property (nonatomic, strong)NSObject<XBHttpQueryParamBuilder> *httpQueryParamBuilder;
@end

@implementation XBHttpJsonDataLoader

+ (id)dataLoaderWithHttpClient:(XBHttpClient *)httpClient resourcePath:(NSString *)resourcePath {
    return [self dataLoaderWithHttpClient:httpClient httpQueryParamBuilder:nil resourcePath:resourcePath];
}

+ (id)dataLoaderWithHttpClient:(XBHttpClient *)httpClient httpQueryParamBuilder:(NSObject <XBHttpQueryParamBuilder> *)httpQueryParamBuilder resourcePath:(NSString *)resourcePath {
    return [[self alloc] initWithHttpClient:httpClient httpQueryParamBuilder:httpQueryParamBuilder resourcePath:resourcePath];
}

- (id)initWithHttpClient:(XBHttpClient *)httpClient httpQueryParamBuilder:(NSObject <XBHttpQueryParamBuilder> *)httpQueryParamBuilder resourcePath:(NSString *)resourcePath {
    self = [super init];
    if (self) {
        self.httpClient = httpClient;
        self.httpQueryParamBuilder = httpQueryParamBuilder;
        self.resourcePath = resourcePath;
    }

    return self;
}

- (void)loadDataWithSuccess:(void (^)(id))success failure:(void (^)(NSError *))failure {
    NSDictionary *parameters = self.httpQueryParamBuilder ? [self.httpQueryParamBuilder build] : nil;
    [self.httpClient executeGetJsonRequestWithPath:self.resourcePath parameters:parameters
       success:^(NSURLRequest *request, NSHTTPURLResponse *response, id jsonFetched) {
           if (success) {
               success(jsonFetched);
           }
       }
       failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id jsonFetched) {
           if (failure) {
               failure(jsonFetched);
           }
       }
    ];
}

@end
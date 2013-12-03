//
// Created by akinsella on 31/03/13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <AFNetworking/AFHTTPRequestOperationManager.h>
#import "XBHttpJsonDataLoader.h"
#import "XBDataMapper.h"

@interface XBHttpJsonDataLoader()
@property (nonatomic, strong) NSString *resourcePath;
@property (nonatomic, strong) XBHttpClient *httpClient;
@property (nonatomic, strong) id <XBDataMapper> dataMapper;
@property (nonatomic, strong) id <XBHttpQueryParamBuilder> httpQueryParamBuilder;
@end

@implementation XBHttpJsonDataLoader

- (id)initWithHttpClient:(XBHttpClient *)httpClient dataMapper:(id <XBDataMapper>)dataMapper resourcePath:(NSString *)resourcePath httpQueryParamBuilder:(id <XBHttpQueryParamBuilder>)httpQueryParamBuilder
{
    self = [super init];
    if (self) {
        self.httpClient = httpClient;
        self.dataMapper = dataMapper;
        self.httpClient.httpRequestOperationManager.responseSerializer = dataMapper;
        #warning HttpQueryParamBuilder... is it still needed?
        self.httpQueryParamBuilder = httpQueryParamBuilder;
        self.resourcePath = resourcePath;
    }

    return self;
}

+ (instancetype)dataLoaderWithHttpClient:(XBHttpClient *)httpClient dataMapper:(id <XBDataMapper>)dataMapper resourcePath:(NSString *)resourcePath
{
    return [self dataLoaderWithHttpClient:httpClient httpQueryParamBuilder:nil resourcePath:resourcePath];
}

+ (instancetype)dataLoaderWithHttpClient:(XBHttpClient *)httpClient httpQueryParamBuilder:(id <XBHttpQueryParamBuilder>)httpQueryParamBuilder resourcePath:(NSString *)resourcePath
{
    return [[self alloc] initWithHttpClient:httpClient dataMapper:nil resourcePath:resourcePath httpQueryParamBuilder:httpQueryParamBuilder];
}

#warning replace jsonFetched
- (void)loadDataWithHttpMethod:(NSString *)httpMethod withSuccess:(XBDataLoaderSuccessBlock)success failure:(XBDataLoaderFailureBlock)failure
{
    NSDictionary *parameters = self.httpQueryParamBuilder ? [self.httpQueryParamBuilder build] : nil;

    [self.httpClient executeJsonRequestWithPath:self.resourcePath method:httpMethod parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (success) {
            success(operation, responseObject);
        }
    } failure:^(AFHTTPRequestOperation *operation, id responseObject, NSError *error) {
        if (failure) {
            failure(operation, responseObject, error);
        }
    }];
}

- (void)loadDataWithSuccess:(XBDataLoaderSuccessBlock)success failure:(XBDataLoaderFailureBlock)failure
{
    [self loadDataWithHttpMethod:@"GET" withSuccess:success failure:failure];
}

- (void)setDataMapper:(id <XBDataMapper>)dataMapper
{
    _dataMapper = dataMapper;
    self.httpClient.httpRequestOperationManager.responseSerializer = dataMapper;
}

- (void)setHttpClient:(XBHttpClient *)httpClient
{
    _httpClient = httpClient;
    httpClient.httpRequestOperationManager.responseSerializer = self.dataMapper;
}

@end
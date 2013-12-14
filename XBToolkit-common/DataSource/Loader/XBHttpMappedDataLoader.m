//
// Created by akinsella on 31/03/13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <AFNetworking/AFHTTPRequestOperationManager.h>
#import "XBHttpMappedDataLoader.h"

@interface XBHttpMappedDataLoader ()
@property (nonatomic, strong) NSString *resourcePath;
@property (nonatomic, strong) NSString *HTTPMethod;
@property (nonatomic, strong) XBHttpClient *httpClient;
@property (nonatomic, strong) AFHTTPResponseSerializer<AFURLResponseSerialization> *dataMapper;
@property (nonatomic, strong) id <XBHttpQueryParamBuilder> httpQueryParamBuilder;
@end

@implementation XBHttpMappedDataLoader

- (id)initWithHttpClient:(XBHttpClient *)httpClient resourcePath:(NSString *)resourcePath HTTPMethod:(NSString *)HTTPMethod dataMapper:(AFHTTPResponseSerializer <AFURLResponseSerialization> *)dataMapper httpQueryParamBuilder:(id <XBHttpQueryParamBuilder>)httpQueryParamBuilder {
    self = [super init];
    if (self) {
        self.httpClient = httpClient;
        self.HTTPMethod = HTTPMethod;
        self.dataMapper = dataMapper;
        self.httpClient.httpRequestOperationManager.responseSerializer = dataMapper;
        self.httpQueryParamBuilder = httpQueryParamBuilder;
        self.resourcePath = resourcePath;
    }

    return self;
}

+ (instancetype)dataLoaderWithHttpClient:(XBHttpClient *)httpClient resourcePath:(NSString *)resourcePath HTTPMethod:(NSString *)HTTPMethod dataMapper:(AFHTTPResponseSerializer <AFURLResponseSerialization> *)dataMapper httpQueryParamBuilder:(id <XBHttpQueryParamBuilder>)httpQueryParamBuilder
{
    return [[self alloc] initWithHttpClient:httpClient resourcePath:resourcePath HTTPMethod:HTTPMethod dataMapper:dataMapper httpQueryParamBuilder:httpQueryParamBuilder];
}

+ (instancetype)dataLoaderWithHttpClient:(XBHttpClient *)httpClient resourcePath:(NSString *)resourcePath dataMapper:(AFHTTPResponseSerializer <AFURLResponseSerialization> *)dataMapper
{
    return [self dataLoaderWithHttpClient:httpClient resourcePath:resourcePath dataMapper:dataMapper httpQueryParamBuilder:nil];
}

+ (instancetype)dataLoaderWithHttpClient:(XBHttpClient *)httpClient resourcePath:(NSString *)resourcePath dataMapper:(AFHTTPResponseSerializer <AFURLResponseSerialization> *)dataMapper httpQueryParamBuilder:(id <XBHttpQueryParamBuilder>)httpQueryParamBuilder
{
    return [[self alloc] initWithHttpClient:httpClient resourcePath:resourcePath HTTPMethod:nil dataMapper:dataMapper httpQueryParamBuilder:httpQueryParamBuilder];
}

- (void)loadDataWithHTTPMethod:(NSString *)httpMethod withSuccess:(XBDataLoaderSuccessBlock)success failure:(XBDataLoaderFailureBlock)failure
{
    NSDictionary *parameters = self.httpQueryParamBuilder ? [self.httpQueryParamBuilder build] : nil;

    [self.httpClient executeRequestWithPath:self.resourcePath method:httpMethod parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
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
    NSString *method = self.HTTPMethod ? self.HTTPMethod : @"GET";
    [self loadDataWithHTTPMethod:method withSuccess:success failure:failure];
}

- (void)setDataMapper:(AFHTTPResponseSerializer<AFURLResponseSerialization> *)dataMapper
{
    _dataMapper = dataMapper;
    self.httpClient.httpRequestOperationManager.responseSerializer = dataMapper;
}

- (void)setHttpClient:(XBHttpClient *)httpClient
{
    _httpClient = httpClient;
    
    if (self.dataMapper) {
        httpClient.httpRequestOperationManager.responseSerializer = self.dataMapper;
    }
}

@end
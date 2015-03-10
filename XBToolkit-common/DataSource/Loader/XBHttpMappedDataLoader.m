//
// Created by akinsella on 31/03/13.
//


#import <AFNetworking/AFHTTPRequestOperationManager.h>
#import "XBHttpMappedDataLoader.h"


@interface XBHttpMappedDataLoader ()
@property (nonatomic, strong) NSString *resourcePath;
@property (nonatomic, strong) NSString *httpMethod;
@property (nonatomic, strong) XBHttpClient *httpClient;
@property (nonatomic, strong) AFHTTPResponseSerializer<AFURLResponseSerialization> *dataMapper;
@property (nonatomic, strong) id <XBHttpRequestDataBuilder> requestDataBuilder;
@end


@implementation XBHttpMappedDataLoader

- (instancetype)initWithHttpClient:(XBHttpClient *)httpClient resourcePath:(NSString *)resourcePath httpMethod:(NSString *)httpMethod dataMapper:(AFHTTPResponseSerializer <AFURLResponseSerialization> *)dataMapper requestDataBuilder:(id <XBHttpRequestDataBuilder>)requestDataBuilder
{
    self = [super init];
    if (self) {
        self.httpClient = httpClient;
        self.httpMethod = httpMethod;
        self.dataMapper = dataMapper;
        self.requestDataBuilder = requestDataBuilder;
        self.resourcePath = resourcePath;
    }

    return self;
}

+ (instancetype)dataLoaderWithHttpClient:(XBHttpClient *)httpClient resourcePath:(NSString *)resourcePath httpMethod:(NSString *)httpMethod dataMapper:(AFHTTPResponseSerializer <AFURLResponseSerialization> *)dataMapper httpQueryParamBuilder:(id <XBHttpRequestDataBuilder>)httpQueryParamBuilder
{
    return [[self alloc] initWithHttpClient:httpClient resourcePath:resourcePath httpMethod:httpMethod dataMapper:dataMapper requestDataBuilder:httpQueryParamBuilder];
}

+ (instancetype)dataLoaderWithHttpClient:(XBHttpClient *)httpClient resourcePath:(NSString *)resourcePath dataMapper:(AFHTTPResponseSerializer <AFURLResponseSerialization> *)dataMapper
{
    return [self dataLoaderWithHttpClient:httpClient resourcePath:resourcePath dataMapper:dataMapper httpQueryParamBuilder:nil];
}

+ (instancetype)dataLoaderWithHttpClient:(XBHttpClient *)httpClient resourcePath:(NSString *)resourcePath dataMapper:(AFHTTPResponseSerializer <AFURLResponseSerialization> *)dataMapper httpQueryParamBuilder:(id <XBHttpRequestDataBuilder>)httpQueryParamBuilder
{
    return [[self alloc] initWithHttpClient:httpClient resourcePath:resourcePath httpMethod:nil dataMapper:dataMapper requestDataBuilder:httpQueryParamBuilder];
}

- (void)loadDataWithHttpMethod:(NSString *)httpMethod withSuccess:(XBDataLoaderSuccessBlock)success failure:(XBDataLoaderFailureBlock)failure
{
    id parameters = self.requestDataBuilder ? [self.requestDataBuilder build] : nil;

    [self.httpClient executeRequestWithPath:self.resourcePath method:httpMethod parameters:parameters responseSerializer:self.dataMapper success:^(AFHTTPRequestOperation *operation, id responseObject) {
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
    [self loadDataWithSuccess:success failure:failure queue:dispatch_get_main_queue()];
}

- (void)loadDataWithSuccess:(XBDataLoaderSuccessBlock)success failure:(XBDataLoaderFailureBlock)failure queue:(dispatch_queue_t)queue
{
    NSString *method = self.httpMethod ? self.httpMethod : @"GET";
    [self loadDataWithHttpMethod:method withSuccess:success failure:failure];
}


@end
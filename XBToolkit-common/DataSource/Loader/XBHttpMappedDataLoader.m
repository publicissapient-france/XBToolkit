//
// Created by akinsella on 31/03/13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <AFNetworking/AFHTTPRequestOperationManager.h>
#import "XBHttpMappedDataLoader.h"
#import "XBHTTPMappedRequestDataBuilder.h"

@interface XBHttpMappedDataLoader ()
@property (nonatomic, strong) NSString *resourcePath;
@property (nonatomic, strong) NSString *HTTPMethod;
@property (nonatomic, strong) XBHTTPClient *HTTPClient;
@property (nonatomic, strong) AFHTTPResponseSerializer<AFURLResponseSerialization> *dataMapper;
@property (nonatomic, strong) id <XBHTTPRequestDataBuilder> requestDataBuilder;
@end

@implementation XBHttpMappedDataLoader

- (id)initWithHTTPClient:(XBHTTPClient *)HTTPClient resourcePath:(NSString *)resourcePath HTTPMethod:(NSString *)HTTPMethod dataMapper:(AFHTTPResponseSerializer <AFURLResponseSerialization> *)dataMapper requestDataBuilder:(id <XBHTTPRequestDataBuilder>)requestDataBuilder
{
    self = [super init];
    if (self) {
        self.HTTPClient = HTTPClient;
        self.HTTPMethod = HTTPMethod;
        self.dataMapper = dataMapper;
        self.requestDataBuilder = requestDataBuilder;
        self.resourcePath = resourcePath;
    }

    return self;
}

+ (instancetype)dataLoaderWithHTTPClient:(XBHTTPClient *)HTTPClient resourcePath:(NSString *)resourcePath HTTPMethod:(NSString *)HTTPMethod dataMapper:(AFHTTPResponseSerializer <AFURLResponseSerialization> *)dataMapper httpQueryParamBuilder:(id <XBHTTPRequestDataBuilder>)httpQueryParamBuilder
{
    return [[self alloc] initWithHTTPClient:HTTPClient resourcePath:resourcePath HTTPMethod:HTTPMethod dataMapper:dataMapper requestDataBuilder:httpQueryParamBuilder];
}

+ (instancetype)dataLoaderWithHTTPClient:(XBHTTPClient *)HTTPClient resourcePath:(NSString *)resourcePath dataMapper:(AFHTTPResponseSerializer <AFURLResponseSerialization> *)dataMapper
{
    return [self dataLoaderWithHTTPClient:HTTPClient resourcePath:resourcePath dataMapper:dataMapper httpQueryParamBuilder:nil];
}

+ (instancetype)dataLoaderWithHTTPClient:(XBHTTPClient *)HTTPClient resourcePath:(NSString *)resourcePath dataMapper:(AFHTTPResponseSerializer <AFURLResponseSerialization> *)dataMapper httpQueryParamBuilder:(id <XBHTTPRequestDataBuilder>)httpQueryParamBuilder
{
    return [[self alloc] initWithHTTPClient:HTTPClient resourcePath:resourcePath HTTPMethod:nil dataMapper:dataMapper requestDataBuilder:httpQueryParamBuilder];
}

- (void)loadDataWithHTTPMethod:(NSString *)httpMethod withSuccess:(XBDataLoaderSuccessBlock)success failure:(XBDataLoaderFailureBlock)failure
{
    NSDictionary *parameters = self.requestDataBuilder ? [self.requestDataBuilder build] : nil;

    [self.HTTPClient executeRequestWithPath:self.resourcePath method:httpMethod parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
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
    self.HTTPClient.httpRequestOperationManager.responseSerializer = dataMapper;
}

- (void)setRequestDataBuilder:(id <XBHTTPRequestDataBuilder>)requestDataBuilder
{
    _requestDataBuilder = requestDataBuilder;
}

- (void)setHTTPClient:(XBHTTPClient *)HTTPClient
{
    _HTTPClient = HTTPClient;
    
    if (self.dataMapper) {
        HTTPClient.httpRequestOperationManager.responseSerializer = self.dataMapper;
    }
}

@end
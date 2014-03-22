//
// Created by akinsella on 18/03/13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "XBHttpClient.h"
#import "AFNetworking.h"
#import "XBLogging.h"
#import "XBHttpClient+protected.h"

@interface XBHttpClient ()

@property(nonatomic, strong) NSString *baseUrl;

@end

@implementation XBHttpClient

- (instancetype)initWithBaseUrl:(NSString *)baseUrl
{
    self = [super init];

    if (self) {
        self.baseUrl = baseUrl;
        self.cachePolicy = NSURLRequestUseProtocolCachePolicy;

        self.httpRequestOperationManager = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:[NSURL URLWithString:baseUrl]];
    }

    return self;
}

- (instancetype)initWithBaseUrl:(NSString *)baseUrl timeoutInterval:(NSNumber *)timeoutInterval
{
    self = [super init];

    if (self) {
        self.baseUrl = baseUrl;
        self.timeoutInterval = timeoutInterval;
        self.cachePolicy = NSURLRequestUseProtocolCachePolicy;

        self.httpRequestOperationManager = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:[NSURL URLWithString:baseUrl]];
    }

    return self;
}

- (instancetype)initWithBaseUrl:(NSString *)baseUrl timeoutInterval:(NSNumber *)timeoutInterval cachePolicy:(NSURLRequestCachePolicy)cachePolicy
{
    self = [super init];

    if (self) {
        self.baseUrl = baseUrl;
        self.timeoutInterval = timeoutInterval;
        self.cachePolicy = cachePolicy;

        self.httpRequestOperationManager = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:[NSURL URLWithString:baseUrl]];
    }

    return self;
}

+ (instancetype)httpClientWithBaseUrl:(NSString *)baseUrl
{
    return [[self alloc] initWithBaseUrl:baseUrl];
}

+ (instancetype)httpClientWithBaseUrl:(NSString *)baseUrl timeoutInterval:(NSNumber *)timeoutInterval
{
    return [[self alloc] initWithBaseUrl:baseUrl timeoutInterval:timeoutInterval];
}

+ (instancetype)httpClientWithBaseUrl:(NSString *)baseUrl timeoutInterval:(NSNumber *)timeoutInterval cachePolicy:(NSURLRequestCachePolicy)cachePolicy
{
    return [[self alloc] initWithBaseUrl:baseUrl timeoutInterval:timeoutInterval cachePolicy:cachePolicy];
}

- (void)executeRequestWithPath:(NSString *)path
                        method:(NSString *)method
                    parameters:(NSDictionary *)parameters
            responseSerializer:(AFHTTPResponseSerializer <AFURLResponseSerialization> *)responseSerializer
                       success:(XBHttpClientRequestSuccessBlock)successCb
                       failure:(XBHttpClientRequestFailureBlock)errorCb
{

    NSString *urlString = [self URLStringWithUrlPath:path method:method parameters:parameters];
    XBLogDebug(@"Http Request URL: %@", urlString);

    NSMutableURLRequest *request = [self.httpRequestOperationManager.requestSerializer
            requestWithMethod:method
                    URLString:urlString
                   parameters:parameters];

    request.cachePolicy = self.cachePolicy;

    if (self.timeoutInterval) {
        request.timeoutInterval = [self.timeoutInterval floatValue];
    }

    AFHTTPRequestOperation *operation = [self.httpRequestOperationManager HTTPRequestOperationWithRequest:request
                                                                                                  success:^(AFHTTPRequestOperation *httpRequestOperation, id responseObject) {
                                                                                                      XBLogVerbose(@"Response: %@", httpRequestOperation.responseString);

                                                                                                      if (successCb) {
                                                                                                          successCb(httpRequestOperation, responseObject);
                                                                                                      }
                                                                                                  }
                                                                                                  failure:^(AFHTTPRequestOperation *httpRequestOperation, NSError *error) {
                                                                                                      XBLogWarn(@"Error: %@, Response: %@", error, httpRequestOperation.responseString);

                                                                                                      if (errorCb) {
                                                                                                          errorCb(httpRequestOperation, [httpRequestOperation responseObject], error);
                                                                                                      }
                                                                                                  }
    ];
    operation.responseSerializer = responseSerializer;

    [self.httpRequestOperationManager.operationQueue addOperation:operation];
}

- (NSString *)URLStringWithUrlPath:(NSString *)urlPath method:(NSString *)method parameters:(NSDictionary *)parameters;
{
    return [[NSURL URLWithString:urlPath relativeToURL:self.httpRequestOperationManager.baseURL] absoluteString];
}

@end
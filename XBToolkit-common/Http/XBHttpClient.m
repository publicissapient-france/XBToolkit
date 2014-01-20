//
// Created by akinsella on 18/03/13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "XBHttpClient.h"
#import "AFNetworking.h"
#import "XBLogging.h"

@interface XBHttpClient ()

@property(nonatomic, strong) NSString *baseUrl;

@end

@implementation XBHttpClient

- (instancetype)initWithBaseUrl:(NSString *)baseUrl
{
    self = [super init];

    if (self) {
        self.baseUrl = baseUrl;
        self.HTTPRequestOperationManager = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:[NSURL URLWithString:baseUrl]];;
    }

    return self;
}

+ (instancetype)httpClientWithBaseUrl:(NSString *)baseUrl
{
    return [[self alloc] initWithBaseUrl:baseUrl];
}

- (void)executeRequestWithPath:(NSString *)path
                        method:(NSString *)method
                    parameters:(NSDictionary *)parameters
            responseSerializer:(AFHTTPResponseSerializer <AFURLResponseSerialization> *)responseSerializer
                       success:(XBHTTPClientRequestSuccessBlock)successCb
                       failure:(XBHTTPClientRequestFailureBlock)errorCb
{

    NSString *urlString = [self URLWithPath:path method:method parameters:parameters ];
    XBLogDebug(@"Http Request URL: %@", urlString);

    NSMutableURLRequest *request = [self.HTTPRequestOperationManager.requestSerializer
            requestWithMethod:method
                    URLString:urlString
                   parameters:parameters];

    AFHTTPRequestOperation *operation = [self.HTTPRequestOperationManager HTTPRequestOperationWithRequest:request
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

    [self.HTTPRequestOperationManager.operationQueue addOperation:operation];
}

- (NSString *)URLWithPath:(NSString *)path method:(NSString *)method parameters:(NSDictionary *)parameters
{
    return [[NSURL URLWithString:path relativeToURL:self.HTTPRequestOperationManager.baseURL] absoluteString];
}

@end
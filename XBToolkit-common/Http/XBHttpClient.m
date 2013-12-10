//
// Created by akinsella on 18/03/13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "XBHttpClient.h"
#import "AFNetworking.h"
#import "XBLogging.h"
#import "AFHTTPRequestOperation.h"
#import <AFNetworking/AFHTTPRequestOperationManager.h>

@interface XBHttpClient () 

@property(nonatomic, strong) NSString *baseUrl;

@end

@implementation XBHttpClient

- (id)initWithBaseUrl:(NSString *)baseUrl
{
    self = [super init];

    if (self) {
        self.baseUrl = baseUrl;
        self.httpRequestOperationManager = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:[NSURL URLWithString:baseUrl]];;
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
                       success:(XBHttpClientRequestSuccessBlock)successCb
                       failure:(XBHttpClientRequestFailureBlock)errorCb
{

    NSMutableURLRequest *request = [self.httpRequestOperationManager.requestSerializer
            requestWithMethod:method
                    URLString:[[NSURL URLWithString:path relativeToURL:self.httpRequestOperationManager.baseURL] absoluteString]
                   parameters:parameters];

    AFHTTPRequestOperation *operation = [self.httpRequestOperationManager HTTPRequestOperationWithRequest:request success:^(AFHTTPRequestOperation *httpRequestOperation, id responseObject) {
        XBLogVerbose(@"json: %@", httpRequestOperation.responseString);

        if (successCb) {
            successCb(httpRequestOperation, responseObject);
        }
    } failure:^(AFHTTPRequestOperation *httpRequestOperation, NSError *error) {
        XBLogWarn(@"Error: %@, json: %@", error, httpRequestOperation.responseString);

        if (errorCb) {
            errorCb(httpRequestOperation, [httpRequestOperation responseObject], error);
        }
    }];

    [self.httpRequestOperationManager.operationQueue addOperation:operation];
}

@end
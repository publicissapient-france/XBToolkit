//
// Created by akinsella on 18/03/13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "XBHttpClient.h"
#import "AFNetworking.h"
#import "XBLogging.h"

@interface XBHttpClient () 

@property(nonatomic, strong)NSString *baseUrl;

@end

@implementation XBHttpClient {
    AFHTTPClient *_afHttpClient;
}

+(id)httpClientWithBaseUrl:(NSString *)baseUrl {
    return [[XBHttpClient alloc] initWithBaseUrl:baseUrl];
}

-(id)initWithBaseUrl:(NSString *)baseUrl {
    self = [super init];

    if (self) {
        self.baseUrl = baseUrl;
        _afHttpClient = [AFHTTPClient clientWithBaseURL:[NSURL URLWithString:baseUrl]];
    }

    return self;
}

- (AFHTTPClient *)afHttpClient
{
    return _afHttpClient;
}

- (void)executeJsonRequestWithPath:(NSString *)path
                        httpMethod:(NSString *)method
                        parameters:(NSDictionary *)parameters
                           success:(void (^)(NSURLRequest *, NSHTTPURLResponse *, id))successCb
                           failure:(void (^)(NSURLRequest *, NSHTTPURLResponse *, NSError *, id))errorCb
{
    NSURLRequest *urlRequest = [_afHttpClient requestWithMethod:method path:path parameters:parameters];
    
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:urlRequest
        success:^(NSURLRequest *request, NSHTTPURLResponse *response, id json) {
            XBLogVerbose(@"json: %@", json);
                                                                                            
            if (successCb) {
                successCb(request, response, json);
            }
        }
        failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id json) {
            XBLogWarn(@"Error: %@, json: %@", error, json);
            
            if (errorCb) {
                errorCb(request, response, error, json);
            }
        }
    ];
    
    [operation start];
}

- (void)executeGetJsonRequestWithPath:(NSString *)path
                           parameters:(NSDictionary *)parameters
                              success:(void (^)(NSURLRequest *, NSHTTPURLResponse *, id))successCb
                              failure:(void (^)(NSURLRequest *, NSHTTPURLResponse *, NSError *, id))errorCb
{
    [self executeJsonRequestWithPath:path
                          httpMethod:@"GET"
                          parameters:parameters
                             success:successCb
                             failure:errorCb];

}

@end
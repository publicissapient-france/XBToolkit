//
// Created by akinsella on 18/03/13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>

@class AFHTTPRequestOperation;
@class AFHTTPRequestOperationManager;
@class AFHTTPResponseSerializer;
@protocol AFURLResponseSerialization;

typedef void (^XBHttpClientRequestSuccessBlock)(AFHTTPRequestOperation *operation, id responseObject);
typedef void (^XBHttpClientRequestFailureBlock)(AFHTTPRequestOperation *operation, id responseObject, NSError *error);

@interface XBHttpClient : NSObject

@property (nonatomic, strong, readonly) NSString *baseUrl;

@property (nonatomic, strong) AFHTTPRequestOperationManager *httpRequestOperationManager;

@property (nonatomic, assign) NSNumber * timeoutInterval;
@property (nonatomic, assign) NSURLRequestCachePolicy cachePolicy;

- (instancetype)initWithBaseUrl:(NSString *)baseUrl;

- (instancetype)initWithBaseUrl:(NSString *)baseUrl timeoutInterval:(NSNumber *)timeoutInterval;

- (instancetype)initWithBaseUrl:(NSString *)baseUrl timeoutInterval:(NSNumber *)timeoutInterval cachePolicy:(NSURLRequestCachePolicy)cachePolicy;

+ (instancetype)httpClientWithBaseUrl:(NSString *)baseUrl;

+ (instancetype)httpClientWithBaseUrl:(NSString *)baseUrl timeoutInterval:(NSNumber *)timeoutInterval;

+ (instancetype)httpClientWithBaseUrl:(NSString *)baseUrl timeoutInterval:(NSNumber *)timeoutInterval cachePolicy:(NSURLRequestCachePolicy)cachePolicy;

- (void)executeRequestWithPath:(NSString *)path method:(NSString *)method parameters:(NSDictionary *)parameters responseSerializer:(AFHTTPResponseSerializer <AFURLResponseSerialization> *)responseSerializer success:(XBHttpClientRequestSuccessBlock)successCb failure:(XBHttpClientRequestFailureBlock)errorCb;

@end
//
// Created by akinsella on 18/03/13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>

@class AFHTTPRequestOperation;

typedef void (^XBHttpClientRequestSuccessBlock)(AFHTTPRequestOperation *operation, id responseObject);
typedef void (^XBHttpClientRequestFailureBlock)(AFHTTPRequestOperation *operation, id responseObject, NSError *error);

@class AFHTTPRequestOperationManager;
@class AFHTTPResponseSerializer;
@protocol AFURLResponseSerialization;

@interface XBHttpClient : NSObject

@property (nonatomic, strong, readonly) NSString *baseUrl;

@property (nonatomic, strong) AFHTTPRequestOperationManager *httpRequestOperationManager;

@property (nonatomic, assign) NSNumber *timeout;

- (instancetype)initWithBaseUrl:(NSString *)baseUrl;

+ (instancetype)httpClientWithBaseUrl:(NSString *)baseUrl;

- (void)executeRequestWithPath:(NSString *)path method:(NSString *)method parameters:(NSDictionary *)parameters responseSerializer:(AFHTTPResponseSerializer <AFURLResponseSerialization> *)responseSerializer success:(XBHttpClientRequestSuccessBlock)successCb failure:(XBHttpClientRequestFailureBlock)errorCb;

@end
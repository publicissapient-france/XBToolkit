//
// Created by akinsella on 18/03/13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>

@class AFHTTPRequestOperation;

typedef void (^XBHTTPClientRequestSuccessBlock)(AFHTTPRequestOperation *operation, id responseObject);
typedef void (^XBHTTPClientRequestFailureBlock)(AFHTTPRequestOperation *operation, id responseObject, NSError *error);

@class AFHTTPRequestOperationManager;
@class AFHTTPResponseSerializer;
@protocol AFURLResponseSerialization;

@interface XBHTTPClient : NSObject

@property (nonatomic, strong, readonly) NSString *baseUrl;

@property (nonatomic, strong) AFHTTPRequestOperationManager *HTTPRequestOperationManager;

- (instancetype)initWithBaseUrl:(NSString *)baseUrl;

+ (instancetype)HTTPClientWithBaseUrl:(NSString *)baseUrl;

- (void)executeRequestWithPath:(NSString *)path method:(NSString *)method parameters:(NSDictionary *)parameters responseSerializer:(AFHTTPResponseSerializer <AFURLResponseSerialization> *)responseSerializer success:(XBHTTPClientRequestSuccessBlock)successCb failure:(XBHTTPClientRequestFailureBlock)errorCb;

@end
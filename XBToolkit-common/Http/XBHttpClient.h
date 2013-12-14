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

@interface XBHTTPClient : NSObject

@property(nonatomic, strong, readonly)NSString *baseUrl;
#warning Extend with JSONResponseSerializer object

@property(nonatomic, strong) AFHTTPRequestOperationManager *httpRequestOperationManager;

- (id)initWithBaseUrl:(NSString *)baseUrl;

+ (instancetype)httpClientWithBaseUrl:(NSString *)baseUrl;

- (void)executeRequestWithPath:(NSString *)path method:(NSString *)method parameters:(NSDictionary *)parameters success:(XBHttpClientRequestSuccessBlock)successCb failure:(XBHttpClientRequestFailureBlock)errorCb;

@end
//
// Created by akinsella on 18/03/13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>


@interface XBHttpClient : NSObject

@property(nonatomic, strong, readonly)NSString *baseUrl;

+(id)httpClientWithBaseUrl:(NSString *)baseUrl;
-(id)initWithBaseUrl:(NSString *)baseUrl;

- (void)executeGetJsonRequestWithPath:(NSString *)path
                           parameters:(NSDictionary *)parameters
                              success:(void (^)(NSURLRequest *request, NSHTTPURLResponse *response, id jsonFetched))successCb
                              failure: (void (^)(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id jsonFetched))errorCb;

@end
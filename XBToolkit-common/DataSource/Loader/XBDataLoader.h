//
// Created by akinsella on 31/03/13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>

@class AFHTTPRequestOperation;

typedef void (^XBDataLoaderSuccessBlock)(id operation, id responseObject);
typedef void (^XBDataLoaderFailureBlock)(id operation, id responseObject, NSError *error);

@protocol XBDataMapper;

@protocol XBDataLoader <NSObject>

- (void)loadDataWithSuccess:(XBDataLoaderSuccessBlock)success failure:(XBDataLoaderFailureBlock)failure;

@optional
- (void)loadDataWithHttpMethod:(NSString *)httpMethod withSuccess:(XBDataLoaderSuccessBlock)success failure:(XBDataLoaderFailureBlock)failure;

- (id <XBDataMapper>)dataMapper;

@end
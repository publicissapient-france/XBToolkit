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

@required
- (void)loadDataWithSuccess:(XBDataLoaderSuccessBlock)success failure:(XBDataLoaderFailureBlock)failure;
- (void)loadDataWithSuccess:(XBDataLoaderSuccessBlock)success failure:(XBDataLoaderFailureBlock)failure queue:(dispatch_queue_t)queue;

@optional
- (id <XBDataMapper>)dataMapper;

@end
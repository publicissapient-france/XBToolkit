//
// Created by akinsella on 31/03/13.
//


#import <Foundation/Foundation.h>

@class AFHTTPRequestOperation;

typedef void (^XBDataLoaderSuccessBlock)(id operation, id responseObject);
typedef void (^XBDataLoaderFailureBlock)(id operation, id responseObject, NSError *error);

@protocol XBDataMapper;

/**
 *  The data loader used by either an XBArrayDataSource or an XBObjectDataSource must conform to the XBDataLoader protocol.
 */
@protocol XBDataLoader <NSObject>

@required

/**
 *  Loads the data from a source.
 *
 *  @param success The callback invoked when the loading operation is completed successfully.
 *  @param failure The callback invoked when the loading operation produced an error.
 */
- (void)loadDataWithSuccess:(XBDataLoaderSuccessBlock)success failure:(XBDataLoaderFailureBlock)failure;

/**
 *  Loads the data from a source using a specific queue.
 *
 *  @param success The callback invoked when the loading operation is completed successfully.
 *  @param failure The callback invoked when the loading operation is completed successfully.
 *  @param queue   The dispatch_queue the operation will be performed in.
 */
- (void)loadDataWithSuccess:(XBDataLoaderSuccessBlock)success failure:(XBDataLoaderFailureBlock)failure queue:(dispatch_queue_t)queue;

@optional

/**
 *  References the dataMapper used by the dataLoader, if existing.
 *
 *  @return The dataMapper used by the dataLoader, if any.
 */
- (id <XBDataMapper>)dataMapper;

@end
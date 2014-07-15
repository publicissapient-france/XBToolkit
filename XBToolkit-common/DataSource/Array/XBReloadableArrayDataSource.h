//
// Created by akinsella on 29/03/13.
//


#import <Foundation/Foundation.h>
#import "XBArrayDataSource.h"
#import "XBDataMapper.h"
#import "XBDataLoader.h"

typedef void (^XBReloadableArrayDataSourceCompletionBlock)(id operation);

/**
 *   Provide the capability of reloading the elements contained in a dataSource.
 *   This make sense for the data sources that are created from a dataLoader and a dataMapper.
 */
@interface XBReloadableArrayDataSource : XBArrayDataSource

@property (nonatomic, strong, readonly) NSError *error;

@property (nonatomic, strong, readonly) id <XBDataLoader> dataLoader;

@property (nonatomic, strong) BOOL(^filterOnLoad)(id value);

- (instancetype)initWithDataLoader:(id <XBDataLoader>)dataLoader;

+ (instancetype)dataSourceWithDataLoader:(id <XBDataLoader>)dataLoader;

- (void)loadData:(XBReloadableArrayDataSourceCompletionBlock)completion;

- (void)loadData:(XBReloadableArrayDataSourceCompletionBlock)completion queue:(dispatch_queue_t)queue;

- (void)processSuccessForResponseObject:(id)responseObject completion:(void (^)())completion queue:(dispatch_queue_t)queue;

@end
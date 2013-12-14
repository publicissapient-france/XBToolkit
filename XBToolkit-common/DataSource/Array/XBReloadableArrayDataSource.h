//
// Created by akinsella on 29/03/13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>
#import "XBArrayDataSource.h"
#import "XBDataMapper.h"
#import "XBDataLoader.h"

typedef void (^XBReloadableArrayDataSourceCompletionBlock)(id operation);

@interface XBReloadableArrayDataSource : XBArrayDataSource

@property (nonatomic, strong, readonly) NSError *error;
@property (nonatomic, strong, readonly) id <XBDataLoader> dataLoader;

- (id)initWithDataLoader:(id <XBDataLoader>)dataLoader;

+ (instancetype)dataSourceWithDataLoader:(id <XBDataLoader>)dataLoader;

- (void)loadData:(XBReloadableArrayDataSourceCompletionBlock)completion;

@end
//
// Created by akinsella on 29/03/13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>
#import "XBArrayDataSource.h"
#import "XBDataLoader.h"
#import "XBDataMapper.h"

@interface XBReloadableArrayDataSource : XBArrayDataSource

@property (nonatomic, strong, readonly)NSError *error;
@property (nonatomic, strong, readonly)id rawData;
@property (nonatomic, strong, readonly)id<XBDataLoader> dataLoader;

- (id)initWithDataLoader:(id<XBDataLoader>)dataLoader;

+ (instancetype)dataSourceWithDataLoader:(id <XBDataLoader>)dataLoader;

- (void)loadData;

- (void)loadDataWithCallback:(void (^)())callback;

@end
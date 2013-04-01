//
// Created by akinsella on 01/04/13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>
#import "XBDataLoader.h"
#import "XBCache.h"
#import "XBCacheKeyBuilder.h"

@interface XBCacheableDataLoader : NSObject<XBDataLoader>

+ (id)dataLoaderWithDataLoader:(NSObject <XBDataLoader> *)dataLoader cache:(XBCache *)cache cacheKeyBuilder:(NSObject <XBCacheKeyBuilder> *)cacheKeyBuilder ttl:(NSTimeInterval)ttl;

- (id)initWithDataLoader:(NSObject <XBDataLoader> *)dataLoader cache:(XBCache *)cache cacheKeyBuilder:(NSObject<XBCacheKeyBuilder> *)cacheKeyBuilder ttl:(NSTimeInterval)ttl;

@end
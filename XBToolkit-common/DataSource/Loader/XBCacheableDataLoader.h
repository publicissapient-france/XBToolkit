//
// Created by akinsella on 01/04/13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>
#import "XBDataLoader.h"

@class XBCache;
@protocol XBCacheKeyBuilder;

@interface XBCacheableDataLoader : NSObject<XBDataLoader>

- (id)initWithDataLoader:(id <XBDataLoader>)dataLoader cache:(XBCache *)cache cacheKeyBuilder:(id <XBCacheKeyBuilder>)cacheKeyBuilder ttl:(NSTimeInterval)ttl;

+ (instancetype)dataLoaderWithDataLoader:(id <XBDataLoader>)dataLoader cache:(XBCache *)cache cacheKeyBuilder:(id <XBCacheKeyBuilder>)cacheKeyBuilder ttl:(NSTimeInterval)ttl;

@end
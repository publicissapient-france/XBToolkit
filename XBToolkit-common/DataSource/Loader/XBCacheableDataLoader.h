//
// Created by akinsella on 01/04/13.
//


#import <Foundation/Foundation.h>
#import "XBDataLoader.h"

@class XBCache;
@protocol XBCacheKeyBuilder;

@interface XBCacheableDataLoader : NSObject<XBDataLoader>

- (instancetype)initWithDataLoader:(id <XBDataLoader>)dataLoader cache:(XBCache *)cache cacheKeyBuilder:(id <XBCacheKeyBuilder>)cacheKeyBuilder expirationTime:(NSTimeInterval)expiration;

+ (instancetype)dataLoaderWithDataLoader:(id <XBDataLoader>)dataLoader cache:(XBCache *)cache cacheKeyBuilder:(id <XBCacheKeyBuilder>)cacheKeyBuilder expirationTime:(NSTimeInterval)expiration;

@end
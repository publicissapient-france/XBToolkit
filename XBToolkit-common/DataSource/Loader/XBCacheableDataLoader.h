//
// Created by akinsella on 01/04/13.
//


#import <Foundation/Foundation.h>
#import "XBDataLoader.h"

@class XBCache;
@protocol XBCacheKeyBuilder;

/**
 *  XBCacheableDataLoader provides an object conforming to the XBDataLoader capable of retrieving data from a cache.
 *  XBCacheableDataLoader retrieves data from another dataLoader object and store such information inside a user-defined cache.
 */
@interface XBCacheableDataLoader : NSObject<XBDataLoader>

/**
 *  Initializes and returns a newly allocated XBCacheableDataLoader object with the given parameters.
 *
 *  @param dataLoader      An object conforming to the dataLoader protocol responsible for retrieving data from a source.
 *  @param cache           The cache storing the retrieved data.
 *  @param cacheKeyBuilder <#cacheKeyBuilder description#>
 *  @param expiration      <#expiration description#>
 *
 *  @return A newly allocated XBCacheableDataLoader object.
 */
- (instancetype)initWithDataLoader:(id <XBDataLoader>)dataLoader cache:(XBCache *)cache cacheKeyBuilder:(id <XBCacheKeyBuilder>)cacheKeyBuilder expirationTime:(NSTimeInterval)expiration;

+ (instancetype)dataLoaderWithDataLoader:(id <XBDataLoader>)dataLoader cache:(XBCache *)cache cacheKeyBuilder:(id <XBCacheKeyBuilder>)cacheKeyBuilder expirationTime:(NSTimeInterval)expiration;

@end
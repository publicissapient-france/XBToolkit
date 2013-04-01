//
// Created by akinsella on 01/04/13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>
#import "XBDataLoader.h"
#import "XBCache.h"

@interface XBCacheableDataLoader : NSObject<XBDataLoader>
- (id)initWithDataLoader:(NSObject <XBDataLoader> *)dataLoader cache:(XBCache *)cache cacheKey:(NSString *)cacheKey ttl:(NSTimeInterval)ttl;

+ (id)loaderWithDataLoader:(NSObject <XBDataLoader> *)dataLoader cache:(XBCache *)cache cacheKey:(NSString *)cacheKey ttl:(NSTimeInterval)ttl;


@end
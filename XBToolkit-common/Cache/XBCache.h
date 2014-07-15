//
// Created by akinsella on 31/03/13.
//


#import <Foundation/Foundation.h>
#import "XBCacheElement.h"
#import "XBCacheSupport.h"

/**
 *  XBCache allows storing/retrieving cache elements to/from the cache of type specified in XBCacheSupport. 
 */
@interface XBCache : NSObject<XBCacheSupport>

- (instancetype)initWithCacheSupport:(id <XBCacheSupport>)cacheSupport;

+ (instancetype)cacheWithCacheSupport:(id <XBCacheSupport>)cacheSupport;

- (void)setForKey:(NSString *)key value:(NSString *)value error:(NSError**)error;

@end


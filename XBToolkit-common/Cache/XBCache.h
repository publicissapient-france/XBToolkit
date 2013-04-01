//
// Created by akinsella on 31/03/13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>
#import "XBCacheElement.h"
#import "XBCacheSupport.h"

@interface XBCache : NSObject<XBCacheSupport>
- (id)initWithCacheSupport:(NSObject <XBCacheSupport> *)cacheSupport;

+ (id)cacheWithCacheSupport:(NSObject <XBCacheSupport> *)cacheSupport;

-(void)setForKey:(NSString *)key value:(NSString *)value error:(NSError**)error;
-(void)setForKey:(NSString *)key value:(NSString *)value ttl:(NSTimeInterval)ttl error:(NSError**)error;
-(id)getForKey:(NSString *)key error:(NSError**)error;
- (void)clearForKey:(NSString *)key error:(NSError**)error;
- (void)clearAllWithError:(NSError **)error;

@end

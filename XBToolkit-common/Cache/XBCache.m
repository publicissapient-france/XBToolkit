//
// Created by akinsella on 31/03/13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "XBCache.h"

@interface XBCache()
@property(nonatomic, strong) NSObject<XBCacheSupport> *cacheSupport;
@end

@implementation XBCache

+ (id)cacheWithCacheSupport:(NSObject <XBCacheSupport> *)cacheSupport {
    return [[self alloc] initWithCacheSupport:cacheSupport];
}

- (id)initWithCacheSupport:(NSObject <XBCacheSupport> *)cacheSupport {
    self = [super init];
    if (self) {
        self.cacheSupport = cacheSupport;
    }

    return self;
}

- (void)setForKey:(NSString *)key value:(NSString *)value error:(NSError **)error {
    [self.cacheSupport setForKey:key value:value ttl:0 error:error];
}

- (void)setForKey:(NSString *)key value:(NSString *)value ttl:(NSTimeInterval)ttl error:(NSError **)error {
    [self.cacheSupport setForKey:key value:value ttl:ttl error:error];
}

- (NSString *)getForKey:(NSString *)key error:(NSError **)error {
    return [self.cacheSupport getForKey:key error:error];
}

- (void)clearForKey:(NSString *)key error:(NSError **)error {
    [self.cacheSupport clearForKey:key error:error];
}

- (void)clearAllWithError:(NSError **)error {
    [self.cacheSupport clearAllWithError:error];
}

@end
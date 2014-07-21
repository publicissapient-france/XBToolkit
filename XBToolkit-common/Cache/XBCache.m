//
// Created by akinsella on 31/03/13.
//


#import "XBCache.h"


@interface XBCache()

@property (nonatomic, strong) id <XBCacheSupport> cacheSupport;

@end


@implementation XBCache

+ (instancetype)cacheWithCacheSupport:(id <XBCacheSupport>)cacheSupport
{
    return [[self alloc] initWithCacheSupport:cacheSupport];
}

- (instancetype)initWithCacheSupport:(id <XBCacheSupport>)cacheSupport
{
    self = [super init];
    if (self) {
        self.cacheSupport = cacheSupport;
    }

    return self;
}

- (void)setForKey:(NSString *)key value:(id <NSCoding>)value error:(NSError **)error
{
    [self.cacheSupport setForKey:key value:value expirationTime:0 error:error];
}

- (void)setForKey:(NSString *)key value:(id <NSCoding>)value expirationTime:(NSTimeInterval)expiration error:(NSError **)error
{
    [self.cacheSupport setForKey:key value:value expirationTime:expiration error:error];
}

- (id)getForKey:(NSString *)key error:(NSError **)error forceIfExpired:(BOOL)force
{
    return [self.cacheSupport getForKey:key error:error forceIfExpired:force];
}

- (void)clearForKey:(NSString *)key error:(NSError **)error
{
    [self.cacheSupport clearForKey:key error:error];
}

- (void)clearAllWithError:(NSError **)error
{
    [self.cacheSupport clearAllWithError:error];
}

@end
//
// Created by akinsella on 01/04/13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "XBCacheableDataLoader.h"
#import "XBCache.h"
#import "XBCacheKeyBuilder.h"
#import "XBHttpDataLoader.h"
#import <AFNetworking/AFNetworkReachabilityManager.h>

@interface XBCacheableDataLoader()

@property(nonatomic, strong) id <XBDataLoader> dataLoader;
@property(nonatomic, strong) XBCache *cache;
@property(nonatomic, strong) id <XBCacheKeyBuilder> cacheKeyBuilder;
@property(nonatomic, assign) NSTimeInterval ttl;

@end

@implementation XBCacheableDataLoader

- (id)initWithDataLoader:(id <XBDataLoader>)dataLoader cache:(XBCache *)cache cacheKeyBuilder:(id <XBCacheKeyBuilder>)cacheKeyBuilder ttl:(NSTimeInterval)ttl
{
    self = [super init];
    if (self) {
        self.dataLoader = dataLoader;
        self.cache = cache;
        self.cacheKeyBuilder = cacheKeyBuilder;
        self.ttl = ttl;
    }

    return self;
}

+ (instancetype)dataLoaderWithDataLoader:(id <XBDataLoader>)dataLoader cache:(XBCache *)cache cacheKeyBuilder:(id <XBCacheKeyBuilder>)cacheKeyBuilder ttl:(NSTimeInterval)ttl
{
    return [[self alloc] initWithDataLoader:dataLoader cache:cache cacheKeyBuilder:cacheKeyBuilder ttl:ttl];
}

- (NSString *)cacheKey
{
    return [self.cacheKeyBuilder buildWithData:self.dataLoader];
}

- (void)loadDataWithSuccess:(XBDataLoaderSuccessBlock)success failure:(XBDataLoaderFailureBlock)failure
{
    BOOL canLoadFromNetwork = NO;
    if ([self.dataLoader conformsToProtocol:@protocol(XBHttpDataLoader)]) {
        canLoadFromNetwork = [[AFNetworkReachabilityManager sharedManager] networkReachabilityStatus] != AFNetworkReachabilityStatusNotReachable;
    }

    NSDictionary *cachedData = [self fetchDataFromCacheWithError:nil forceIfExpired:NO];
    if (!cachedData && canLoadFromNetwork) {
        [self.dataLoader loadDataWithSuccess:^(id operation, id loadedData) {
            NSError *error = nil;
            [self.cache setForKey:[self cacheKey] value:loadedData ttl:self.ttl error:&error];
            success(operation, loadedData);

        } failure:^(id operation, id responseObject, NSError *error) {
            [self forceLoadDataFromCacheWithSuccess:success failure:failure httpError:error];
            failure(operation, responseObject, error);
        }];
    } else {
        if (cachedData) {
            #warning replace nil with sth more meaningful
            success(nil, cachedData);
            return;
        }
        [self forceLoadDataFromCacheWithSuccess:success failure:failure httpError:nil];
    }
}

- (void)forceLoadDataFromCacheWithSuccess:(XBDataLoaderSuccessBlock)success failure:(XBDataLoaderFailureBlock)failure httpError:(NSError *)httpError
{
    NSError *error;
    NSDictionary *cachedData = [self fetchDataFromCacheWithError:&error forceIfExpired:YES];
    if (cachedData) {
#warning replace nil with sth more meaningful
        success(nil, cachedData);
    } else {
#warning replace nil with sth more meaningful
        failure(nil, cachedData, httpError ? httpError : error);
    }
}

- (NSDictionary *)fetchDataFromCacheWithError:(NSError **)error forceIfExpired:(BOOL)force
{
    if (self.cache) {
        @try {
            return [self.cache getForKey:self.cacheKey error:error forceIfExpired:force];
        }
        @catch ( NSException *e ) {
            XBLogError( @"%@: %@", e.name, e.reason);
            [self.cache clearForKey:self.cacheKey error:nil];
        }
    }
    return nil;
}

@end
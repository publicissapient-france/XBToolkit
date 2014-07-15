//
// Created by akinsella on 01/04/13.
//


#import "XBCacheableDataLoader.h"
#import "XBCache.h"
#import "XBCacheKeyBuilder.h"
#import "XBHttpDataLoader.h"
#import <AFNetworking/AFNetworkReachabilityManager.h>
#import "XBLogging.h"


@interface XBCacheableDataLoader()

@property (nonatomic, strong) id <XBDataLoader> dataLoader;
@property (nonatomic, strong) XBCache *cache;
@property (nonatomic, strong) id <XBCacheKeyBuilder> cacheKeyBuilder;
@property (nonatomic, assign) NSTimeInterval expirationTime;

@end


@implementation XBCacheableDataLoader

- (instancetype)initWithDataLoader:(id <XBDataLoader>)dataLoader cache:(XBCache *)cache cacheKeyBuilder:(id <XBCacheKeyBuilder>)cacheKeyBuilder expirationTime:(NSTimeInterval)expiration
{
    self = [super init];
    if (self) {
        self.dataLoader = dataLoader;
        self.cache = cache;
        self.cacheKeyBuilder = cacheKeyBuilder;
        self.expirationTime = expiration;
    }

    return self;
}

+ (instancetype)dataLoaderWithDataLoader:(id <XBDataLoader>)dataLoader cache:(XBCache *)cache cacheKeyBuilder:(id <XBCacheKeyBuilder>)cacheKeyBuilder expirationTime:(NSTimeInterval)expiration
{
    return [[self alloc] initWithDataLoader:dataLoader cache:cache cacheKeyBuilder:cacheKeyBuilder expirationTime:expiration];
}

- (NSString *)cacheKey
{
    return [self.cacheKeyBuilder buildWithData:self.dataLoader];
}

- (void)loadDataWithSuccess:(XBDataLoaderSuccessBlock)success failure:(XBDataLoaderFailureBlock)failure
{
    [self loadDataWithSuccess:success failure:failure queue:dispatch_get_main_queue()];
}

- (void)loadDataWithSuccess:(XBDataLoaderSuccessBlock)success failure:(XBDataLoaderFailureBlock)failure queue:(dispatch_queue_t)queue
{
    BOOL canLoadFromNetwork = NO;
    if ([self.dataLoader conformsToProtocol:@protocol(XBHttpDataLoader)]) {
        canLoadFromNetwork = [[AFNetworkReachabilityManager sharedManager] networkReachabilityStatus] != AFNetworkReachabilityStatusNotReachable;
    }

    NSDictionary *cachedData = [self fetchDataFromCacheWithError:nil forceIfExpired:NO];
    if (!cachedData && canLoadFromNetwork) {
        [self.dataLoader loadDataWithSuccess:^(id operation, id loadedData) {
            NSError *error = nil;
            [self.cache setForKey:[self cacheKey] value:loadedData expirationTime:self.expirationTime error:&error];
            success(operation, loadedData);

        } failure:^(id operation, id responseObject, NSError *error) {
            [self forceLoadDataFromCacheWithSuccess:success failure:failure httpError:error];
            failure(operation, responseObject, error);
        }];
    } else {
        if (cachedData) {
            //TODO: return an operation
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
        //TODO: return an operation
        success(nil, cachedData);
    } else {
        //TODO: return an operation
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
//
// Created by akinsella on 01/04/13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "XBCacheableDataLoader.h"
#import "XBCache.h"
#import "XBCacheKeyBuilder.h"
#import "XBLogging.h"

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
    #warning Should probably be wrapped by NSOperation?
//    NSDictionary *data = [self fetchDataFromCacheWithError:nil];
//
//    if (data) {
//        success(nil, data);
//    }
//    else {
//        [self.dataLoader loadDataWithSuccess:^(NSOperation *operation, id loadedData) {
//            NSError *error = nil;
//            [self.cache setForKey:[self cacheKey] value:loadedData ttl:self.ttl error:&error];
//            success(nil, loadedData);
//        } failure:^(NSOperation *operation, NSError *error) {
//            failure(nil, error);
//        }];
//    }
}

- (NSDictionary *)fetchDataFromCacheWithError:(NSError **)error
{
    if (self.cache) {
        @try {
            return [self.cache getForKey:self.cacheKey error:error];
        }
        @catch ( NSException *e ) {
            XBLogError( @"%@: %@", e.name, e.reason);
            [self.cache clearForKey:self.cacheKey error:nil];
        }
    }
    return nil;
}

@end
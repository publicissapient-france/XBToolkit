//
// Created by akinsella on 01/04/13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "XBCacheableDataLoader.h"
#import "XBCache.h"

@interface XBCacheableDataLoader()

@property (nonatomic, strong)NSObject<XBDataLoader> *dataLoader;
@property (nonatomic, strong)XBCache *cache;
@property (nonatomic, strong)NSString *cacheKey;
@property (nonatomic, assign)NSTimeInterval ttl;

@end

@implementation XBCacheableDataLoader

+ (id)loaderWithDataLoader:(NSObject <XBDataLoader> *)dataLoader cache:(XBCache *)cache cacheKey:(NSString *)cacheKey ttl:(NSTimeInterval)ttl {
    return [[self alloc] initWithDataLoader:dataLoader cache:cache cacheKey:cacheKey ttl:ttl];
}

- (id)initWithDataLoader:(NSObject <XBDataLoader> *)dataLoader cache:(XBCache *)cache cacheKey:(NSString *)cacheKey ttl:(NSTimeInterval)ttl {
    self = [super init];
    if (self) {
        self.dataLoader = dataLoader;
        self.cache = cache;
        self.cacheKey = cacheKey;
        self.ttl = ttl;
    }

    return self;
}

- (void)loadDataWithSuccess:(void(^)(id))success failure:(void(^)(NSError *))failure {

    NSDictionary *data = [self fetchDataFromCacheWithError:nil];

    if (data) {
        success(data);
    }
    else {
        [self.dataLoader loadDataWithSuccess:^(id loadedData) {
            NSError *error = nil;
            [self.cache setForKey:self.cacheKey value:loadedData ttl:60 error:&error];
            success(loadedData);
        } failure:^(NSError *error) {
            failure(error);
        }];
    }
}

- (NSDictionary *)fetchDataFromCacheWithError:(NSError **)error {
    if (self.cache) {
        @try {
            return [self.cache getForKey:self.cacheKey error:error];
        }
        @catch ( NSException *e ) {
            DDLogError( @"%@: %@", e.name, e.reason);
            [self.cache clearForKey:self.cacheKey error:nil];
        }
    }
}

@end
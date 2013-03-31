//
// Created by akinsella on 29/03/13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <JSONKit/JSONKit.h>
#import "XBCacheableArrayDataSource.h"
#import "XBCache.h"
#import "XBArrayDataSource+protected.h"
#import "XBLoadableArrayDataSource+protected.h"
#import "XBMapper.h"

@implementation XBCacheableArrayDataSource {
    NSDictionary *_dataSource;
}

- (void)setCache:(NSObject <XBCache> *)cache {
    _cache = cache;
}

- (void)setDateFormatter:(NSDateFormatter *)dateFormatter {
    _dateFormatter = dateFormatter;
}

-(void)setMaxDataAgeInSecondsBeforeServerFetch:(NSInteger)maxDataAgeInSecondsBeforeServerFetch {
    _maxDataAgeInSecondsBeforeServerFetch = maxDataAgeInSecondsBeforeServerFetch;
}

- (void)setStorageFileName:(NSString *)storageFileName {
    _storageFileName = storageFileName;
}

- (NSString *)storageFileName {
    return _storageFileName;
}

- (NSDate *)lastUpdate {
    return [self.dateFormatter dateFromString:_dataSource[@"lastUpdate"]];
}

- (void)loadData {
    [self loadDataWithForceReload:NO callback: nil];
}

- (void)loadDataWithCallback:(void (^)())callback {
    [self loadDataWithForceReload:NO callback: callback];
}

- (void)loadDataWithForceReload:(BOOL)force {
    [self loadDataWithForceReload:force callback: nil];
}

- (void)loadDataWithForceReload:(BOOL)force callback:(void (^)())callback {
    self.error = nil;

    [self fetchDataFromCache];

    NSTimeInterval repositoryDataAge = [self dataAgeFromFetchInfo];
    BOOL needUpdateFromSource = repositoryDataAge > self.maxDataAgeInSecondsBeforeServerFetch;

    DDLogVerbose(@"Data age: %f seconds", repositoryDataAge);

    if (needUpdateFromSource) {
        DDLogVerbose(@"Data last update from server was %f seconds ago, forcing update from server", repositoryDataAge);
    }

    if (!needUpdateFromSource && !force && (self.array && self.count > 0) ) {
        if (callback) {
            callback();
        }
    }
    else {
        [self fetchDataFromSourceWithCallback:callback];
    }
}

- (NSTimeInterval)dataAgeFromFetchInfo {
    return [self lastUpdate] ? [[self lastUpdate] timeIntervalSinceNow] : DBL_MAX;
}

- (void)fetchDataFromCache {
    if (self.cache) {
        @try {
            NSError *error = nil;
            NSString *cacheData = [self.cache getForKey:[self storageFileName] error: &error];
            if (cacheData) {
                NSDictionary *json = [cacheData objectFromJSONString];
                [self loadArrayFromJson:json];
            }
        }
        @catch ( NSException *e ) {
            DDLogError( @"%@: %@", e.name, e.reason);
            NSError *error = nil;
            [self.cache clearForKey:[self storageFileName] error:&error];
        }
    }
}

- (void)fetchDataFromSourceWithCallback:(void (^)())callback {
    [self fetchDataFromSourceInternalWithCallback:callback];
}

- (void)fetchDataFromSourceInternalWithCallback:(void (^)())callback {
}

-(void)processSuccessWithJson:(id)jsonFetched callback:(void (^)())callback {
    DDLogVerbose(@"jsonFetched: %@", jsonFetched);

    NSDictionary *json = @{
            @"lastUpdate" : [self.dateFormatter stringFromDate:[NSDate date]],
            @"data" : self.rootKeyPath ? [jsonFetched valueForKeyPath:self.rootKeyPath] : jsonFetched
    };

    if (self.cache) {
        NSError *error;
        [self.cache setForKey:[self storageFileName] value:[json JSONString] error:&error];
    }

    [self loadArrayFromJson:json];

    if (callback) {
        callback();
    }
}

-(void)processError:(NSError*)error json:(id)jsonFetched callback:(void (^)())callback {
    DDLogWarn(@"Error: %@, jsonFetched: %@", error, jsonFetched);
    self.error = error;
    if (callback) {
        callback();
    }
}

- (void)loadArrayFromJson:(NSDictionary *)json {
    _dataSource = json;
    NSArray *array = json[@"data"];
    self.array = [XBMapper parseArray:array intoObjectsOfType:self.typeClass];
}

@end
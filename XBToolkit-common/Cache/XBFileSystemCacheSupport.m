//
// Created by akinsella on 26/03/13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "XBFileSystemCacheSupport.h"
#import "XBLogging.h"

#define kXBFileCachePluginDefaultFileName @"XBCache.plist"

@interface XBFileSystemCacheSupport()
@property(nonatomic, strong) NSString *filename;
@end


@implementation XBFileSystemCacheSupport

- (id)initWithFilename:(NSString *)filename {
    self = [super init];
    if (self) {
        self.filename = filename;
    }

    return self;
}

+ (id)cacheSupportWithFilename:(NSString *)filename {
    return [[self alloc] initWithFilename:filename];
}

-(void)setForKey:(NSString *)key value:(NSString *)value ttl:(NSTimeInterval)expiration error:(NSError **)error {
    XBLogInfo(@"Set cache data for key: %@", key);
    XBCacheElement *element = [XBCacheElement elementWithKey:key value:value ttl:expiration];
    NSMutableDictionary *cacheData = [self cacheDataWithError:error];
    [cacheData setObject:element forKey:element.key];
    [self saveCacheData:cacheData];
}

- (id)getForKey:(NSString *)key error:(NSError **)error {
    XBLogInfo(@"Get cache data for key: %@", key);
    NSMutableDictionary *cacheData = [self cacheDataWithError:error];
    XBCacheElement *element = (XBCacheElement *)[cacheData objectForKey:key];
    return element.value;
}

- (void)clearForKey:(NSString *)key error:(NSError **)error {
    XBLogInfo(@"Clear cache data for key: %@", key);
    NSMutableDictionary *cacheData = [self cacheDataWithError:error];
    [cacheData removeObjectForKey:key];
    [self saveCacheData:cacheData];
}

- (void)clearAllWithError:(NSError **)error {
    NSURL *url = [NSURL fileURLWithPath:[self cacheFilePath]];
    [[NSFileManager defaultManager] removeItemAtURL:url error:error];
}

- (NSMutableDictionary *)cacheDataWithError:(NSError **)error {
    NSURL *fileURL = [NSURL fileURLWithPath:[self cacheFilePath]];
    NSData *data = [NSData dataWithContentsOfURL:fileURL options:NSDataReadingMappedIfSafe error:error];

    NSMutableDictionary *cacheDictionary = (NSMutableDictionary *)[NSKeyedUnarchiver unarchiveObjectWithData:data];
    if (!cacheDictionary) {
        cacheDictionary = [NSMutableDictionary dictionary];
    }

    return cacheDictionary;
}

- (BOOL)saveCacheData:(NSMutableDictionary *)cacheData {
    NSURL *fileURL = [NSURL fileURLWithPath:[self cacheFilePath]];
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:cacheData];
    return [data writeToURL:fileURL atomically:YES];
}

- (NSString *)cacheFilePath {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *cacheDir = [paths lastObject];
    return [cacheDir stringByAppendingPathComponent:self.filename];
}

@end
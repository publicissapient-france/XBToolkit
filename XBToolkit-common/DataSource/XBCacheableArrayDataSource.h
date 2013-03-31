//
// Created by akinsella on 29/03/13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>
#import "XBLoadableArrayDataSource.h"

@protocol XBCache;


@interface XBCacheableArrayDataSource : XBLoadableArrayDataSource {
    NSDateFormatter *_dateFormatter;
    NSInteger _maxDataAgeInSecondsBeforeServerFetch;
    NSString *_storageFileName;
    NSObject<XBCache> *_cache;
}

@property (nonatomic, strong, readonly)NSDateFormatter *dateFormatter;
@property (nonatomic, assign, readonly)NSInteger maxDataAgeInSecondsBeforeServerFetch;
@property (nonatomic, strong, readonly)NSDate *lastUpdate;
@property (nonatomic, strong, readonly)NSObject<XBCache> *cache;

- (void)loadDataWithForceReload:(BOOL)force;

- (void)loadDataWithForceReload:(BOOL)force callback:(void(^)())callback;

@end
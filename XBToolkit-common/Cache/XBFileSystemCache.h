//
// Created by akinsella on 26/03/13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>
#import "XBCache.h"


@interface XBFileSystemCache : NSObject<XBCache>

@property (nonatomic, strong, readonly)NSString * directory;

- (id)initWithDirectory:(NSString *)directory;

+ (id)cacheWithDirectory:(NSString *)directory;


@end
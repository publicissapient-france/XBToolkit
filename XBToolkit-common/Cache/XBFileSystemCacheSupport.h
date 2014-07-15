//
// Created by akinsella on 26/03/13.
//


#import <Foundation/Foundation.h>
#import "XBCacheElement.h"
#import "XBCacheSupport.h"

/**
 *  XBFileSystemCacheSupport provides a filesystem-based cache.
 */
@interface XBFileSystemCacheSupport : NSObject<XBCacheSupport>

- (instancetype)initWithFilename:(NSString *)filename;

+ (instancetype)cacheSupportWithFilename:(NSString *)filename;

@end
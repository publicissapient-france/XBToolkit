//
// Created by akinsella on 26/03/13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>
#import "XBCacheElement.h"
#import "XBCacheSupport.h"

@interface XBFileSystemCacheSupport : NSObject<XBCacheSupport>

- (id)initWithFilename:(NSString *)filename;

+ (id)cacheSupportWithFilename:(NSString *)filename;

@end
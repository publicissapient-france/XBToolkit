//
// Created by akinsella on 01/04/13.
//


#import <Foundation/Foundation.h>

@protocol XBCacheKeyBuilder <NSObject>

@required
- (NSString *)buildWithData:(id)data;

@end
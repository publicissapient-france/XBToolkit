//
// Created by akinsella on 01/04/13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>

@protocol XBCacheKeyBuilder <NSObject>

@required
-(NSString *)buildWithData:(id)data;

@end
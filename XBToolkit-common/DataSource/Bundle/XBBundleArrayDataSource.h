//
// Created by akinsella on 25/03/13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>
#import "XBArrayDataSource.h"
#import "XBLoadableArrayDataSource.h"

@interface XBBundleArrayDataSource : XBLoadableArrayDataSource
- (id)initWithResourcePath:(NSString *)resourcePath resourceType:(NSString *)resourceType;

+ (id)sourceWithResourcePath:(NSString *)resourcePath resourceType:(NSString *)resourceType;


@end
//
// Created by akinsella on 31/03/13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>
#import "XBDataLoader.h"
#import "XBHttpClient.h"
#import "XBHttpQueryParamBuilder.h"

@interface XBBundleJsonDataLoader : NSObject<XBDataLoader>

+ (id)loaderWithResourcePath:(NSString *)resourcePath resourceType:(NSString *)resourceType;

- (id)initWithResourcePath:(NSString *)resourcePath resourceType:(NSString *)resourceType;

@end
//
// Created by akinsella on 31/03/13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>
#import "XBDataLoader.h"
#import "XBHttpClient.h"
#import "XBHttpQueryParamBuilder.h"
#import "XBHttpDataLoader.h"

@interface XBHttpJsonDataLoader : NSObject<XBDataLoader, XBHttpDataLoader>

+ (id)dataLoaderWithHttpClient:(XBHttpClient *)httpClient resourcePath:(NSString *)resourcePath;

+ (id)dataLoaderWithHttpClient:(XBHttpClient *)httpClient httpQueryParamBuilder:(NSObject <XBHttpQueryParamBuilder> *)httpQueryParamBuilder resourcePath:(NSString *)resourcePath;

- (id)initWithHttpClient:(XBHttpClient *)httpClient httpQueryParamBuilder:(NSObject <XBHttpQueryParamBuilder> *)httpQueryParamBuilder resourcePath:(NSString *)resourcePath;

@end
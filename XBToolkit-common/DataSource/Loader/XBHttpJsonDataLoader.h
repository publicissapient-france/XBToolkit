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

- (id)initWithHttpClient:(XBHttpClient *)httpClient dataMapper:(id <XBDataMapper>)dataMapper resourcePath:(NSString *)resourcePath httpQueryParamBuilder:(id <XBHttpQueryParamBuilder>)httpQueryParamBuilder;

+ (instancetype)dataLoaderWithHttpClient:(XBHttpClient *)httpClient dataMapper:(id <XBDataMapper>)dataMapper resourcePath:(NSString *)resourcePath;

+ (instancetype)dataLoaderWithHttpClient:(XBHttpClient *)httpClient httpQueryParamBuilder:(id <XBHttpQueryParamBuilder>)httpQueryParamBuilder resourcePath:(NSString *)resourcePath;

@end
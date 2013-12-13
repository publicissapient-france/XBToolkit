//
// Created by akinsella on 31/03/13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>
#import "XBDataLoader.h"
#import "XBHttpQueryParamBuilder.h"
#import "XBHttpDataLoader.h"

@class XBHttpClient;
@class AFHTTPResponseSerializer;
@protocol AFURLResponseSerialization;

@interface XBHttpMappedDataLoader : NSObject<XBDataLoader, XBHttpDataLoader>

- (id)initWithHttpClient:(XBHttpClient *)httpClient resourcePath:(NSString *)resourcePath dataMapper:(AFHTTPResponseSerializer <AFURLResponseSerialization> *)dataMapper httpQueryParamBuilder:(id <XBHttpQueryParamBuilder>)httpQueryParamBuilder;

+ (instancetype)dataLoaderWithHttpClient:(XBHttpClient *)httpClient resourcePath:(NSString *)resourcePath dataMapper:(AFHTTPResponseSerializer <AFURLResponseSerialization> *)dataMapper;

+ (instancetype)dataLoaderWithHttpClient:(XBHttpClient *)httpClient resourcePath:(NSString *)resourcePath dataMapper:(AFHTTPResponseSerializer <AFURLResponseSerialization> *)dataMapper httpQueryParamBuilder:(id <XBHttpQueryParamBuilder>)httpQueryParamBuilder;

@end
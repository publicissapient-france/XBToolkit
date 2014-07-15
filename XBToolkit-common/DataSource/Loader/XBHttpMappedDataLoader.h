//
// Created by akinsella on 31/03/13.
//


#import <Foundation/Foundation.h>
#import "XBDataLoader.h"
#import "XBHttpRequestDataBuilder.h"
#import "XBHttpDataLoader.h"
#import "XBHttpClient.h"
#import <AFNetworking/AFNetworking.h>

@interface XBHttpMappedDataLoader : NSObject<XBDataLoader, XBHttpDataLoader>

- (instancetype)initWithHttpClient:(XBHttpClient *)httpClient resourcePath:(NSString *)resourcePath httpMethod:(NSString *)httpMethod dataMapper:(AFHTTPResponseSerializer <AFURLResponseSerialization> *)dataMapper requestDataBuilder:(id <XBHttpRequestDataBuilder>)requestDataBuilder;

+ (instancetype)dataLoaderWithHttpClient:(XBHttpClient *)httpClient resourcePath:(NSString *)resourcePath dataMapper:(AFHTTPResponseSerializer <AFURLResponseSerialization> *)dataMapper;

+ (instancetype)dataLoaderWithHttpClient:(XBHttpClient *)httpClient resourcePath:(NSString *)resourcePath dataMapper:(AFHTTPResponseSerializer <AFURLResponseSerialization> *)dataMapper httpQueryParamBuilder:(id <XBHttpRequestDataBuilder>)httpQueryParamBuilder;

+ (instancetype)dataLoaderWithHttpClient:(XBHttpClient *)httpClient resourcePath:(NSString *)resourcePath httpMethod:(NSString *)httpMethod dataMapper:(AFHTTPResponseSerializer <AFURLResponseSerialization> *)dataMapper httpQueryParamBuilder:(id <XBHttpRequestDataBuilder>)httpQueryParamBuilder;

@end
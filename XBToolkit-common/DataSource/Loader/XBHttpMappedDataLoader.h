//
// Created by akinsella on 31/03/13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>
#import "XBDataLoader.h"
#import "XBHTTPRequestDataBuilder.h"
#import "XBHttpDataLoader.h"

@class XBHttpClient1;
@class AFHTTPResponseSerializer;
@protocol AFURLResponseSerialization;

@interface XBHTTPMappedDataLoader : NSObject<XBDataLoader, XBHttpDataLoader>

- (id)initWithHTTPClient:(XBHttpClient1 *)httpClient resourcePath:(NSString *)resourcePath HTTPMethod:(NSString *)HTTPMethod dataMapper:(AFHTTPResponseSerializer <AFURLResponseSerialization> *)dataMapper requestDataBuilder:(id <XBHTTPRequestDataBuilder>)requestDataBuilder;

+ (instancetype)dataLoaderWithHTTPClient:(XBHttpClient1 *)HTTPClient resourcePath:(NSString *)resourcePath dataMapper:(AFHTTPResponseSerializer <AFURLResponseSerialization> *)dataMapper;

+ (instancetype)dataLoaderWithHTTPClient:(XBHttpClient1 *)HTTPClient resourcePath:(NSString *)resourcePath dataMapper:(AFHTTPResponseSerializer <AFURLResponseSerialization> *)dataMapper httpQueryParamBuilder:(id <XBHTTPRequestDataBuilder>)httpQueryParamBuilder;

+ (instancetype)dataLoaderWithHTTPClient:(XBHttpClient1 *)HTTPClient resourcePath:(NSString *)resourcePath HTTPMethod:(NSString *)HTTPMethod dataMapper:(AFHTTPResponseSerializer <AFURLResponseSerialization> *)dataMapper HTTPQueryParamBuilder:(id <XBHTTPRequestDataBuilder>)httpQueryParamBuilder;

@end
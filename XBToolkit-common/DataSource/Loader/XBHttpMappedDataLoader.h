//
// Created by akinsella on 31/03/13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>
#import "XBDataLoader.h"
#import "XBHTTPRequestDataBuilder.h"
#import "XBHttpDataLoader.h"

@class XBHTTPClient;
@class AFHTTPResponseSerializer;
@protocol AFURLResponseSerialization;

@interface XBHTTPMappedDataLoader : NSObject<XBDataLoader, XBHttpDataLoader>

- (id)initWithHTTPClient:(XBHTTPClient *)httpClient resourcePath:(NSString *)resourcePath HTTPMethod:(NSString *)HTTPMethod dataMapper:(AFHTTPResponseSerializer <AFURLResponseSerialization> *)dataMapper requestDataBuilder:(id <XBHTTPRequestDataBuilder>)requestDataBuilder;

+ (instancetype)dataLoaderWithHTTPClient:(XBHTTPClient *)HTTPClient resourcePath:(NSString *)resourcePath dataMapper:(AFHTTPResponseSerializer <AFURLResponseSerialization> *)dataMapper;

+ (instancetype)dataLoaderWithHTTPClient:(XBHTTPClient *)HTTPClient resourcePath:(NSString *)resourcePath dataMapper:(AFHTTPResponseSerializer <AFURLResponseSerialization> *)dataMapper httpQueryParamBuilder:(id <XBHTTPRequestDataBuilder>)httpQueryParamBuilder;

+ (instancetype)dataLoaderWithHTTPClient:(XBHTTPClient *)HTTPClient resourcePath:(NSString *)resourcePath HTTPMethod:(NSString *)HTTPMethod dataMapper:(AFHTTPResponseSerializer <AFURLResponseSerialization> *)dataMapper HTTPQueryParamBuilder:(id <XBHTTPRequestDataBuilder>)httpQueryParamBuilder;

@end
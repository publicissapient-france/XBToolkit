//
// Created by akinsella on 01/04/13.
//


#import "XBHttpDataLoaderCacheKeyBuilder.h"
#import "XBHttpDataLoader.h"
#import "NSDictionary+XBAdditions.h"
#import "XBHttpClient.h"
#import "XBHttpRequestDataBuilder.h"

@implementation XBHttpDataLoaderCacheKeyBuilder

+ (instancetype)cacheKeyBuilder
{
    return [[self alloc] init];
}

- (instancetype)init
{
    self = [super init];
    if (self) {

    }
    return self;
}

- (NSString *)buildWithData:(NSObject<XBHttpDataLoader> *)httpDataLoader
{
    XBHttpClient *httpClient = httpDataLoader.httpClient;
    NSString *resourcePath = httpDataLoader.resourcePath;
    NSDictionary *queryParams = [httpDataLoader.requestDataBuilder build];

    NSString *queryString = [queryParams urlEncodedString];

    NSString *url = [NSString stringWithFormat:@"%@%@", httpClient.baseUrl, resourcePath];

    if (queryString.length > 0) {
        url = [NSString stringWithFormat:@"%@?%@", url, queryString];
    }

    return url;
}

@end
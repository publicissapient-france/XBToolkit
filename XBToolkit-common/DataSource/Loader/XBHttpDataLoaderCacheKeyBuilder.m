//
// Created by akinsella on 01/04/13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "XBHttpDataLoaderCacheKeyBuilder.h"
#import "XBHttpDataLoader.h"
#import "NSDictionary+XBAdditions.h"
#import "XBHttpClient.h"

@implementation XBHttpDataLoaderCacheKeyBuilder

+ (id)cacheKeyBuilder {
    return [[self alloc] init];
}

- (id)init {
    self = [super init];
    if (self) {

    }

    return self;
}

- (NSString *)buildWithData:(NSObject<XBHttpDataLoader> *)httpDataLoader {
    XBHttpClient *httpClient = httpDataLoader.httpClient;
    NSString *resourcePath = httpDataLoader.resourcePath;
    NSDictionary *queryParams = [httpDataLoader.httpQueryParamBuilder build];

    NSString *queryString = [queryParams urlEncodedString];

    NSString *url = [NSString stringWithFormat:@"%@%@", httpClient.baseUrl, resourcePath];

    if (queryString.length > 0) {
        url = [NSString stringWithFormat:@"%@?%@", url, queryString];
    }

    return url;
}

@end
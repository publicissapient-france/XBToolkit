//
// Created by akinsella on 10/03/13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "XBHttpArrayDataSource+protected.h"
#import "XBLoadableArrayDataSource+protected.h"
#import "XBCacheableArrayDataSource+protected.h"

@implementation XBHttpArrayDataSource

+ (XBHttpArrayDataSource *)dataSourceWithConfiguration:(XBHttpArrayDataSourceConfiguration *)configuration httpClient:(XBHttpClient *)httpClient {
    return [[self alloc] initWithConfiguration:configuration httpClient: httpClient];
}

- (id)initWithConfiguration:(XBHttpArrayDataSourceConfiguration *)configuration httpClient:(XBHttpClient *)httpClient {
    self = [super init];
    if (self) {
        self.dateFormatter = configuration.dateFormat;
        self.typeClass = configuration.typeClass;
        self.rootKeyPath = configuration.rootKeyPath;
        self.storageFileName = configuration.storageFileName;
        self.maxDataAgeInSecondsBeforeServerFetch = configuration.maxDataAgeInSecondsBeforeServerFetch;
        self.cache = configuration.cache;
        self.resourcePath = configuration.resourcePath;
        self.httpClient = httpClient;
        self.httpQueryParamBuilder = configuration.httpQueryParamBuilder;
    }

    return self;
}

- (void)setHttpClient:(XBHttpClient *)httpClient {
    _httpClient = httpClient;
}

- (void)setResourcePath:(NSString *)resourcePath {
    _resourcePath = resourcePath;
}

- (void)setHttpQueryParamBuilder:(NSObject <XBHttpQueryParamBuilder> *)httpQueryParamBuilder {
    _httpQueryParamBuilder = httpQueryParamBuilder;
}

- (void)fetchDataFromSourceInternalWithCallback:(void (^)())callback {
    [self.httpClient executeGetJsonRequestWithPath:self.resourcePath parameters:[self.httpQueryParamBuilder build]
       success:^(NSURLRequest *request, NSHTTPURLResponse *response, id jsonFetched) {
           [self processSuccessWithJson: jsonFetched callback:callback];
       }
       failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id jsonFetched) {
           [self processError:error json:jsonFetched callback:callback];
       }
    ];
}

@end
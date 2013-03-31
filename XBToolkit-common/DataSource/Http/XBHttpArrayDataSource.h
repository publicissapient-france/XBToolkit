//
// Created by akinsella on 10/03/13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>

#import "XBHttpClient.h"
#import "XBHttpArrayDataSourceConfiguration.h"
#import "XBArrayDataSource.h"
#import "XBBasicHttpQueryParamBuilder.h"
#import "XBLoadableArrayDataSource.h"
#import "XBCacheableArrayDataSource.h"

@interface XBHttpArrayDataSource : XBCacheableArrayDataSource {
    NSString * _resourcePath;
    XBHttpClient *_httpClient;
    NSObject<XBHttpQueryParamBuilder> *_httpQueryParamBuilder;
}

@property (nonatomic, strong, readonly)NSString *resourcePath;
@property (nonatomic, strong, readonly)XBHttpClient *httpClient;
@property (nonatomic, strong, readonly)NSObject<XBHttpQueryParamBuilder> *httpQueryParamBuilder;

+ (XBHttpArrayDataSource *)dataSourceWithConfiguration:(XBHttpArrayDataSourceConfiguration *)configuration httpClient:(XBHttpClient *)httpClient;
- (id)initWithConfiguration:(XBHttpArrayDataSourceConfiguration *)configuration httpClient:(XBHttpClient *)httpClient;

@end
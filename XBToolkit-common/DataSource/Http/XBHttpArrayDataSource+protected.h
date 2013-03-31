//
// Created by akinsella on 10/03/13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>

#import "XBHttpClient.h"
#import "XBHttpArrayDataSourceConfiguration.h"
#import "XBHttpArrayDataSource.h"

@interface XBHttpArrayDataSource (XBHttpArrayDataSource_protected)

- (void)loadArrayFromJson:(NSDictionary *)json;
- (NSArray *)data;

- (void)setHttpClient:(XBHttpClient *)httpClient;
- (void)setResourcePath:(NSString *)resourcePath;
- (void)setHttpQueryParamBuilder:(NSObject<XBHttpQueryParamBuilder> *)httpQueryParamBuilder;

@end
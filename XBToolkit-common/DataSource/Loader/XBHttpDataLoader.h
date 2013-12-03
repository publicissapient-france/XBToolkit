//
// Created by akinsella on 01/04/13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>
#import "XBHttpClient.h"

@protocol XBHttpQueryParamBuilder;

@protocol XBHttpDataLoader<NSObject>

- (NSString *)resourcePath;
- (id<XBHttpQueryParamBuilder>)httpQueryParamBuilder;
- (XBHttpClient *)httpClient;

@end
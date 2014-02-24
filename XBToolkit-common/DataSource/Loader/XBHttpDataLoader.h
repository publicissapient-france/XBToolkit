//
// Created by akinsella on 01/04/13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>
#import "XBHttpClient.h"

@protocol XBHttpRequestDataBuilder;

@protocol XBHttpDataLoader<NSObject>

- (NSString *)resourcePath;
- (id<XBHttpRequestDataBuilder>)requestDataBuilder;
- (XBHttpClient *)httpClient;

@end
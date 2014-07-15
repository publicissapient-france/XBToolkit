//
// Created by akinsella on 01/04/13.
//


#import <Foundation/Foundation.h>
#import "XBHttpClient.h"

@protocol XBHttpRequestDataBuilder;

@protocol XBHttpDataLoader<NSObject>

- (NSString *)resourcePath;

- (id <XBHttpRequestDataBuilder>)requestDataBuilder;

- (XBHttpClient *)httpClient;

@end
//
// Created by akinsella on 01/04/13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>
#import "XBHttpClient1.h"

@protocol XBHTTPRequestDataBuilder;

@protocol XBHttpDataLoader<NSObject>

- (NSString *)resourcePath;
- (id<XBHTTPRequestDataBuilder>)requestDataBuilder;
- (XBHttpClient1 *)HTTPClient;

@end
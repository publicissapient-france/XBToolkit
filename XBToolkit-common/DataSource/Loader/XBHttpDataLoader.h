//
// Created by akinsella on 01/04/13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>
#import "XBHTTPClient.h"

@protocol XBHTTPRequestDataBuilder;

@protocol XBHttpDataLoader<NSObject>

- (NSString *)resourcePath;
- (id<XBHTTPRequestDataBuilder>)requestDataBuilder;
- (XBHTTPClient *)HTTPClient;

@end
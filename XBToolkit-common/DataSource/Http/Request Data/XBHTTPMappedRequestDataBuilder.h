//
// Created by Simone Civetta on 14/12/13.
// Copyright (c) 2013 Xebia. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol AFURLRequestSerialization;
@class AFHTTPRequestSerializer;

@protocol XBHTTPMappedRequestDataBuilder <NSObject>

@required
- (AFHTTPRequestSerializer <AFURLRequestSerialization> *)requestSerializer;

@end
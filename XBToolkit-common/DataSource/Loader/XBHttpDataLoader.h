//
// Created by akinsella on 01/04/13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>
#import "XBHttpQueryParamBuilder.h"
#import "XBHttpClient.h"

@protocol XBHttpDataLoader<NSObject>

-(NSString *)resourcePath;
-(NSObject<XBHttpQueryParamBuilder> *)httpQueryParamBuilder;
-(XBHttpClient *)httpClient;

@end
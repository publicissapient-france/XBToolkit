//
// Created by akinsella on 25/03/13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>
#import "XBHTTPRequestDataBuilder.h"


@interface XBBasicHttpQueryParamBuilder : NSObject<XBHTTPRequestDataBuilder>

@property(nonatomic, strong)NSDictionary *dictionary;

- (id)initWithDictionary:(NSDictionary *)dictionary;

+ (XBBasicHttpQueryParamBuilder *)builderWithDictionary:(NSDictionary *)dictionary;

@end
//
// Created by akinsella on 25/03/13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>
#import "XBHttpRequestDataBuilder.h"


@interface XBBasicHttpQueryParamBuilder : NSObject<XBHttpRequestDataBuilder>

@property(nonatomic, strong)NSDictionary *dictionary;

- (id)initWithDictionary:(NSDictionary *)dictionary;

+ (XBBasicHttpQueryParamBuilder *)builderWithDictionary:(NSDictionary *)dictionary;

@end
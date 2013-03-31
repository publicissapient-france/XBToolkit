//
// Created by akinsella on 25/03/13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>
#import "XBHttpQueryParamBuilder.h"


@interface XBBasicHttpQueryParamBuilder : NSObject<XBHttpQueryParamBuilder>

@property(nonatomic, strong)NSDictionary *dictionary;

- (id)initWithDictionary:(NSDictionary *)dictionary;

+ (XBBasicHttpQueryParamBuilder *)builderWithDictionary:(NSDictionary *)dictionary;

@end
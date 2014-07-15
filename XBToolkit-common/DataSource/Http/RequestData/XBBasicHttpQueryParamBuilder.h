//
// Created by akinsella on 25/03/13.
//


#import <Foundation/Foundation.h>
#import "XBHttpRequestDataBuilder.h"


@interface XBBasicHttpQueryParamBuilder : NSObject<XBHttpRequestDataBuilder>

@property (nonatomic, strong) NSDictionary *dictionary;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

+ (instancetype)builderWithDictionary:(NSDictionary *)dictionary;

@end
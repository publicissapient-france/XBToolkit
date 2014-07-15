//
// Created by akinsella on 25/03/13.
//


#import "XBBasicHttpQueryParamBuilder.h"


@implementation XBBasicHttpQueryParamBuilder

- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if (self) {
        self.dictionary = dictionary;
    }

    return self;
}

+ (instancetype)builderWithDictionary:(NSDictionary *)dictionary
{
    return [[self alloc] initWithDictionary:dictionary];
}

- (NSDictionary *)build
{
    return [self.dictionary copy];
}

@end

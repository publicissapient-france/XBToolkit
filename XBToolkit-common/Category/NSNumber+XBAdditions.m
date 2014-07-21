//
// Created by akinsella on 24/09/12.
//


#import "NSNumber+XBAdditions.h"


@implementation NSNumber (XBAdditions)

+ (NSString *)asString:(NSInteger)value {
    return [[NSNumber numberWithInteger:value] description];
}

@end
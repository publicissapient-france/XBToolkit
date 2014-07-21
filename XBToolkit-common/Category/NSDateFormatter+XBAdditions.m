//
// Created by akinsella on 24/09/12.
//


#import "NSDateFormatter+XBAdditions.h"


@implementation NSDateFormatter (XBAdditions)

+(NSDateFormatter *)initWithDateFormat:(NSString *)dateFormat {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:dateFormat];
    return dateFormatter;
}


@end
//
// Created by akinsella on 24/09/12.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "NSDateFormatter+XBAdditions.h"


@implementation NSDateFormatter (XBAdditions)

+(NSDateFormatter *)initWithDateFormat:(NSString *)dateFormat {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:dateFormat];
    return dateFormatter;
}


@end
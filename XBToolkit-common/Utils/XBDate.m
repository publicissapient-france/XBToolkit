//
//  Date.m
//  Xebia Application
//
//  Created by Alexis Kinsella on 19/07/12.
//  Copyright (c) 2012 Xebia France. All rights reserved.
//
#import "XBDate.h"


@implementation XBDate

+ (NSDate *)parseDate:(NSString *)dateStr withFormat:format {
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateFormat:format];
    [df setTimeZone:[NSTimeZone localTimeZone]];
    NSDate *date = [df dateFromString:dateStr];
    
    return date;
}

+ (NSString *)formattedDateRelativeToNow:(NSDate *)date {
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"yyyy-MM-dd"];
    NSDate *midnight = [df dateFromString:[df stringFromDate:date]];

    NSInteger dayDiff = (int)[midnight timeIntervalSinceNow] / (60*60*24);

    if(dayDiff == 0) {
        NSDateFormatter *df2 = [[NSDateFormatter alloc] init];
        [df2 setDateFormat:@"HH:mm"];
        NSString *dateFormatted = [df2 stringFromDate:date];
//        NSLog(@"Date formatted: %@", dateFormatted);
        return [NSString stringWithFormat:@"Today, %@", dateFormatted];
    }
    else if(dayDiff == -1) {
        return @"Yesterday";
    }
    else if(dayDiff == -2) {
        return @"Two days ago";
    }
    else if(dayDiff > -7 && dayDiff <= -2) {
        return @"This week";
    }
    else if(dayDiff > -14 && dayDiff <= -7) {
        return @"Last week";
    }
    else if(dayDiff >= -30 && dayDiff <= -14) {
        return @"This month";
    }
    else if(dayDiff >= -60 && dayDiff <= -30) {
        return @"Last month";
    }
    else if(dayDiff >= -90 && dayDiff <= -60) {
        return @"Within last three months";
    }
    else if(dayDiff >= -180 && dayDiff <= -90) {
        return @"Within last six months";
    }
    else if(dayDiff >= -365 && dayDiff <= -180) {
        return @"Within this year";
    }
    else if(dayDiff < -365) {
        return @"A long time ago";
    }
    else {
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"'yyyy'/'MM'/'dd', 'hh':'mm'"];
        return [dateFormatter stringFromDate:date];        
    }

}

@end

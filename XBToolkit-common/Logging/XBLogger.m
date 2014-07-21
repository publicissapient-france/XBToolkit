//
// Created by Alexis Kinsella on 17/01/2014.
// Copyright (c) 2014 Xebia IT Architects. All rights reserved.
//

#import "XBLogger.h"
#import "NSDateFormatter+XBAdditions.h"

NSString * const XBLoggerDateFormatter = @"XBLoggerDateFormatter";
NSString * const XBLoggerTimeFormatter = @"XBLoggerTimeFormatter";

@implementation XBLogger

+ (NSDateFormatter *)dateFormatter {
    NSMutableDictionary *dictionary = [[NSThread currentThread] threadDictionary];
    NSDateFormatter *dateFormatter = dictionary[XBLoggerDateFormatter];
    if (!dateFormatter) {
        dateFormatter = [NSDateFormatter initWithDateFormat:@"yyyy/MM/dd"];
        dictionary[XBLoggerDateFormatter] = dateFormatter;
    }

    return dateFormatter;
}

+ (NSDateFormatter *)timeFormatter {
    NSMutableDictionary *dictionary = [[NSThread currentThread] threadDictionary];
    NSDateFormatter *timeFormatter = dictionary[XBLoggerTimeFormatter];
    if (!timeFormatter) {
        timeFormatter = [NSDateFormatter initWithDateFormat:@"HH:mm:ss.SSS"];
        dictionary[XBLoggerTimeFormatter] = timeFormatter;
    }

    return timeFormatter;
}

+(void)logWithSourceFile:(char *)sourceFile level:(NSString *)level lineNumber:(int)lineNumber format:(NSString*)format, ...
{
    va_list ap;
    va_start(ap, format);
    va_end(ap);

    if (![format hasSuffix: @"\n"]) {
        format = [format stringByAppendingString: @"\n"];
    }

    NSString *print = [[NSString alloc] initWithFormat:format arguments:ap];
    NSString *file = [[NSString alloc] initWithBytes:sourceFile length:strlen(sourceFile) encoding:NSUTF8StringEncoding];

    NSDate *now = [NSDate date];
    NSString *dateFormatted = [[XBLogger dateFormatter] stringFromDate:now];
    NSString *timeFormatted = [[XBLogger timeFormatter] stringFromDate:now];

    fprintf(stderr, "[%s][%s][%s][%s:%d] %s", [dateFormatted UTF8String], [timeFormatted UTF8String], [level UTF8String], [file.lastPathComponent UTF8String], lineNumber, [print UTF8String]);
}

@end
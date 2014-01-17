//
// Created by Alexis Kinsella on 17/01/2014.
// Copyright (c) 2014 Xebia IT Architects. All rights reserved.
//

#import "XBLogger.h"
#import "NSDateFormatter+XBAdditions.h"

NSString * const CDLoggerDateFormatter = @"CDLoggerDateFormatter";


@implementation XBLogger

+ (NSDateFormatter *)dateFormatter {
    NSMutableDictionary *dictionary = [[NSThread currentThread] threadDictionary];
    if (!dictionary[CDLoggerDateFormatter]) {
        dictionary[CDLoggerDateFormatter] = [NSDateFormatter initWithDateFormat:@"yyyy/MM/dd HH:mm:ss.SSS"];
    }

    return dictionary[CDLoggerDateFormatter];
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

    fprintf(stderr, "[%s][%s][%s:%d] %s\n", [[[XBLogger dateFormatter] stringFromDate:[NSDate date]] UTF8String], [level UTF8String], [file.lastPathComponent UTF8String], lineNumber, [print UTF8String]);
}

@end
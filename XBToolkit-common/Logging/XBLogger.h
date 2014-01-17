//
// Created by Alexis Kinsella on 17/01/2014.
// Copyright (c) 2014 Xebia IT Architects. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString * const XBLoggerDateFormatter;

@interface XBLogger : NSObject

+(void)logWithSourceFile:(char *)sourceFile level:(NSString *)level lineNumber:(int)lineNumber format:(NSString*)format, ...;

@end
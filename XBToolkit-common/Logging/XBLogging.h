//
// Created by Alexis Kinsella on 17/01/2014.
// Copyright (c) 2014 Xebia IT Architects. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "XBLogger.h"

#define kLogLevelVerbose @"VERBOSE"
#define kLogLevelDebug @"DEBUG"
#define kLogLevelInfo @"INFO"
#define kLogLevelWarn @"WARN"
#define kLogLevelError @"ERROR"


#ifdef DEBUG
    #define XBLog(fmt, logLevel, ...) \
            [XBLogger logWithSourceFile:__FILE__ level:logLevel lineNumber:__LINE__ format:fmt, ##__VA_ARGS__]
#else
    #define XBLog(...)
#endif

#ifdef DEBUG
    #define XBLogVerbose(fmt, ...) XBLog(fmt, kLogLevelVerbose, ##__VA_ARGS__)
    #define XBLogDebug(fmt, ...)   XBLog(fmt, kLogLevelDebug, ##__VA_ARGS__)
#else
    #define XBLogVerbose(fmt, ...)
    #define XBLogDebug(...)
#endif

#define XBLogInfo(fmt, ...)    XBLog(fmt, kLogLevelInfo, ##__VA_ARGS__)
#define XBLogWarn(fmt, ...)    XBLog(fmt, kLogLevelWarn, ##__VA_ARGS__)
#define XBLogError(fmt, ...)   XBLog(fmt, kLogLevelError, ##__VA_ARGS__)

#define NSLog(...) XBLog(fmt, kLogLevelInfo, ##__VA_ARGS__)


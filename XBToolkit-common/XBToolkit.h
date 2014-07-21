//
// Created by akinsella on 31/03/13.
//


#import <Foundation/Foundation.h>

#define mustOverride() @throw [NSException exceptionWithName:NSInvalidArgumentException reason:[NSString stringWithFormat:@"%s must be overridden in a subclass/category", __PRETTY_FUNCTION__] userInfo:nil]
#define methodNotImplemented() mustOverride()

#if XB_DEBUG
    #define XBLogDebug(...) LCLog(__VA_ARGS__)
#else
    #define XBLogDebug(...)
#endif


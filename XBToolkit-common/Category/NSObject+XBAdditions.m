//
// Created by Alexis Kinsella on 28/03/2014.
// Copyright (c) 2014 Xebia. All rights reserved.
//

#import "NSObject+XBAdditions.h"
#import <objc/runtime.h>
#import "NSDateFormatter+XBAdditions.h"
#import "Underscore.h"


@implementation NSObject (XBAdditions)

- (NSString *)serializeToJsonWithError:(NSError **)error
{
    NSDateFormatter *dateFormatter = [NSDateFormatter initWithDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSSZZZ"];
    return [self serializeToJsonWithDateFormatter:dateFormatter error:error];
}

- (NSString *)serializeToJsonWithDateFormatter:(NSDateFormatter *)dateFormatter error:(NSError **)error
{
    id result = [self dictOrArrayFromObjectWithDateFormatter:dateFormatter];
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:result
                                                       options:(NSJSONWritingOptions)kNilOptions
                                                         error:error];

    if (!jsonData || error) {
        XBLogDebug(@"JSON error: %@", *error);
        return nil;
    }

    NSString *json = [[NSString alloc] initWithBytes:jsonData.bytes length:jsonData.length encoding:NSUTF8StringEncoding];

    return json;
}

- (id)dictOrArrayFromObjectWithDateFormatter:(NSDateFormatter *)dateFormatter
{
    if ([self isKindOfClass:NSDictionary.class]) {
        return Underscore.dictMap((NSDictionary *) self, ^id(id key, id obj) {
            return [obj dictOrArrayFromObjectWithDateFormatter:dateFormatter];
        });
    }

    if ([self isKindOfClass:NSArray.class]) {
        return Underscore.arrayMap((NSArray *) self, ^id(id obj) {
            return [obj dictOrArrayFromObjectWithDateFormatter:dateFormatter];
        });
    }

    if ([self isKindOfClass:NSSet.class]) {
        return Underscore.arrayMap(((NSSet *) self).allObjects, ^id(id obj) {
            return [obj dictOrArrayFromObjectWithDateFormatter:dateFormatter];
        });
    }

    if ([self isKindOfClass:NSDate.class]) {
        return [dateFormatter stringFromDate:(NSDate *) self];
    }

    if ([self isKindOfClass:NSString.class]) {
        return self;
    }

    if ([self isKindOfClass:NSNumber.class]) {
        return self;
    }

    return [self processWithDateFormatter:dateFormatter];
}

- (id)processWithDateFormatter:(NSDateFormatter *)dateFormatter
{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];

    unsigned count;
    objc_property_t *properties = class_copyPropertyList(self.class, &count);

    for (int i = 0; i < count; i++) {
        NSString *key = [NSString stringWithUTF8String:property_getName(properties[i])];
        id value = [[self valueForKey:key] dictOrArrayFromObjectWithDateFormatter:dateFormatter];
        dict[key] = value != nil ? value : [NSNull null];
    }

    free(properties);

    return [dict copy];
}

@end
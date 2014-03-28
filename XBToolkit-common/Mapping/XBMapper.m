//
// Created by akinsella on 18/03/13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "XBMapper.h"

#import <objc/runtime.h>
#import "NSDateFormatter+XBAdditions.h"
#import "NSDictionary+XBAdditions.h"

@implementation XBMapper


+ (NSString *)objectToSerializedJson:(id)obj
{
    return [self objectToSerializedJson:obj withDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSSZZZ"];
}

+ (NSString *)objectToSerializedJson:(id)obj withDateFormat:(NSString *)dateFormat
{
    NSDictionary *dict = [self dictionaryWithPropertiesOfObject:obj];

    NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
    [outputFormatter setDateFormat:dateFormat];
    NSError *error;
    NSString *json = [dict JSONStringWithError:&error dateFormatter:outputFormatter];

    return json;
}

+ (NSDictionary *)dictionaryWithPropertiesOfObject:(id)obj
{
    return [self dictionaryWithPropertiesOfObject:obj withDateFormat:@"yyyy-MM-dd HH:mm:ss"];
}

+ (NSDictionary *)dictionaryWithPropertiesOfObject:(id)obj withDateFormat:(NSString *)dateFormat
{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];

    unsigned count;
    objc_property_t *properties = class_copyPropertyList([obj class], &count);

    for (int i = 0; i < count; i++) {
        NSString *key = [NSString stringWithUTF8String:property_getName(properties[i])];
        id value = [obj valueForKey:key];

        if (value) {
            if ([value isKindOfClass:NSArray.class]) {
                NSSet *array = (NSSet *) value;
                NSMutableArray *entries = [NSMutableArray arrayWithCapacity:[array count]];
                for (id entry in array) {
                    id subObj = [XBMapper dictionaryWithPropertiesOfObject:entry];
                    [entries addObject:subObj];
                }

                [dict setObject:entries forKey:key];
            }
            else if ([value isKindOfClass:NSSet.class]) {
                NSSet *set = (NSSet *) value;
                NSMutableArray *entries = [NSMutableArray arrayWithCapacity:[set count]];
                for (id entry in set) {
                    id subObj = [XBMapper dictionaryWithPropertiesOfObject:entry];
                    [entries addObject:subObj];
                }

                [dict setObject:entries forKey:key];
            }
            else if ([value isKindOfClass:NSDate.class]) {
                [dict setObject:[[NSDateFormatter initWithDateFormat:dateFormat] stringFromDate:value] forKey:key];
            }
            else if ([value isKindOfClass:NSString.class]) {
                [dict setObject:value forKey:key];
            }
            else if ([value isKindOfClass:NSNumber.class]) {
                [dict setObject:value forKey:key];
            }
            else /* if ([value isKindOfClass:NSObject.class]) */ {
                id subObj = [self dictionaryWithPropertiesOfObject:[obj valueForKey:key]];
                [dict setObject:subObj forKey:key];
            }
        }
    }

    free(properties);

    return [NSDictionary dictionaryWithDictionary:dict];
}

@end
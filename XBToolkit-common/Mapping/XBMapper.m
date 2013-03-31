//
// Created by akinsella on 18/03/13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "XBMapper.h"

#import <objc/runtime.h>
#import "NSDateFormatter+XBAdditions.h"
#import "JSONKit.h"
#import "DCKeyValueObjectMapping.h"
#import "XBMappingProvider.h"

@implementation XBMapper


+ (NSString *)objectToSerializedJson:(id)obj {
    return [self objectToSerializedJson: obj withDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSSZZZ"];
}

+ (NSString *)objectToSerializedJson:(id)obj withDateFormat:(NSString *)dateFormat {
    NSDictionary * dict = [XBMapper dictionaryWithPropertiesOfObject:obj];

    NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
    [outputFormatter setDateFormat:dateFormat];

    NSString* json = [dict JSONStringWithOptions:JKSerializeOptionNone serializeUnsupportedClassesUsingBlock:^id(id object) {
        if([object isKindOfClass:[NSDate class]]) { return([outputFormatter stringFromDate:object]); }
        return(nil);
    } error:nil];

    return json;
}

+(NSDictionary *) dictionaryWithPropertiesOfObject:(id)obj {
    return  [XBMapper dictionaryWithPropertiesOfObject:obj withDateFormat:@"yyyy-MM-dd HH:mm:ss"];
}

+(NSDictionary *) dictionaryWithPropertiesOfObject:(id)obj withDateFormat:(NSString *) dateFormat {
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];

    unsigned count;
    objc_property_t *properties = class_copyPropertyList([obj class], &count);

    for (int i = 0; i < count; i++) {
        NSString *key = [NSString stringWithUTF8String:property_getName(properties[i])];
        id value = [obj valueForKey:key];

        if (value) {
//            if ([value isKindOfClass:NSManagedObject.class]) {
//                id subObj = [XBMapper dictionaryWithPropertiesOfObject:value];
//                [dict setObject:subObj forKey:key];
//            }
//            else if ([value isKindOfClass:NSArray.class]) {
            if ([value isKindOfClass:NSArray.class]) {
                NSSet *array = (NSSet *)value;
                NSMutableArray *entries = [NSMutableArray arrayWithCapacity:[array count]];
                for (id entry in array) {
                    id subObj = [XBMapper dictionaryWithPropertiesOfObject:entry];
                    [entries addObject:subObj];
                }

                [dict setObject:entries forKey:key];
            }
            else if ([value isKindOfClass:NSSet.class]) {
                NSSet *set = (NSSet *)value;
                NSMutableArray *entries = [NSMutableArray arrayWithCapacity:[set count]];
                for (id entry in set) {
                    id subObj = [XBMapper dictionaryWithPropertiesOfObject:entry];
                    [entries addObject:subObj];
                }

                [dict setObject:entries forKey:key];
            }
            else if ([value isKindOfClass:NSDate.class]) {
                [dict setObject:value forKey:[[NSDateFormatter initWithDateFormat:dateFormat] stringFromDate:value]];
            }
            else {
                Class classObject = NSClassFromString([key capitalizedString]);
                if (classObject) {
                    id subObj = [self dictionaryWithPropertiesOfObject:[obj valueForKey:key]];
                    [dict setObject:subObj forKey:key];
                }
                else {
                    if(value) {
                        [dict setObject:value forKey:key];
                    }
                }
            }
        }
    }

    free(properties);

    return [NSDictionary dictionaryWithDictionary:dict];
}

+ (NSArray *)parseArray:(NSArray*)objectArray intoObjectsOfType:(Class)objectClass {

    if (![objectClass conformsToProtocol:@protocol(XBMappingProvider)]) {

        [NSException raise:NSInvalidArgumentException format:@"Class provided does not implement XBMappingProtocol"];
    }

    DCKeyValueObjectMapping *parser = [DCKeyValueObjectMapping mapperForClass: objectClass andConfiguration: [objectClass mappings]];

    return [parser parseArray:objectArray];

}

+ (id)parseObject:(NSDictionary*)objectDictionnary intoObjectsOfType:(Class)objectClass {

    if (![objectClass conformsToProtocol:@protocol(XBMappingProvider)]) {

        [NSException raise:NSInvalidArgumentException format:@"Class provided does not implement XBMappingProtocol"];
    }

    DCKeyValueObjectMapping *parser = [DCKeyValueObjectMapping mapperForClass: objectClass andConfiguration: [objectClass mappings]];

    return [parser parseDictionary:objectDictionnary];

}

@end
//
// Created by akinsella on 31/03/13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "XBCacheElement.h"


@implementation XBCacheElement


+ (id)elementWithKey:(NSString *)key value:(NSObject *)value {
    return [self elementWithKey:key value:value ttl: 0];
}

+ (id)elementWithKey:(NSString *)key value:(NSObject *)value ttl:(NSTimeInterval)ttl {
    return [[self alloc] initWithKey:key value:value ttl:ttl];
}

- (id)initWithKey:(NSString *)key value:(NSObject *)value ttl:(NSTimeInterval)ttl {
    self = [super init];
    if (self) {
        self.key = key;
        self.value = value;
        self.ttl = ttl;
    }

    return self;
}

- (id)initWithCoder:(NSCoder *)decoder
{
    self = [super init];
    if (self) {
        self.key   = [decoder decodeObjectForKey:@"key"];
        self.value = [decoder decodeObjectForKey:@"value"];
        self.ttl   = [decoder decodeDoubleForKey:@"ttl"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)code
{
    [code encodeObject:self.key forKey:@"key"];
    [code encodeObject:self.value forKey:@"value"];
    [code encodeDouble:self.ttl forKey:@"ttl"];
}

- (void)setTimeToLive:(NSTimeInterval)ttl {
    self.ttl = ttl ? [NSDate timeIntervalSinceReferenceDate] + ttl : 0;
}

- (BOOL)hasExpired {
    if (!self.ttl) {
        return NO;
    }

    return ([NSDate timeIntervalSinceReferenceDate] <= self.ttl);
}

@end
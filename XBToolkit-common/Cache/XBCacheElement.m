//
// Created by akinsella on 31/03/13.
//


#import "XBCacheElement.h"

@implementation XBCacheElement

+ (instancetype)elementWithKey:(NSString *)key value:(id <NSCoding>)value
{
    return [self elementWithKey:key value:value expirationTime:0];
}

+ (instancetype)elementWithKey:(NSString *)key value:(id <NSCoding>)value expirationTime:(NSTimeInterval)expirationTime
{
    return [[self alloc] initWithKey:key value:value expirationTime:expirationTime];
}

- (instancetype)initWithKey:(NSString *)key value:(id <NSCoding>)value expirationTime:(NSTimeInterval)expirationTime
{
    self = [super init];
    if (self) {
        self.key = key;
        self.value = value;
        self.expirationTime = expirationTime;
    }

    return self;
}

- (instancetype)initWithCoder:(NSCoder *)decoder
{
    self = [super init];
    if (self) {
        self.key = [decoder decodeObjectForKey:@"key"];
        self.value = [decoder decodeObjectForKey:@"value"];
        self.expirationTime = [decoder decodeDoubleForKey:@"ttl"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)code
{
    [code encodeObject:self.key forKey:@"key"];
    [code encodeObject:self.value forKey:@"value"];
    [code encodeDouble:self.expirationTime forKey:@"ttl"];
}

- (void)setTimeToLive:(NSTimeInterval)ttl
{
    self.expirationTime = ttl ? [NSDate timeIntervalSinceReferenceDate] + ttl : 0;
}

- (BOOL)hasExpired
{
    if (!self.expirationTime) {
        return NO;
    }

    return ([NSDate timeIntervalSinceReferenceDate] <= self.expirationTime);
}

@end
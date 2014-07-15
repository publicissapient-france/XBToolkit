//
// Created by akinsella on 31/03/13.
//


#import <Foundation/Foundation.h>

/**
 *  An XBCacheElement provides a key-value interface for storing objects in cache along with its cache metadata
 */
@interface XBCacheElement : NSObject<NSCoding>

/**
 *  The key identifying the cached object
 */
@property (nonatomic, copy) NSString *key;

/**
 *  The value of the cached object
 */
@property (nonatomic, strong) id <NSCoding> value;

/**
 *  The time after the which the elemement will potentially be removed from the cache
 */
@property (nonatomic, assign) NSTimeInterval expirationTime;

+ (instancetype)elementWithKey:(NSString *)key value:(id <NSCoding>)value;

+ (instancetype)elementWithKey:(NSString *)key value:(id <NSCoding>)value expirationTime:(NSTimeInterval)expiration;

- (instancetype)initWithKey:(NSString *)key value:(id <NSCoding>)value expirationTime:(NSTimeInterval)expiration;

- (void)setTimeToLive:(NSTimeInterval)ttl;

- (BOOL)hasExpired;

@end
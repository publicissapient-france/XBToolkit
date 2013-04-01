    //
// Created by akinsella on 31/03/13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>


@interface XBCacheElement : NSObject <NSCoding>

@property (nonatomic, copy) NSString *key;
@property (nonatomic, retain) NSObject *value;
@property (nonatomic, assign) NSTimeInterval ttl;

+ (id)elementWithKey:(NSString *)key value:(NSObject *)value;

+ (id)elementWithKey:(NSString *)key value:(NSObject *)value ttl:(NSTimeInterval)ttl;

- (id)initWithKey:(NSString *)key value:(NSObject *)value ttl:(NSTimeInterval)ttl;

- (void)setTimeToLive:(NSTimeInterval)expiration;

- (BOOL)hasExpired;

@end
//
// Created by akinsella on 31/03/13.
//


#import <Foundation/Foundation.h>

@protocol XBCacheSupport <NSObject>

@required

- (void)setForKey:(NSString *)key value:(id <NSCoding>)value expirationTime:(NSTimeInterval)expiration error:(NSError**)error;

- (id)getForKey:(NSString *)key error:(NSError **)error forceIfExpired:(BOOL)force;

- (void)clearForKey:(NSString *)key error:(NSError**)error;

- (void)clearAllWithError:(NSError **)error;

@end
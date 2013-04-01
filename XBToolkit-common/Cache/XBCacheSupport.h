//
// Created by akinsella on 31/03/13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>

@protocol XBCacheSupport <NSObject>

@required
-(void)setForKey:(NSString *)key value:(NSString *)value ttl:(NSTimeInterval)expiration error:(NSError**)error;
-(id)getForKey:(NSString *)key error:(NSError**)error;
- (void)clearForKey:(NSString *)key error:(NSError**)error;
- (void)clearAllWithError:(NSError **)error;

@end
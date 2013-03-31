//
// Created by akinsella on 26/03/13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>

@protocol XBCache<NSObject>

@required
-(void)setForKey:(NSString *)key value:(NSString *)value error:(NSError**)error;
-(NSString *)getForKey:(NSString *)key error:(NSError**)error;
- (void) clearForKey:(NSString *)key error:(NSError**)error;

@end
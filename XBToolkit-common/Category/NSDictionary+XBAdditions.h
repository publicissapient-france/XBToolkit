//
// Created by akinsella on 01/04/13.
//


#import <Foundation/Foundation.h>

@interface NSDictionary (XBAdditions)

- (NSString *)urlEncodedString;

- (NSMutableDictionary *)deepMutableCopy;
- (NSDictionary *)deepImmutableCopy;

@end
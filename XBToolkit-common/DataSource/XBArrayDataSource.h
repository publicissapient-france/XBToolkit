//
// Created by akinsella on 29/03/13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>
#import "XBArrayDataSource.h"

typedef BOOL (^XBPredicateBlock)(id obj);

@interface XBArrayDataSource : NSObject

- (id)initWithArray:(NSArray *)array;

- (id)objectAtIndexedSubscript:(NSUInteger)idx;

+ (id)dataSourceWithArray:(NSArray *)array;

- (NSUInteger)count;

@end
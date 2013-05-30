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

- (id)initWithArray:(NSArray *)array filterPredicate:(XBPredicateBlock)filterPredicate sortComparator:(NSComparator)sortComparator;

+ (id)dataSourceWithArray:(NSArray *)array filterPredicate:(XBPredicateBlock)filterPredicate sortComparator:(NSComparator)sortComparator;

+ (id)dataSourceWithArray:(NSArray *)array;

- (id)objectAtIndexedSubscript:(NSUInteger)idx;

- (NSUInteger)count;

- (void)filter:(XBPredicateBlock)filterPredicate;

- (void)sort:(NSComparator)sortComparator;

@end
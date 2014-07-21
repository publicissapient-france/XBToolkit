//
// Created by akinsella on 29/03/13.
//


#import <Foundation/Foundation.h>

typedef BOOL (^XBPredicateBlock)(id obj);

/**
 *  XBArrayDataSource provides array-like methods for accessing an ordered list of elements.
 */
@interface XBArrayDataSource : NSObject

- (instancetype)initWithArray:(NSArray *)array;

- (instancetype)initWithArray:(NSArray *)array filterPredicate:(XBPredicateBlock)filterPredicate sortComparator:(NSComparator)sortComparator;

+ (instancetype)dataSourceWithArray:(NSArray *)array filterPredicate:(XBPredicateBlock)filterPredicate sortComparator:(NSComparator)sortComparator;

+ (instancetype)dataSourceWithArray:(NSArray *)array;

- (id)objectAtIndexedSubscript:(NSUInteger)idx;

- (NSUInteger)count;

- (void)filter:(XBPredicateBlock)filterPredicate;

- (void)sort:(NSComparator)sortComparator;

- (NSArray *)array;

@end
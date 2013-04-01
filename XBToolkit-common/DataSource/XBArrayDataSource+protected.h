//
// Created by akinsella on 10/03/13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>

@interface XBArrayDataSource (protected)

@property(nonatomic, strong) NSArray *array;

- (void)filterData;
- (void)sortData;

@end
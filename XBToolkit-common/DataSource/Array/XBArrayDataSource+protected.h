//
// Created by akinsella on 10/03/13.
//


#import <Foundation/Foundation.h>

@interface XBArrayDataSource (Protected)

@property (nonatomic, strong) NSArray *sourceArray;

- (void)filterData;
- (void)sortData;

@end
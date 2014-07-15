//
// Created by akinsella on 27/03/13.
//


#import <Foundation/Foundation.h>
#import "XBArrayDataSource.h"

@protocol XBDataPager <NSObject>

- (NSUInteger)currentPage;

- (void)setCurrentPage:(NSUInteger)currentPage;

- (NSUInteger)itemsPerPage;

- (NSUInteger)totalNumberOfItems;

- (void)setTotalNumberOfItems:(NSUInteger)totalNumberOfItems;

- (void)incrementPage;

- (BOOL)hasMorePages;

- (void)resetPageIncrement;

@end

@protocol XBPaginatorFactory <NSObject>

- (id <XBDataPager>)buildWithDataSource:(XBArrayDataSource *)dataSource;

@end

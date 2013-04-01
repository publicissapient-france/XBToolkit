//
// Created by akinsella on 27/03/13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>
#import "XBArrayDataSource.h"

@protocol XBPaginator <NSObject>

- (NSUInteger)currentPage;

- (NSUInteger)itemByPage;

- (NSUInteger)totalItem;

- (void)incrementPage;

- (Boolean)hasMorePages;

- (void)resetPageIncrement;

@end

@protocol XBPaginatorFactory <NSObject>

-(NSObject<XBPaginator> *) buildWithDataSource:(XBArrayDataSource *)dataSource;

@end

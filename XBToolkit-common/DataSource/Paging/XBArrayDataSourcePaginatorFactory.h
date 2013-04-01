//
// Created by akinsella on 02/04/13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>
#import "XBPaginator.h"
#import "XBArrayDataSource.h"
#import "XBArrayDataSourcePaginator.h"

@interface XBArrayDataSourcePaginatorFactory

+ (id)paginatorWithItemByPage:(NSUInteger)itemByPage dataSource:(XBArrayDataSource *)dataSource;

- (id)initWithItemByPage:(NSUInteger)itemByPage;

-(XBArrayDataSourcePaginator *)buildWithDataSource:(XBArrayDataSource *)dataSource;

@end

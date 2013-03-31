//
// Created by akinsella on 27/03/13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>
#import "XBPaginator.h"
#import "XBArrayDataSource.h"

@interface XBArrayDataSourcePaginator : NSObject <XBPaginator>

+ (id)paginatorWithItemByPage:(NSUInteger)itemByPage dataSource:(XBArrayDataSource *)dataSource;

- (id)initWithItemByPage:(NSUInteger)itemByPage dataSource:(XBArrayDataSource *)dataSource;

@end
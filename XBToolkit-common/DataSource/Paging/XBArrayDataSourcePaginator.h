//
// Created by akinsella on 27/03/13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>
#import "XBPaginator.h"
#import "XBArrayDataSource.h"

@interface XBArrayDataSourcePaginator : NSObject<XBPaginator>

@property(nonatomic, strong)XBArrayDataSource *dataSource;

+ (id)paginatorWithItemByPage:(NSUInteger)itemByPage;

- (id)initWithItemByPage:(NSUInteger)itemByPage;

@end

@interface XBArrayDataSourcePaginatorFactory : NSObject<XBPaginatorFactory>

+ (id)paginatorWithItemByPage:(NSUInteger)itemByPage;

@end

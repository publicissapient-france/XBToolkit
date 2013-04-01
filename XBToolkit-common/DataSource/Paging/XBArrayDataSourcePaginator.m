//
// Created by akinsella on 27/03/13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "XBArrayDataSourcePaginator.h"

@interface XBArrayDataSourcePaginator()

@end

@implementation XBArrayDataSourcePaginator {
    NSUInteger _currentPage;
    NSUInteger _itemByPage;
}

+ (id)paginatorWithItemByPage:(NSUInteger)itemByPage {
    return [[self alloc] initWithItemByPage:itemByPage];
}

- (id)initWithItemByPage:(NSUInteger)itemByPage {
    self = [super init];
    if (self) {
        _itemByPage = itemByPage;
        [self resetPageIncrement];
    }

    return self;
}

- (void)setDataSource:(XBArrayDataSource *)dataSource {
    _dataSource = dataSource;
    [self resetPageIncrement];
}

- (NSUInteger)currentPage {
    return _currentPage;
}

- (NSUInteger)itemByPage {
    return _itemByPage;
}

- (NSUInteger)totalItem {
    return [self.dataSource count];
}

- (void)incrementPage {
    _currentPage++;
}

- (Boolean)hasMorePages {
    return [self totalItem] > self.currentPage * (self.itemByPage + 1);
}

- (void)resetPageIncrement {
    _currentPage = 1;
}

@end


@implementation XBArrayDataSourcePaginatorFactory {
    NSUInteger _itemByPage;
}

+ (id)paginatorWithItemByPage:(NSUInteger)itemByPage {
    return [[self alloc] initWithItemByPage:itemByPage];
}

- (id)initWithItemByPage:(NSUInteger)itemByPage {
    self = [super init];
    if (self) {
        _itemByPage = itemByPage;
    }

    return self;
}

-(XBArrayDataSourcePaginator *)buildWithDataSource:(XBArrayDataSource *)dataSource {
    XBArrayDataSourcePaginator *paginator = [XBArrayDataSourcePaginator paginatorWithItemByPage:_itemByPage];
    paginator.dataSource = dataSource;
    return paginator;
    
}

@end

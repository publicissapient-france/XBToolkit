//
// Created by akinsella on 27/03/13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "XBArrayDataSourcePaginator.h"
#import "XBArrayDataSource.h"


@implementation XBArrayDataSourcePaginator {
    NSUInteger _currentPage;
    NSUInteger _itemByPage;
    XBArrayDataSource *_dataSource;
}

+ (id)paginatorWithItemByPage:(NSUInteger)itemByPage dataSource:(XBArrayDataSource *)dataSource {
    return [[self alloc] initWithItemByPage:itemByPage dataSource:dataSource];
}

- (id)initWithItemByPage:(NSUInteger)itemByPage dataSource:(XBArrayDataSource *)dataSource {
    self = [super init];
    if (self) {
        _itemByPage = itemByPage;
        _dataSource = dataSource;
        [self resetPageIncrement];
    }

    return self;
}

- (NSUInteger)currentPage {
    return _currentPage;
}

- (NSUInteger)itemByPage {
    return _itemByPage;
}

- (NSUInteger)totalItem {
    return [_dataSource count];
}

- (void)incrementPage {
    _currentPage++;
}

- (Boolean)hasMorePages {
    return [self totalItem] > _currentPage * (_itemByPage + 1);
}

- (void)resetPageIncrement {
    _currentPage = 1;
}

@end
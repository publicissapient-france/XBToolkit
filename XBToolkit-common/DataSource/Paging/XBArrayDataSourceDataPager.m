//
// Created by akinsella on 27/03/13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "XBArrayDataSourceDataPager.h"

@interface XBArrayDataSourceDataPager ()

@property (nonatomic, assign) NSUInteger currentPage;
@property (nonatomic, assign) NSUInteger itemsPerPage;
@property (nonatomic, assign) NSInteger totalNumberOfItems;

@end

@implementation XBArrayDataSourceDataPager

- (id)initWithItemsPerPage:(NSUInteger)itemsPerPage totalNumberOfItems:(NSInteger)totalNumberOfItems
{
    self = [super init];
    if (self) {
        self.itemsPerPage = itemsPerPage;
        self.totalNumberOfItems = totalNumberOfItems;
        [self resetPageIncrement];
    }

    return self;
}

+ (instancetype)paginatorWithItemsPerPage:(NSUInteger)itemsPerPage totalNumberOfItems:(NSInteger)totalNumberOfItems
{
    return [[self alloc] initWithItemsPerPage:itemsPerPage totalNumberOfItems:totalNumberOfItems];
}

- (void)setDataSource:(XBArrayDataSource *)dataSource
{
    _dataSource = dataSource;
    [self resetPageIncrement];
}

- (void)incrementPage
{
    _currentPage++;
}

- (BOOL)hasMorePages
{
    return self.totalNumberOfItems > self.currentPage * (self.itemsPerPage + 1);
}

- (void)resetPageIncrement
{
    self.currentPage = 1;
}

@end


@implementation XBArrayDataSourcePaginatorFactory
{
    NSUInteger _itemByPage;
}

- (id)initWithItemByPage:(NSUInteger)itemByPage
{
    self = [super init];
    if (self) {
        _itemByPage = itemByPage;
    }

    return self;
}

+ (instancetype)paginatorWithItemsPerPage:(NSUInteger)itemsPerPage totalNumberOfItems:(NSInteger)totalNumberOfItems {
    return [[self alloc] initWithItemByPage:itemsPerPage];
}

- (XBArrayDataSourceDataPager *)buildWithDataSource:(XBArrayDataSource *)dataSource
{
    XBArrayDataSourceDataPager *paginator = [XBArrayDataSourceDataPager paginatorWithItemsPerPage:_itemByPage totalNumberOfItems:0];
    paginator.dataSource = dataSource;
    return paginator;
    
}

@end

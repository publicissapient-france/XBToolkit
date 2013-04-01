//
// Created by akinsella on 02/04/13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "XBArrayDataSourcePaginatorFactory.h"
#import "XBHttpJsonDataLoader.h"


@implementation XBArrayDataSourcePaginatorFactory {
    NSUInteger _itemByPage;
}

+ (id)factoryWithItemByPage:(NSUInteger)itemByPage {
    return [[self alloc] initWithHttpClient:<#(XBHttpClient *)httpClient#> httpQueryParamBuilder:<#(NSObject<XBHttpQueryParamBuilder> *)httpQueryParamBuilder#> resourcePath:<#(NSString *)resourcePath#>]
}

- (id)initWithItemByPage:(NSUInteger)itemByPage {
    self = [super init];
    if (self) {
        _itemByPage = itemByPage;
    }

    return self;
}

-(XBArrayDataSourcePaginator *)buildWithDataSource:(XBArrayDataSource *)dataSource {
    return [XBArrayDataSourcePaginator paginatorWithItemByPage:_itemByPage dataSource:dataSource];
}

@end

//
// Created by akinsella on 27/03/13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>
#import "XBDataPager.h"
#import "XBArrayDataSource.h"

static const NSInteger XBArrayDataSourceDataPagerUnlimited = NSIntegerMax;

@interface XBArrayDataSourceDataPager : NSObject<XBDataPager>

@property (nonatomic, strong) XBArrayDataSource *dataSource;

- (id)initWithItemsPerPage:(NSUInteger)itemsPerPage totalNumberOfItems:(NSInteger)totalNumberOfItems;

+ (instancetype)paginatorWithItemsPerPage:(NSUInteger)itemsPerPage totalNumberOfItems:(NSInteger)totalNumberOfItems;

@end

@interface XBArrayDataSourcePaginatorFactory : NSObject<XBPaginatorFactory>

+ (instancetype)paginatorWithItemsPerPage:(NSUInteger)itemsPerPage totalNumberOfItems:(NSInteger)totalNumberOfItems;

@end

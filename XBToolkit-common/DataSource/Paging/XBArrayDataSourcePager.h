//
// Created by akinsella on 27/03/13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>
#import "XBDataPager.h"
#import "XBArrayDataSource.h"

static const NSUInteger XBArrayDataSourceDataPagerUnlimited = NSUIntegerMax;

@interface XBArrayDataSourcePager : NSObject<XBDataPager>

@property (nonatomic, strong) XBArrayDataSource *dataSource;

- (id)initWithItemsPerPage:(NSUInteger)itemsPerPage totalNumberOfItems:(NSUInteger)totalNumberOfItems;

+ (instancetype)pagerWithItemsPerPage:(NSUInteger)itemsPerPage totalNumberOfItems:(NSUInteger)totalNumberOfItems;

@end

@interface XBArrayDataSourcePaginatorFactory : NSObject<XBPaginatorFactory>

+ (instancetype)pagerWithItemsPerPage:(NSUInteger)itemsPerPage totalNumberOfItems:(NSUInteger)totalNumberOfItems;

@end

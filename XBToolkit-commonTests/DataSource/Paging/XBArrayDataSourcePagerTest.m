//
// Created by Simone Civetta on 14/12/13.
// Copyright (c) 2013 Xebia. All rights reserved.
//

#import "GHAsyncTestCase.h"
#import "XBArrayDataSourcePager.h"

@interface XBArrayDataSourcePagerTest : GHTestCase @end

@implementation XBArrayDataSourcePagerTest

- (void)testPager
{
    XBArrayDataSourcePager *pager = [XBArrayDataSourcePager pagerWithItemsPerPage:10 totalNumberOfItems:100];
    [pager resetPageIncrement];
    GHAssertTrue([pager hasMorePages], nil);
}

- (void)testPageIncrement
{
    XBArrayDataSourcePager *pager = [XBArrayDataSourcePager pagerWithItemsPerPage:10 totalNumberOfItems:30];
    [pager resetPageIncrement];

    [pager incrementPage]; // Page = 2
    GHAssertTrue([pager hasMorePages], nil);

    [pager incrementPage]; // Page = 3
    GHAssertFalse([pager hasMorePages], nil);
}

- (void)testPagerWithUnevenIncrement
{
    XBArrayDataSourcePager *pager = [XBArrayDataSourcePager pagerWithItemsPerPage:10 totalNumberOfItems:15];
    [pager resetPageIncrement];

    [pager incrementPage]; // Page = 2
    GHAssertFalse([pager hasMorePages], nil);
}

- (void)testPagerWithSmallerIncrement
{
    XBArrayDataSourcePager *pager = [XBArrayDataSourcePager pagerWithItemsPerPage:9 totalNumberOfItems:10];
    [pager resetPageIncrement];

    [pager incrementPage]; // Page = 2
    GHAssertFalse([pager hasMorePages], nil);
}

@end
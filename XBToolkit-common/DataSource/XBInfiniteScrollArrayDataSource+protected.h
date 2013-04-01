//
// Created by akinsella on 29/03/13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>
#import "XBInfiniteScrollArrayDataSource.h"

@interface XBInfiniteScrollArrayDataSource (XBPagedHttpArrayDataSource_protected)

-(void)setPaginator:(NSObject<XBPaginator> *)paginator;

@end
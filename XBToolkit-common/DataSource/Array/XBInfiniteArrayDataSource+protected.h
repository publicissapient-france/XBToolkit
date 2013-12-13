//
// Created by akinsella on 29/03/13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>
#import "XBInfiniteArrayDataSource.h"

@interface XBInfiniteArrayDataSource (XBPagedHttpArrayDataSource_protected)

-(void)setDataPager:(NSObject<XBDataPager> *)dataPager;

@end
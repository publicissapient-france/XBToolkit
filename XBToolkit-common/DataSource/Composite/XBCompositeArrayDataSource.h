//
// Created by akinsella on 25/03/13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>
#import "XBArrayDataSource.h"
#import "XBLoadableArrayDataSource.h"

@interface XBCompositeArrayDataSource : XBLoadableArrayDataSource

- (id)initWithFirstDataSource:(XBLoadableArrayDataSource *)firstDataSource
             secondDataSource:(XBLoadableArrayDataSource *)secondDataSource;

+ (id)dataSourceWithFirstDataSource:(XBLoadableArrayDataSource *)firstDataSource
                   secondDataSource:(XBLoadableArrayDataSource *)secondDataSource;

@end
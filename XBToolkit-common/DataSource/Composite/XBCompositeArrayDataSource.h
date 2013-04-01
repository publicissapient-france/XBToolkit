//
// Created by akinsella on 25/03/13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>
#import "XBArrayDataSource.h"
#import "XBReloadableArrayDataSource.h"

@interface XBCompositeArrayDataSource : XBReloadableArrayDataSource

- (id)initWithFirstDataSource:(XBReloadableArrayDataSource *)firstDataSource
             secondDataSource:(XBReloadableArrayDataSource *)secondDataSource;

+ (id)dataSourceWithFirstDataSource:(XBReloadableArrayDataSource *)firstDataSource
                   secondDataSource:(XBReloadableArrayDataSource *)secondDataSource;

@end
//
// Created by akinsella on 25/03/13.
//


#import <Foundation/Foundation.h>
#import "XBArrayDataSource.h"
#import "XBReloadableArrayDataSource.h"


@interface XBCompositeArrayDataSource : XBReloadableArrayDataSource

- (instancetype)initWithFirstDataSource:(XBReloadableArrayDataSource *)firstDataSource
                       secondDataSource:(XBReloadableArrayDataSource *)secondDataSource;

+ (instancetype)dataSourceWithFirstDataSource:(XBReloadableArrayDataSource *)firstDataSource
                             secondDataSource:(XBReloadableArrayDataSource *)secondDataSource;

@end
//
// Created by akinsella on 27/03/13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>
#import "XBCompositeArrayDataSource.h"

@interface XBCompositeArrayDataSource (XBCompositeArrayDataSource_protected)

@property(nonatomic, strong) XBReloadableArrayDataSource * firstDataSource;
@property(nonatomic, strong) XBReloadableArrayDataSource * secondDataSource;

@end

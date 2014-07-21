//
// Created by akinsella on 27/03/13.
//


#import <Foundation/Foundation.h>
#import "XBCompositeArrayDataSource.h"


@interface XBCompositeArrayDataSource (Protected)

@property (nonatomic, strong) XBReloadableArrayDataSource * firstDataSource;

@property (nonatomic, strong) XBReloadableArrayDataSource * secondDataSource;

@end

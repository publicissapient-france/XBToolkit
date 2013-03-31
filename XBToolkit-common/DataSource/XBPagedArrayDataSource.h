//
// Created by akinsella on 26/03/13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>
#import "XBArrayDataSource.h"

@protocol XBPagedArrayDataSource<NSObject>

@required

- (void)loadNextPageWithCallback:(void(^)())callback;

- (BOOL)hasMorePages;

@end
//
// Created by akinsella on 01/04/13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>

@protocol XBDataMerger <NSObject>

@required

- (id)mergeDataOfSource:(id)dataSource1 withSource:(id)dataSource2;

@end
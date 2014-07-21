//
// Created by akinsella on 01/04/13.
//


#import <Foundation/Foundation.h>

@protocol XBDataMerger <NSObject>

@required

- (id)mergeDataOfSource:(id)dataSource1 withSource:(id)dataSource2;

@end
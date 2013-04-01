//
// Created by akinsella on 01/04/13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>

@protocol XBDataMerger <NSObject>

@required
-(id)mergeDataFromSource:(id)srcData toDest:(id)destData;

@end
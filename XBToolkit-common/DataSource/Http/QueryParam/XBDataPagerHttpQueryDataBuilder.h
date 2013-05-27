//
// Created by akinsella on 02/04/13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>
#import "XBHttpQueryParamBuilder.h"
#import "XBDataPager.h"

@interface XBDataPagerHttpQueryDataBuilder : NSObject<XBHttpQueryParamBuilder>
- (id)initWithPaginator:(NSObject <XBDataPager> *)paginator pageParameterName:(NSString *)pageParameterName;

+ (id)builderWithDataPager:(NSObject <XBDataPager> *)paginator pageParameterName:(NSString *)pageParameterName;


@end
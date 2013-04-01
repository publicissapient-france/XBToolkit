//
// Created by akinsella on 02/04/13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>
#import "XBHttpQueryParamBuilder.h"
#import "XBPaginator.h"

@interface XBPaginatorHttpQueryDataBuilder : NSObject<XBHttpQueryParamBuilder>
- (id)initWithPaginator:(NSObject <XBPaginator> *)paginator pageParameterName:(NSString *)pageParameterName;

+ (id)builderWithPaginator:(NSObject <XBPaginator> *)paginator pageParameterName:(NSString *)pageParameterName;


@end
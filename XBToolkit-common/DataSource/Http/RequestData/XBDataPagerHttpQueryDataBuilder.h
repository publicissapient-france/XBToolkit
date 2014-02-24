//
// Created by akinsella on 02/04/13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>
#import "XBHttpRequestDataBuilder.h"
#import "XBDataPager.h"

@interface XBDataPagerHttpQueryDataBuilder : NSObject<XBHttpRequestDataBuilder>

@property (nonatomic, strong) id <XBDataPager> paginator;
@property (nonatomic, strong) NSString *pageParameterName;

- (id)initWithPager:(id <XBDataPager>)pager pageParameterName:(NSString *)pageParameterName;
+ (instancetype)builderWithDataPager:(id <XBDataPager>)pager pageParameterName:(NSString *)pageParameterName;

@end
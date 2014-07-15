//
// Created by akinsella on 02/04/13.
//


#import <Foundation/Foundation.h>
#import "XBHttpRequestDataBuilder.h"
#import "XBDataPager.h"


@interface XBDataPagerHttpQueryDataBuilder : NSObject<XBHttpRequestDataBuilder>

@property (nonatomic, strong) id <XBDataPager> paginator;
@property (nonatomic, strong) NSString *pageParameterName;

- (instancetype)initWithPager:(id <XBDataPager>)pager pageParameterName:(NSString *)pageParameterName;
+ (instancetype)builderWithDataPager:(id <XBDataPager>)pager pageParameterName:(NSString *)pageParameterName;

@end
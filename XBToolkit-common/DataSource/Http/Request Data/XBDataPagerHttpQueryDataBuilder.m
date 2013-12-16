//
// Created by akinsella on 02/04/13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "XBDataPagerHttpQueryDataBuilder.h"
#import "XBDataPager.h"

@implementation XBDataPagerHttpQueryDataBuilder

- (id)initWithPager:(id <XBDataPager>)pager pageParameterName:(NSString *)pageParameterName
{
    self = [super init];
    if (self) {
        self.paginator = pager;
        self.pageParameterName = pageParameterName;
    }

    return self;
}

+ (instancetype)builderWithDataPager:(id <XBDataPager>)pager pageParameterName:(NSString *)pageParameterName
{
    return [[self alloc] initWithPager:pager pageParameterName:pageParameterName];
}

- (NSDictionary *)build
{
    return @{ self.pageParameterName : [NSNumber numberWithUnsignedInteger:self.paginator.currentPage] };
}


@end
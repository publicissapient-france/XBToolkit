//
// Created by akinsella on 02/04/13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "XBDataPagerHttpQueryDataBuilder.h"
#import "XBDataPager.h"

@implementation XBDataPagerHttpQueryDataBuilder

- (id)initWithPaginator:(id <XBDataPager>)paginator pageParameterName:(NSString *)pageParameterName
{
    self = [super init];
    if (self) {
        self.paginator = paginator;
        self.pageParameterName = pageParameterName;
    }

    return self;
}

+ (instancetype)builderWithDataPager:(id <XBDataPager>)paginator pageParameterName:(NSString *)pageParameterName
{
    return [[self alloc] initWithPaginator:paginator pageParameterName:pageParameterName];
}

- (NSDictionary *)build
{
    return @{ self.pageParameterName : [NSNumber numberWithUnsignedInteger:self.paginator.currentPage] };
}


@end
//
// Created by akinsella on 02/04/13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "XBDataPagerHttpQueryDataBuilder.h"
#import "XBDataPager.h"

@interface XBDataPagerHttpQueryDataBuilder ()

@property(nonatomic, strong) NSObject<XBDataPager> *paginator;
@property(nonatomic, strong) NSString *pageParameterName;

@end

@implementation XBDataPagerHttpQueryDataBuilder

+ (id)builderWithDataPager:(NSObject <XBDataPager> *)paginator pageParameterName:(NSString *)pageParameterName {
    return [[self alloc] initWithPaginator:paginator pageParameterName:pageParameterName];
}

- (id)initWithPaginator:(NSObject <XBDataPager> *)paginator pageParameterName:(NSString *)pageParameterName {
    self = [super init];
    if (self) {
        self.paginator = paginator;
        self.pageParameterName = pageParameterName;
    }

    return self;
}

- (NSDictionary *)build {
    return @{ self.pageParameterName : [NSNumber numberWithUnsignedInteger:self.paginator.currentPage] };
}


@end
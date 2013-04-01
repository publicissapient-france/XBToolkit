//
// Created by akinsella on 02/04/13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "XBPaginatorHttpQueryDataBuilder.h"
#import "XBPaginator.h"

@interface XBPaginatorHttpQueryDataBuilder()

@property(nonatomic, strong) NSObject<XBPaginator> *paginator;
@property(nonatomic, strong) NSString *pageParameterName;

@end

@implementation XBPaginatorHttpQueryDataBuilder

+ (id)builderWithPaginator:(NSObject <XBPaginator> *)paginator pageParameterName:(NSString *)pageParameterName {
    return [[self alloc] initWithPaginator:paginator pageParameterName:pageParameterName];
}

- (id)initWithPaginator:(NSObject <XBPaginator> *)paginator pageParameterName:(NSString *)pageParameterName {
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
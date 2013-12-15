//
// Created by akinsella on 02/04/13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>
#import "XBHTTPRequestDataBuilder.h"
#import "XBDataPager.h"

@interface XBDataPagerHttpQueryDataBuilder : NSObject<XBHTTPRequestDataBuilder>

@property (nonatomic, strong) id <XBDataPager> paginator;
@property (nonatomic, strong) NSString *pageParameterName;

- (id)initWithPaginator:(id <XBDataPager>)paginator pageParameterName:(NSString *)pageParameterName;
+ (instancetype)builderWithDataPager:(id <XBDataPager>)paginator pageParameterName:(NSString *)pageParameterName;

@end
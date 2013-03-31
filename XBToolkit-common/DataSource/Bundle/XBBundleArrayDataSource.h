//
// Created by akinsella on 25/03/13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>
#import "XBArrayDataSource.h"
#import "XBBundleArrayDataSourceConfiguration.h"
#import "XBLoadableArrayDataSource.h"

@interface XBBundleArrayDataSource : XBLoadableArrayDataSource

@property (nonatomic, strong, readonly)NSString *resourcePath;
@property (nonatomic, strong, readonly)NSString *resourceType;

+ (XBBundleArrayDataSource *)dataSourceWithConfiguration:(XBBundleArrayDataSourceConfiguration *)configuration;
- (id)initWithConfiguration:(XBBundleArrayDataSourceConfiguration *)configuration;

@end
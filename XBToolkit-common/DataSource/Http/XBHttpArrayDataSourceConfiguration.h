//
// Created by akinsella on 24/03/13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>
#import "XBHttpQueryParamBuilder.h"
#import "XBCache.h"
#import "XBPaginator.h"

@interface XBHttpArrayDataSourceConfiguration : NSObject

@property(nonatomic, strong) Class typeClass;
@property(nonatomic, strong) NSDateFormatter *dateFormat;
@property(nonatomic, strong) NSString *storageFileName;
@property(nonatomic, assign) NSInteger maxDataAgeInSecondsBeforeServerFetch;
@property(nonatomic, strong) NSString *resourcePath;
@property(nonatomic, strong) NSString *rootKeyPath;
@property(nonatomic, strong) NSObject<XBHttpQueryParamBuilder> *httpQueryParamBuilder;
@property(nonatomic, strong) NSObject<XBCache> *cache;
@property(nonatomic, strong) NSObject<XBPaginator> *paginator;

+ (XBHttpArrayDataSourceConfiguration *)configuration;

+ (XBHttpArrayDataSourceConfiguration *)configurationWithResourcePath:(NSString *)string
                                                      storageFileName:(NSString *)name
                                                            typeClass:(Class)class
                                                          rootKeyPath:(NSString *)rootKeyPath;

@end
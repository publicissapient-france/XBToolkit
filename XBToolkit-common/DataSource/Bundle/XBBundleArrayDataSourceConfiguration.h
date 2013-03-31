//
// Created by akinsella on 25/03/13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>


@interface XBBundleArrayDataSourceConfiguration : NSObject

@property(nonatomic, strong) Class typeClass;
@property(nonatomic, strong) NSString *resourcePath;
@property(nonatomic, strong) NSString *resourceType;
@property(nonatomic, strong) NSString *rootKeyPath;

+ (XBBundleArrayDataSourceConfiguration *)configuration;

+ (XBBundleArrayDataSourceConfiguration *)configurationWithResourcePath:(NSString *)resourcePath
                                                           resourceType:(NSString *)resourceType
                                                              typeClass:(Class)typeClass
                                                            rootKeyPath:(NSString *)rootKeyPath;

+ (XBBundleArrayDataSourceConfiguration *)configurationWithResourcePath:(NSString *)resourcePath
                                                           resourceType:(NSString *)resourceType
                                                              typeClass:(Class)typeClass;

@end
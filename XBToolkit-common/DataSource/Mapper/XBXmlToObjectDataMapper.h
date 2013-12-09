//
// Created by Simone Civetta on 5/30/13.
// Copyright (c) 2013 Xebia. All rights reserved.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>
#import "XBDataMapper.h"


@interface XBXmlToObjectDataMapper : NSObject<XBDataMapper>

@property(nonatomic, strong, readonly) NSString *rootXPath;

- (id)initWithRootXPath:(NSString *)rootXPath typeClass:(Class)typeClass;

+ (instancetype)mapperWithRootXPath:(NSString *)rootXPath typeClass:(Class)typeClass;

@end
//
// Created by Simone Civetta on 5/30/13.
// Copyright (c) 2013 Xebia. All rights reserved.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>
#import "XBDataMapper.h"
#import "AFURLResponseSerialization.h"


@interface XBJsonToObjectDataMapper : AFJSONResponseSerializer<AFURLResponseSerialization, XBDataMapper>

@property (nonatomic, strong, readonly)NSString *rootKeyPath;

- (id)initWithRootKeyPath:(NSString *)rootKeyPath typeClass:(Class)typeClass;

+ (instancetype)mapperWithRootKeyPath:(NSString *)rootKeyPath typeClass:(Class)typeClass;

@end
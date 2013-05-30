//
// Created by Simone Civetta on 5/30/13.
// Copyright (c) 2013 Xebia. All rights reserved.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>
#import "XBDataMapper.h"


@interface XBJsonToObjectDataMapper : NSObject<XBDataMapper>

@property (nonatomic, strong, readonly)NSString *rootKeyPath;

- (id)initWithRootKeyPath:(NSString *)rootKeyPath typeClass:(Class)typeClass;

+ (id)mapperWithRootKeyPath:(NSString *)rootKeyPath typeClass:(Class)typeClass;

@end
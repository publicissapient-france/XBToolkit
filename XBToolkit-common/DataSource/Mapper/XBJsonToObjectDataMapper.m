//
// Created by Simone Civetta on 5/30/13.
// Copyright (c) 2013 Xebia. All rights reserved.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "XBJsonToObjectDataMapper.h"
#import "XBMapper.h"

@interface XBJsonToObjectDataMapper()

@property (nonatomic, weak)Class typeClass;
@property (nonatomic, strong)NSString *rootKeyPath;

@end

@implementation XBJsonToObjectDataMapper

+ (id)mapperWithRootKeyPath:(NSString *)rootKeyPath typeClass:(Class)typeClass {
    return [[self alloc] initWithRootKeyPath:rootKeyPath typeClass:typeClass];
}

- (id)initWithRootKeyPath:(NSString *)rootKeyPath typeClass:(Class)typeClass {
    self = [super init];
    if (self) {
        _rootKeyPath = rootKeyPath;
        _typeClass = typeClass;
    }

    return self;
}

- (id)mapData:(id)data {
    id object = self.rootKeyPath ? [data valueForKeyPath:self.rootKeyPath] : data;
    return [XBMapper parseObject:object intoObjectOfType:self.typeClass];
}

@end
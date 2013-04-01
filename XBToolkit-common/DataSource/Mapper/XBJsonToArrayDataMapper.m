//
// Created by akinsella on 31/03/13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "XBJsonToArrayDataMapper.h"
#import "XBMapper.h"

@interface XBJsonToArrayDataMapper()

@property (nonatomic, weak)Class typeClass;
@property (nonatomic, strong)NSString *rootKeyPath;

@end

@implementation XBJsonToArrayDataMapper

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
    NSArray *array = self.rootKeyPath ? [data valueForKeyPath:self.rootKeyPath] : data;
    return [XBMapper parseArray:array intoObjectsOfType:self.typeClass];
}

@end
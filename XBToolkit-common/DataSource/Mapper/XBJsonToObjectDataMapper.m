//
// Created by Simone Civetta on 5/30/13.
// Copyright (c) 2013 Xebia. All rights reserved.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "XBJsonToObjectDataMapper.h"
#import "XBModel.h"
#import <Mantle/NSValueTransformer+MTLPredefinedTransformerAdditions.h>

@interface XBJsonToObjectDataMapper()

@property (nonatomic, weak)Class typeClass;
@property (nonatomic, strong)NSString *rootKeyPath;

@end

@implementation XBJsonToObjectDataMapper

+ (id)mapperWithRootKeyPath:(NSString *)rootKeyPath typeClass:(Class)typeClass
{
    return [[self alloc] initWithRootKeyPath:rootKeyPath typeClass:typeClass];
}

- (id)initWithRootKeyPath:(NSString *)rootKeyPath typeClass:(Class)typeClass
{
    self = [super init];
    if (self) {
        _rootKeyPath = rootKeyPath;
        _typeClass = typeClass;
    }

    return self;
}

- (void)mapData:(id)data withCompletionCallback:(XBDataMapperCompletionCallback)callback
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{

        id object = self.rootKeyPath ? [data valueForKeyPath:self.rootKeyPath] : data;
        
        if (![self.typeClass isSubclassOfClass:[XBModel class]]) {
            [NSException raise:NSInvalidArgumentException format:@"objectClass %@ is not subclass of XBModel", NSStringFromClass(self.typeClass)];
        }
        
        NSValueTransformer *valueTransformer = [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:self.typeClass];
        id mappedData = [valueTransformer transformedValue:object];

        dispatch_async(dispatch_get_main_queue(), ^{
            if (callback) {
                callback(mappedData);
            }
        });
    });
}

@end
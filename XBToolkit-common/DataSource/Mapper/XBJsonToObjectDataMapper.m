//
// Created by Simone Civetta on 5/30/13.
// Copyright (c) 2013 Xebia. All rights reserved.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "XBJsonToObjectDataMapper.h"
#import <Mantle/Mantle.h>
#import <Mantle/NSValueTransformer+MTLPredefinedTransformerAdditions.h>

@interface XBJsonToObjectDataMapper()

@property (nonatomic, weak) Class typeClass;
@property (nonatomic, strong) NSString *rootKeyPath;

@end

@implementation XBJsonToObjectDataMapper

- (id)initWithRootKeyPath:(NSString *)rootKeyPath typeClass:(Class)typeClass
{
    self = [super init];
    if (self) {
        self.rootKeyPath = rootKeyPath;
        self.typeClass = typeClass;
    }

    return self;
}

+ (instancetype)mapperWithRootKeyPath:(NSString *)rootKeyPath typeClass:(Class)typeClass
{
    return [[self alloc] initWithRootKeyPath:rootKeyPath typeClass:typeClass];
}

- (id)mappedObjectFromData:(id)data error:(NSError * __autoreleasing *)error;
{
    id object = self.rootKeyPath ? [data valueForKeyPath:self.rootKeyPath] : data;

    if (![self.typeClass isSubclassOfClass:[MTLModel class]]) {
        [NSException raise:NSInvalidArgumentException format:@"objectClass %@ is not subclass of MTLModel", NSStringFromClass(self.typeClass)];
    }

    NSValueTransformer *valueTransformer = [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:self.typeClass];
    id mappedData = [valueTransformer transformedValue:object];

    return mappedData;
}

- (id)responseObjectForResponse:(NSURLResponse *)response
                           data:(NSData *)data
                          error:(NSError *__autoreleasing *)error
{
    id dictionary = [super responseObjectForResponse:response data:data error:error];
    return [self mappedObjectFromData:dictionary error:nil];
}

@end
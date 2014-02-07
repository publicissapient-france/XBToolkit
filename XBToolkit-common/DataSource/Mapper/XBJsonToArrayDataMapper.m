//
// Created by akinsella on 31/03/13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "XBJsonToArrayDataMapper.h"
#import <Mantle/Mantle.h>
#import <Mantle/NSValueTransformer+MTLPredefinedTransformerAdditions.h>

@interface XBJsonToArrayDataMapper()

@property (nonatomic, weak)Class typeClass;
@property (nonatomic, strong)NSString *rootKeyPath;

@end

@implementation XBJsonToArrayDataMapper

- (id)initWithRootKeyPath:(NSString *)rootKeyPath typeClass:(Class)typeClass
{
    self = [super init];
    if (self) {
        _rootKeyPath = rootKeyPath;
        _typeClass = typeClass;
    }
    
    return self;
}

+ (instancetype)mapperWithRootKeyPath:(NSString *)rootKeyPath typeClass:(Class)typeClass
{
    return [[self alloc] initWithRootKeyPath:rootKeyPath typeClass:typeClass];
}

- (id)mappedObjectFromData:(id)data error:(NSError * __autoreleasing *)error;
{
    id json = [NSJSONSerialization JSONObjectWithData:data options:0 error:error];
    NSArray *array = self.rootKeyPath ? [json valueForKeyPath:self.rootKeyPath] : json;

    id mappedObject = nil;
    if ([array isKindOfClass:[NSArray class]]) {

//        if (![self.typeClass isSubclassOfClass:[MTLModel class]]) {
//            [NSException raise:NSInvalidArgumentException format:@"objectClass %@ is not subclass of MTLModel", NSStringFromClass(self.typeClass)];
//        }

        NSValueTransformer *valueTransformer = [NSValueTransformer mtl_JSONArrayTransformerWithModelClass:self.typeClass];
        mappedObject = [valueTransformer transformedValue:array];
    }

    return mappedObject;
}

- (id)responseObjectForResponse:(NSURLResponse *)response
                           data:(NSData *)data
                          error:(NSError *__autoreleasing *)error
{
    id array = [super responseObjectForResponse:response data:data error:error];
    return [self mappedObjectFromData:array error:nil];
}

@end
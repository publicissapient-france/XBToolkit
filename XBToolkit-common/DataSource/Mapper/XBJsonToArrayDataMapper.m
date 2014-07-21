//
// Created by akinsella on 31/03/13.
//


#import "XBJsonToArrayDataMapper.h"
#import <Mantle/Mantle.h>
#import <Mantle/NSValueTransformer+MTLPredefinedTransformerAdditions.h>

@interface XBJsonToArrayDataMapper()

@property (nonatomic, unsafe_unretained) Class typeClass;
@property (nonatomic, strong) NSString *rootKeyPath;

@end


@implementation XBJsonToArrayDataMapper

- (instancetype)initWithRootKeyPath:(NSString *)rootKeyPath typeClass:(Class)typeClass
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
    NSArray *array = self.rootKeyPath ? [data valueForKeyPath:self.rootKeyPath] : data;

    id mappedObject = nil;
    if ([array isKindOfClass:[NSArray class]]) {
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
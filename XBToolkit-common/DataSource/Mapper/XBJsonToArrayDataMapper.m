//
// Created by akinsella on 31/03/13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "XBJsonToArrayDataMapper.h"
#import "XBModel.h"
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

- (void)mapData:(id)data withCompletionCallback:(XBDataMapperCompletionCallback)callback
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSArray *array = self.rootKeyPath ? [data valueForKeyPath:self.rootKeyPath] : data;

        id mappedData = nil;
        if ([array isKindOfClass:[NSArray class]]) {
            
            if (![self.typeClass isSubclassOfClass:[XBModel class]]) {
                [NSException raise:NSInvalidArgumentException format:@"objectClass %@ is not subclass of XBModel", NSStringFromClass(self.typeClass)];
            }
            
            NSValueTransformer *valueTransformer = [NSValueTransformer mtl_JSONArrayTransformerWithModelClass:self.typeClass];
            mappedData = [valueTransformer transformedValue:array];
        }

        dispatch_async(dispatch_get_main_queue(), ^{
            if (callback) {
                callback(mappedData);
            }
        });
    });
}

@end
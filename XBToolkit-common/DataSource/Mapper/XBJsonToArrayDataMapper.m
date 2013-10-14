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
        NSArray *array = self.rootKeyPath ? [data valueForKeyPath:self.rootKeyPath] : data;

        id mappedData = nil;
        if ([array isKindOfClass:[NSArray class]]) {
            mappedData = [XBMapper parseArray:array intoObjectsOfType:self.typeClass];
        }

        dispatch_async(dispatch_get_main_queue(), ^{
            if (callback) {
                callback(mappedData);
            }
        });
    });
}

@end
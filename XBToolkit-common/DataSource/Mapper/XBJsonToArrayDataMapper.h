//
// Created by akinsella on 31/03/13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>
#import "XBDataMapper.h"

@interface XBJsonToArrayDataMapper : NSObject<XBDataMapper>

@property (nonatomic, strong, readonly)NSString *rootKeyPath;

- (id)initWithRootKeyPath:(NSString *)rootKeyPath typeClass:(Class)typeClass;

+ (id)mapperWithRootKeyPath:(NSString *)rootKeyPath typeClass:(Class)typeClass;


@end
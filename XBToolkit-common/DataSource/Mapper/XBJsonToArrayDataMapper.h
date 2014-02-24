//
// Created by akinsella on 31/03/13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>
#import "XBDataMapper.h"
#import "AFURLResponseSerialization.h"

#warning Should not probably subclass AFJSONResponseSerializer but rather another class
@interface XBJsonToArrayDataMapper : AFJSONResponseSerializer<AFURLResponseSerialization, XBDataMapper>

@property (nonatomic, strong, readonly)NSString *rootKeyPath;

- (id)initWithRootKeyPath:(NSString *)rootKeyPath typeClass:(Class)typeClass;

+ (instancetype)mapperWithRootKeyPath:(NSString *)rootKeyPath typeClass:(Class)typeClass;

@end
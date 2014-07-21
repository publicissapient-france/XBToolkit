//
// Created by akinsella on 31/03/13.
//


#import <Foundation/Foundation.h>
#import "XBDataMapper.h"
#import "AFURLResponseSerialization.h"

/**
 *  Converts a JSON array to a NSArray.
 */
@interface XBJsonToArrayDataMapper : AFJSONResponseSerializer<AFURLResponseSerialization, XBDataMapper>

/**
 *  the keyPath of the representation object that will be deserialized
 */
@property (nonatomic, strong, readonly) NSString *rootKeyPath;

/**
 *  Create a new instance of XBJsonToArrayDataMapper
 *
 *  @param rootKeyPath the keyPath of the representation object that will be deserialized
 *  @param typeClass   the class of the elements contained in the NSArray that will be created as a result of the deserialization
 *
 *  @return A new instance of XBJsonToArrayDataMapper
 */
- (instancetype)initWithRootKeyPath:(NSString *)rootKeyPath typeClass:(Class)typeClass;

/**
 *  Create a new instance of XBJsonToArrayDataMapper
 *
 *  @param rootKeyPath the keyPath of the representation object that will be deserialized
 *  @param typeClass   the class of the elements contained in the NSArray that will be created as a result of the deserialization
 *
 *  @return A new instance of XBJsonToArrayDataMapper
 */
+ (instancetype)mapperWithRootKeyPath:(NSString *)rootKeyPath typeClass:(Class)typeClass;

@end
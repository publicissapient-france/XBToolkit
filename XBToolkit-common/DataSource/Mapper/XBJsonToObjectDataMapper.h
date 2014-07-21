//
// Created by Simone Civetta on 5/30/13.
// Copyright (c) 2013 Xebia. All rights reserved.
//


#import <Foundation/Foundation.h>
#import "XBDataMapper.h"
#import "AFURLResponseSerialization.h"

/**
 *  Convert a JSON object to an instance of the desired class.
 */
@interface XBJsonToObjectDataMapper : AFJSONResponseSerializer<AFURLResponseSerialization, XBDataMapper>

/**
 *  the keyPath of the representation object that will be deserialized
 */
@property (nonatomic, strong, readonly) NSString *rootKeyPath;

/**
 *  Create a new instance of XBJsonToObjectDataMapper
 *
 *  @param rootKeyPath the keyPath of the representation object that will be deserialized
 *  @param typeClass   the class of the instance that will be created as a result of the deserialization
 *
 *  @return A new instance of XBJsonToObjectDataMapper
 */
- (instancetype)initWithRootKeyPath:(NSString *)rootKeyPath typeClass:(Class)typeClass;

/**
 *  Create a new instance of XBJsonToObjectDataMapper
 *
 *  @param rootKeyPath the keyPath of the representation object that will be deserialized
 *  @param typeClass   the class of the instance that will be created as a result of the deserialization
 *
 *  @return A new instance of XBJsonToObjectDataMapper
 */
+ (instancetype)mapperWithRootKeyPath:(NSString *)rootKeyPath typeClass:(Class)typeClass;

@end
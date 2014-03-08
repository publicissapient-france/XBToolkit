//
// Created by akinsella on 31/03/13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>
#import "XBDataLoader.h"
#import "XBHttpRequestDataBuilder.h"

@class XBJsonToObjectDataMapper;
@class AFJSONResponseSerializer;

@protocol AFURLResponseSerialization;
@protocol XBDataMapper;

@interface XBBundleJsonDataLoader : NSObject<XBDataLoader>

- (instancetype)initWithResourcePath:(NSString *)resourcePath resourceType:(NSString *)resourceType;

- (instancetype)initWithResourcePath:(NSString *)resourcePath resourceType:(NSString *)resourceType dataMapper:(AFJSONResponseSerializer<AFURLResponseSerialization, XBDataMapper> *)dataMapper;

+ (instancetype)dataLoaderWithResourcePath:(NSString *)resourcePath resourceType:(NSString *)resourceType;

+ (instancetype)dataLoaderWithResourcePath:(NSString *)resourcePath resourceType:(NSString *)resourceType dataMapper:(AFJSONResponseSerializer<AFURLResponseSerialization, XBDataMapper> *)dataMapper;

@property (nonatomic, assign) NSJSONReadingOptions readingOptions;

@end
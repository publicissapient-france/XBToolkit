//
// Created by akinsella on 31/03/13.
//


#import <Foundation/Foundation.h>
#import "XBDataLoader.h"
#import "XBHttpRequestDataBuilder.h"


@class XBJsonToObjectDataMapper;
@class AFJSONResponseSerializer;
@protocol AFURLResponseSerialization;
@protocol XBDataMapper;


@interface XBBundleJsonDataLoader : NSObject<XBDataLoader>

@property (nonatomic, assign) NSJSONReadingOptions readingOptions;

- (instancetype)initWithResourcePath:(NSString *)resourcePath resourceType:(NSString *)resourceType;

- (instancetype)initWithResourcePath:(NSString *)resourcePath resourceType:(NSString *)resourceType dataMapper:(AFJSONResponseSerializer<AFURLResponseSerialization, XBDataMapper> *)dataMapper;

+ (instancetype)dataLoaderWithResourcePath:(NSString *)resourcePath resourceType:(NSString *)resourceType;

+ (instancetype)dataLoaderWithResourcePath:(NSString *)resourcePath resourceType:(NSString *)resourceType dataMapper:(AFJSONResponseSerializer<AFURLResponseSerialization, XBDataMapper> *)dataMapper;

@end
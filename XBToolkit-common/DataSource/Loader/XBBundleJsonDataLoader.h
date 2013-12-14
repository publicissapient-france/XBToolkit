//
// Created by akinsella on 31/03/13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>
#import "XBDataLoader.h"
#import "XBHTTPClient.h"
#import "XBHTTPRequestDataBuilder.h"

#warning Should create class for mapping data as well
@interface XBBundleJsonDataLoader : NSObject<XBDataLoader>

- (id)initWithResourcePath:(NSString *)resourcePath resourceType:(NSString *)resourceType;

+ (instancetype)dataLoaderWithResourcePath:(NSString *)resourcePath resourceType:(NSString *)resourceType;

@property (nonatomic, assign) NSJSONReadingOptions readingOptions;

@end
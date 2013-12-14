//
// Created by Simone Civetta on 5/30/13.
// Copyright (c) 2013 Xebia. All rights reserved.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "XBHTTPClient.h"
#import "XBCache.h"
#import "XBObjectDataSource.h"

@interface XBObjectDataSource ()

@property (nonatomic, strong) NSError *error;
@property (nonatomic, strong) NSString *resourcePath;
@property (nonatomic, strong) XBCache *cache;
@property (nonatomic, strong) XBHTTPClient *httpClient;
@property (nonatomic, strong) id object;

@end

@implementation XBObjectDataSource

- (id)initWithObject:(NSObject *)object
{
    if (self = [super init]) {
        _object = object;
    }
    return self;
}

+ (instancetype)dataSourceWithObject:(NSObject *)object
{
    return [[self alloc] initWithObject:object];
}

- (id)object
{
    return _object;
}

@end

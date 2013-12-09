//
// Created by Simone Civetta on 5/30/13.
// Copyright (c) 2013 Xebia. All rights reserved.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "XBXmlToObjectDataMapper.h"
#import "XBModel.h"
#import <KissXML/DDXML.h>
#import <MantleXMLAdapter/MTLXMLAdapter.h>

@interface XBXmlToObjectDataMapper()

@property(nonatomic, weak) Class typeClass;
@property(nonatomic, strong) NSString *rootXPath;

@end

@implementation XBXmlToObjectDataMapper

- (id)initWithRootXPath:(NSString *)rootXPath typeClass:(Class)typeClass
{
    self = [super init];
    if (self) {
        _rootXPath = rootXPath;
        _typeClass = typeClass;
    }

    return self;
}

+ (instancetype)mapperWithRootXPath:(NSString *)rootXPath typeClass:(Class)typeClass
{
    return [[self alloc] initWithRootXPath:rootXPath typeClass:typeClass];
}

- (void)mapData:(id)data withCompletionCallback:(XBDataMapperCompletionCallback)callback
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{

        NSError *error = nil;
        id model;
        
        DDXMLNode *doc = [[DDXMLDocument alloc] initWithData:data options:0 error:&error];
        
        if (self.rootXPath) {
            NSArray *nodes = [doc nodesForXPath:self.rootXPath error:&error];
            
            if ([nodes count] > 0) {
                doc = nodes[0];
            } else {
                doc = nil;
            }
        }
        
        MTLXMLAdapter *adapter = [[MTLXMLAdapter alloc] initWithXMLNode:doc
                                                             modelClass:self.typeClass
                                                                  error:&error];
        model = adapter.model;

        dispatch_async(dispatch_get_main_queue(), ^{
            if (callback) {
                callback(model);
            }
        });
    });
}

@end
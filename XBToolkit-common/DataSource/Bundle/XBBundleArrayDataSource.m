//
// Created by akinsella on 25/03/13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "XBLoadableArrayDataSource.h"
#import "XBLoadableArrayDataSource+protected.h"
#import "XBBundleArrayDataSource.h"
#import "JSONKit.h"

@implementation XBBundleArrayDataSource

+ (XBBundleArrayDataSource *)dataSourceWithConfiguration:(XBBundleArrayDataSourceConfiguration *)configuration {
    return [[self alloc] initWithConfiguration:configuration];
}

- (id)initWithConfiguration:(XBBundleArrayDataSourceConfiguration *)configuration {
    self = [super init];
    if (self) {
        self.typeClass = configuration.typeClass;
        self.rootKeyPath = configuration.rootKeyPath;
        _resourcePath = configuration.resourcePath;
        _resourceType = configuration.resourceType;
    }

    return self;
}

- (void)loadDataWithCallback:(void (^)())callback {
    NSBundle *mainBundle = [NSBundle mainBundle];
    NSString *file = [mainBundle pathForResource:_resourcePath ofType:_resourceType];
    NSError *error;
    NSString *jsonLoaded = [NSString stringWithContentsOfFile:file encoding:NSUTF8StringEncoding error:&error];
    NSDictionary *json = [jsonLoaded objectFromJSONString];
    self.error = error;
    if (!error) {
        DDLogVerbose(@"jsonLoaded: %@", json);

        [self loadArrayFromJson:json];

    }
    if (callback) {
        callback();
    }
}

@end
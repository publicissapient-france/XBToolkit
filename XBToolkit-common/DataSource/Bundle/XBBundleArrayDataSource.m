//
// Created by akinsella on 25/03/13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "XBLoadableArrayDataSource.h"
#import "XBLoadableArrayDataSource+protected.h"
#import "XBBundleArrayDataSource.h"
#import "JSONKit.h"

@interface XBBundleArrayDataSource()
@property (nonatomic, strong, readonly)NSString *resourcePath;
@property (nonatomic, strong, readonly)NSString *resourceType;
@end

@implementation XBBundleArrayDataSource

+ (id)sourceWithResourcePath:(NSString *)resourcePath resourceType:(NSString *)resourceType {
    return [[self alloc] initWithResourcePath:resourcePath resourceType:resourceType];
}

- (id)initWithResourcePath:(NSString *)resourcePath resourceType:(NSString *)resourceType {
    self = [super init];
    if (self) {
        _resourcePath = resourcePath;
        _resourceType = resourceType;
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
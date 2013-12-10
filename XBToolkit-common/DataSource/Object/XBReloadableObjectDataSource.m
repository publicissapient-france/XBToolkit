//
// Created by Simone Civetta on 5/30/13.
//


#import "XBObjectDataSource+protected.h"
#import "XBReloadableObjectDataSource.h"
#import "XBDataLoader.h"

@interface XBReloadableObjectDataSource()

@property(nonatomic, strong) NSError *error;
@property(nonatomic, strong) id<XBDataLoader> dataLoader;
@end

@implementation XBReloadableObjectDataSource

- (id)initWithDataLoader:(id <XBDataLoader>)dataLoader
{
    self = [super init];
    if (self) {
        self.dataLoader = dataLoader;
    }

    return self;
}

+ (instancetype)dataSourceWithDataLoader:(id <XBDataLoader>)dataLoader
{
    return [[self alloc] initWithDataLoader:dataLoader];
}

- (void)loadData
{
    [self loadDataWithCallback:nil];
}

- (void)loadDataWithCallback:(void (^)())callback
{
    [self.dataLoader loadDataWithSuccess:^(NSOperation *operation, id data) {
        [self processSuccessForResponseObject:data callback:^{
            if (callback) {
                callback();
            }
        }];
    } failure:^(NSOperation *operation, id responseObject, NSError *error) {
        self.error = error;
        if (callback) {
            callback();
        }
    }];
}

- (void)loadDataWithHttpMethod:(NSString *)httpMethod
                  withCallback:(void (^)())callback
{
    [self.dataLoader loadDataWithHttpMethod:httpMethod
                                withSuccess:^(NSOperation *operation, id responseObject) {
                                    [self processSuccessForResponseObject:responseObject callback:^{
                                        if (callback) {
                                            callback();
                                        }
                                    }];
                                } failure:^(NSOperation *operation, id responseObject, NSError *error) {
                                    self.error = error;
                                    if (callback) {
                                        callback();
                                    }
                                }];
}


- (void)processSuccessForResponseObject:(id)responseObject callback:(void (^)())callback
{
    self.object = responseObject;
    if (callback) {
        callback();
    }
}

@end
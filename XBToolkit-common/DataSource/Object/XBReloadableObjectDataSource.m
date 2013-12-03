//
// Created by Simone Civetta on 5/30/13.
//


#import "XBObjectDataSource+protected.h"
#import "XBReloadableObjectDataSource.h"
#import "XBDataLoader.h"
#import "XBDataMapper.h"

@interface XBReloadableObjectDataSource()

@property(nonatomic, strong) NSError *error;
@property(nonatomic, strong) id<XBDataLoader> dataLoader;
@property(nonatomic, strong) id<XBDataMapper> dataMapper;
#warning rawData has been removed

@end

@implementation XBReloadableObjectDataSource

+ (id)dataSourceWithDataLoader:(id <XBDataLoader>)dataLoader dataMapper:(id <XBDataMapper>)dataMapper
{
    return [[self alloc] initWithDataLoader:dataLoader dataMapper:dataMapper];
}

- (id)initWithDataLoader:(id <XBDataLoader>)dataLoader dataMapper:(id <XBDataMapper>)dataMapper
{
    self = [super init];
    if (self) {
        self.dataLoader = dataLoader;
        self.dataMapper = dataMapper;
    }

    return self;
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
                                withSuccess:^(NSOperation *operation, id data) {
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


- (void)processSuccessForResponseObject:(id)responseObject callback:(void (^)())callback
{
    self.object = responseObject;
    if (callback) {
        callback();
    }
}

@end
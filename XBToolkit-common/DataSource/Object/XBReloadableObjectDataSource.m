//
// Created by Simone Civetta on 5/30/13.
//


#import "XBObjectDataSource+Protected.h"
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
    [self loadData:nil];
}

- (void)loadData:(XBReloadableObjectDataSourceCompletionBlock)callback
{
    [self loadData:callback queue:dispatch_get_main_queue()];
}

- (void)loadData:(XBReloadableObjectDataSourceCompletionBlock)callback queue:(dispatch_queue_t)queue
{
    [self.dataLoader loadDataWithSuccess:^(NSOperation *operation, id data) {
        [self processSuccessForResponseObject:data callback:^{
            if (callback) {
                callback(operation);
            }
        }];
    } failure:^(NSOperation *operation, id responseObject, NSError *error) {
        self.error = error;
        if (callback) {
            callback(operation);
        }
    } queue:queue];
}

- (void)processSuccessForResponseObject:(id)responseObject callback:(void (^)())callback
{
    self.object = responseObject;
    if (callback) {
        callback();
    }
}

@end
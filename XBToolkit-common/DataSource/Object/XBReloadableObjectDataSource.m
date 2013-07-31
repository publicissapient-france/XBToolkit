//
// Created by Simone Civetta on 5/30/13.
//


#import "XBObjectDataSource+protected.h"
#import "XBReloadableObjectDataSource.h"
#import "XBDataLoader.h"
#import "XBDataMapper.h"

@interface XBReloadableObjectDataSource()

@property (nonatomic, strong)NSError *error;
@property (nonatomic, strong)id rawData;
@property (nonatomic, strong)id<XBDataLoader> dataLoader;
@property (nonatomic, strong)id<XBDataMapper> dataMapper;

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
    [self.dataLoader loadDataWithSuccess:^(id data) {
        [self processSuccessWithRawData:data];
        if (callback) {
            callback();
        }
    } failure:^(NSError *error, id jsonFetched) {
        [self processFailureWithRawData:jsonFetched];
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
                                withSuccess:^(id data) {
                                    [self processSuccessWithRawData:data];
                                    if (callback) {
                                        callback();
                                    }
                                } failure:^(NSError *error, id jsonFetched) {
                                    [self processFailureWithRawData:jsonFetched];
                                    self.error = error;
                                    if (callback) {
                                        callback();
                                    }
                                }];
}


- (void)processSuccessWithRawData:(id)rawData
{
    self.rawData = rawData;
    self.object = [self.dataMapper mapData:rawData];
}

- (void)processFailureWithRawData:(id)rawData
{
    self.rawData = rawData;
}

@end
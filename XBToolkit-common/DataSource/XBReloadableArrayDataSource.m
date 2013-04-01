//
// Created by akinsella on 29/03/13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "XBReloadableArrayDataSource.h"
#import "XBArrayDataSource+protected.h"

@interface XBReloadableArrayDataSource()

@property (nonatomic, strong)NSError *error;
@property (nonatomic, strong)id rawData;
@property (nonatomic, strong)NSObject<XBDataLoader> *dataLoader;
@property (nonatomic, strong)NSObject<XBDataMapper> *dataMapper;

@end

@implementation XBReloadableArrayDataSource

+ (id)dataSourceWithDataLoader:(NSObject <XBDataLoader> *)dataLoader dataMapper:(NSObject <XBDataMapper> *)dataMapper {
    return [[self alloc] initWithDataLoader:dataLoader dataMapper:dataMapper];
}

- (id)initWithDataLoader:(NSObject <XBDataLoader> *)dataLoader dataMapper:(NSObject <XBDataMapper> *)dataMapper {
    self = [super init];
    if (self) {
        self.dataLoader = dataLoader;
        self.dataMapper = dataMapper;
    }

    return self;
}

- (void)loadData {
    [self loadDataWithCallback: nil];
}

- (void)loadDataWithCallback:(void (^)())callback {
    [self.dataLoader loadDataWithSuccess:^(id data) {
        [self processSuccessWithRawData:data];
        if (callback) {
            callback();
        }
    } failure:^(NSError *error) {
        self.error = error;
        if (callback) {
            callback();
        }
    }];
}

- (void)processSuccessWithRawData:(id)rawData {
    self.rawData = rawData;
    self.array = [self.dataMapper mapData:rawData];
    [self filterData];
}

@end
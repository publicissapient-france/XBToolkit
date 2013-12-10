//
// Created by akinsella on 29/03/13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "XBReloadableArrayDataSource.h"
#import "XBArrayDataSource+protected.h"

@interface XBReloadableArrayDataSource()

@property (nonatomic, strong) NSError *error;
@property (nonatomic, strong) id<XBDataLoader> dataLoader;

@end

@implementation XBReloadableArrayDataSource

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

#warning loadData does not send the result of the call (success or failure?)
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

#warning There's no background threading here
- (void)processSuccessForResponseObject:(id)responseObject callback:(void (^)())callback
{
    self.array = responseObject;
    [self filterData];
    if (callback) {
        callback();
    }
}

@end
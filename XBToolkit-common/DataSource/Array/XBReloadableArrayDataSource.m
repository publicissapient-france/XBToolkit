//
// Created by akinsella on 29/03/13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "XBReloadableArrayDataSource.h"
#import "XBArrayDataSource+Protected.h"
#import "XBDataLoader.h"

static dispatch_queue_t reloadable_datasource_filtering_queue() {
    static dispatch_queue_t xbtoolkit_reloadable_datasource_filtering_queue;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        xbtoolkit_reloadable_datasource_filtering_queue = dispatch_queue_create("fr.xbtoolkit.datasource.reloadable.filtering", DISPATCH_QUEUE_CONCURRENT);
    });

    return xbtoolkit_reloadable_datasource_filtering_queue;
}

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

- (void)loadData:(XBReloadableArrayDataSourceCompletionBlock)completion
{
    [self.dataLoader loadDataWithSuccess:^(NSOperation *operation, id data) {
        [self processSuccessForResponseObject:data completion:^{
            if (completion) {
                completion(operation);
            }
        }];
    } failure:^(NSOperation *operation, id responseObject, NSError *error) {
        self.error = error;
        if (completion) {
            completion(operation);
        }
    }];
}

- (void)processSuccessForResponseObject:(id)responseObject completion:(void (^)())completion
{
    self.sourceArray = responseObject;
    dispatch_async(reloadable_datasource_filtering_queue(), ^{
        [self filterData];
        dispatch_async(dispatch_get_main_queue(), ^{
            if (completion) {
                completion();
            }
        });
    });
}

@end
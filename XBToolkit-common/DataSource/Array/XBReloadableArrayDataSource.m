//
// Created by akinsella on 29/03/13.
//


#import "XBReloadableArrayDataSource.h"
#import "XBArrayDataSource+Protected.h"
#import "XBDataLoader.h"
#import "Underscore.h"

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
@property (nonatomic, strong) id <XBDataLoader> dataLoader;

@end


@implementation XBReloadableArrayDataSource

- (instancetype)initWithDataLoader:(id <XBDataLoader>)dataLoader
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
    [self loadData:completion queue:dispatch_get_main_queue()];
}

- (void)loadData:(XBReloadableArrayDataSourceCompletionBlock)completion queue:(dispatch_queue_t)queue
{
    [self.dataLoader loadDataWithSuccess:^(NSOperation *operation, id data) {
        self.error = nil;
        [self processSuccessForResponseObject:data completion:^{
            if (completion) {
                completion(operation);
            }
        } queue: queue];
    } failure:^(NSOperation *operation, id responseObject, NSError *error) {
        self.error = error;
        if (completion) {
            completion(operation);
        }
    } queue: queue];
}

- (void)processSuccessForResponseObject:(id)responseObject completion:(void (^)())completion queue:(dispatch_queue_t)queue
{
    self.sourceArray = self.filterOnLoad ? Underscore.filter(responseObject, self.filterOnLoad) : responseObject;
    dispatch_async(reloadable_datasource_filtering_queue(), ^{
        [self filterData];
        dispatch_async(queue, ^{
            if (completion) {
                completion();
            }
        });
    });
}

@end
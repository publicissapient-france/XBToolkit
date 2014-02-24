//
// Created by akinsella on 31/03/13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "XBHttpMappedDataLoader.h"
#import "XBBundleJsonDataLoader.h"
#import "XBBundleJsonReadingOperation.h"
#import "XBLogging.h"
#import "XBJsonToObjectDataMapper.h"

@interface XBBundleJsonDataLoader()

@property (nonatomic, strong) NSString *resourcePath;
@property (nonatomic, strong) NSString *resourceType;
@property (nonatomic, strong) AFJSONResponseSerializer<AFURLResponseSerialization, XBDataMapper> *dataMapper;

@end

@implementation XBBundleJsonDataLoader

- (instancetype)initWithResourcePath:(NSString *)resourcePath resourceType:(NSString *)resourceType dataMapper:(AFJSONResponseSerializer<AFURLResponseSerialization, XBDataMapper> *)dataMapper
{
    self = [super init];
    if (self) {
        self.resourcePath = resourcePath;
        self.resourceType = resourceType;
        self.dataMapper = dataMapper;
        self.readingOptions = 0;
    }

    return self;
}

- (instancetype)initWithResourcePath:(NSString *)resourcePath resourceType:(NSString *)resourceType
{
    return [self initWithResourcePath:resourcePath resourceType:resourceType dataMapper:nil];
}

+ (instancetype)dataLoaderWithResourcePath:(NSString *)resourcePath resourceType:(NSString *)resourceType
{
    return [[self alloc] initWithResourcePath:resourcePath resourceType:resourceType dataMapper:nil ];
}

+ (instancetype)dataLoaderWithResourcePath:(NSString *)resourcePath resourceType:(NSString *)resourceType dataMapper:(AFJSONResponseSerializer<AFURLResponseSerialization, XBDataMapper> *)dataMapper
{
    return [[self alloc] initWithResourcePath:resourcePath resourceType:resourceType dataMapper:dataMapper];
}

- (void)loadDataWithSuccess:(XBDataLoaderSuccessBlock)success failure:(XBDataLoaderFailureBlock)failure
{
    XBBundleJsonReadingOperation *operation = [XBBundleJsonReadingOperation operationWithBundle:[NSBundle mainBundle] resourcePath:self.resourcePath resourceType:self.resourceType];
    operation.dataMapper = self.dataMapper;

    [operation setCompletionBlockWithSuccess:^(XBBundleJsonReadingOperation *readingOperation) {
        XBLogVerbose(@"Json loaded from bundle: %@", readingOperation.responseObject);
        success(readingOperation, readingOperation.responseObject);
    } failure:^(XBBundleJsonReadingOperation *readingOperation, NSError *error) {
        failure(readingOperation, readingOperation.responseObject, error);
    }];
    [operation start];

}

@end
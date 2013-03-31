//
// Created by akinsella on 26/03/13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <JSONKit/JSONKit.h>
#import "XBPagedHttpArrayDataSource.h"
#import "XBHttpArrayDataSource.h"
#import "XBHttpArrayDataSource+protected.h"
#import "XBLoadableArrayDataSource+protected.h"
#import "XBCacheableArrayDataSource.h"
#import "XBCacheableArrayDataSource+protected.h"
#import "XBPagedHttpArrayDataSource+protected.h"
#import "XBHttpArrayDataSource+protected.h"

@implementation XBPagedHttpArrayDataSource

- (NSString *)storageFileName {
    return nil;
}

+ (id)dataSourceWithConfiguration:(XBHttpArrayDataSourceConfiguration *)configuration
                       httpClient:(XBHttpClient *)httpClient {
    return [[self alloc] initWithConfiguration:configuration httpClient: httpClient];
}

- (id)initWithConfiguration:(XBHttpArrayDataSourceConfiguration *)configuration
                 httpClient:(XBHttpClient *)httpClient {

//    if (!configuration.paginator) {
//        [NSException raise:NSInvalidArgumentException format:@"configuration does not contain paginator"];
//    }
//
//    if (configuration.cache) {
//        [NSException raise:NSInvalidArgumentException format:@"XBPagedHttpArrayDataSource does not support cache"];
//    }

    self.paginator = configuration.paginator;

    return [super initWithConfiguration:configuration httpClient:httpClient];
}

- (void)setPaginator:(NSObject <XBPaginator> *)paginator {
    _paginator = paginator;
}

- (BOOL)hasMorePages {
    return [self.paginator hasMorePages];
}

- (void)loadNextPageWithCallback:(void (^)())callback {
    if ([self hasMorePages]) {
        [self fetchDataFromSourceInternalWithCallback:callback merge:YES];
    }
    else if (callback) {
        callback();
    }
}

- (void)fetchDataFromSourceWithCallback:(void (^)())callback {
    [self.paginator resetPageIncrement];
    [self fetchDataFromSourceInternalWithCallback:callback merge:NO];
}

- (void)fetchDataFromSourceInternalWithCallback:(void (^)())callback merge:(BOOL)merge {
    [self.httpClient executeGetJsonRequestWithPath:self.resourcePath parameters: [self.httpQueryParamBuilder build]
       success:^(NSURLRequest *request, NSHTTPURLResponse *response, id jsonFetched) {
          [self processSuccessWithJson:jsonFetched callback:callback merge: merge];
       }
       failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id jsonFetched) {
           DDLogWarn(@"Error: %@, jsonFetched: %@", error, jsonFetched);
           self.error = error;
           if (callback) {
               callback();
           }
       }
    ];
}

- (void)processSuccessWithJson:(id)jsonFetched callback:(void (^)())callback merge:(BOOL)merge {
    id jsonMerged = !merge ? jsonFetched : [self mergeRawData:jsonFetched];
    [super processSuccessWithJson:jsonMerged callback:callback];
}

- (id)mergeRawData:(id)jsonFetched {
    id mutableRawData = [self.rawData mutableCopy];

    NSMutableArray *currentData = self.rootKeyPath ? [mutableRawData valueForKeyPath:self.rootKeyPath] : mutableRawData;
    [currentData addObjectsFromArray: (self.rootKeyPath ? [jsonFetched valueForKeyPath:self.rootKeyPath] : jsonFetched)];

    return mutableRawData;
}

@end

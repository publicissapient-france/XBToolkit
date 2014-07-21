//
// Created by akinsella on 01/04/13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "XBArrayDataMerger.h"
#import "GHUnit.h"
#import "XBBundleJsonDataLoader.h"

@interface XBArrayDataMergerTest : GHAsyncTestCase @end

@implementation XBArrayDataMergerTest

- (void)testMerger
{

    [self prepare];

    XBBundleJsonDataLoader *dataLoaderDest = [XBBundleJsonDataLoader dataLoaderWithResourcePath:@"wp-author-index-p1" resourceType:@"json"];
    XBBundleJsonDataLoader *dataLoaderSrc = [XBBundleJsonDataLoader dataLoaderWithResourcePath:@"wp-author-index-p2" resourceType:@"json"];

    __block NSArray *dataDest;
    __block NSArray *dataSrc;

    void (^completionBlock)() = ^void() {
        if (dataSrc && dataDest) {
            [self notify:kGHUnitWaitStatusSuccess forSelector:@selector(testMerger)];
        }
    };

    [dataLoaderSrc loadDataWithSuccess:^(NSOperation *operation, NSDictionary *data) {
        dataSrc = data[@"authors"];
        completionBlock();
    } failure:nil];

    [dataLoaderDest loadDataWithSuccess:^(NSOperation *operation, NSDictionary *data) {
        dataDest = data[@"authors"];
        completionBlock();
    } failure:nil];

    [self waitForStatus:kGHUnitWaitStatusSuccess timeout:10.0];

    XBArrayDataMerger *dataMerger = [XBArrayDataMerger dataMerger];

    NSArray *authors = [dataMerger mergeDataOfSource:dataSrc withSource:dataDest];
    GHAssertEquals(authors.count, [@60 unsignedIntegerValue], nil);
}

@end
//
// Created by akinsella on 01/04/13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "XBDictionaryDataMerger.h"
#import "GHUnit.h"
#import "XBBundleJsonDataLoader.h"

@interface XBDictionaryDataMergerTest : GHAsyncTestCase @end

@implementation XBDictionaryDataMergerTest

- (void)testMerger
{

    [self prepare];
    
    XBBundleJsonDataLoader *dataLoaderDest = [XBBundleJsonDataLoader dataLoaderWithResourcePath:@"wp-author-index-p1" resourceType:@"json"];
    XBBundleJsonDataLoader *dataLoaderSrc = [XBBundleJsonDataLoader dataLoaderWithResourcePath:@"wp-author-index-p2" resourceType:@"json"];

    __block NSDictionary *dataDest;
    __block NSDictionary *dataSrc;

    void (^completionBlock)() = ^void() {
        if (dataSrc && dataDest) {
            [self notify:kGHUnitWaitStatusSuccess forSelector:@selector(testMerger)];
        }
    };

    [dataLoaderSrc loadDataWithSuccess:^(NSOperation *operation, NSDictionary *data) {
        dataSrc = data;
        completionBlock();
    } failure:nil];
    
    [dataLoaderDest loadDataWithSuccess:^(NSOperation *operation, NSDictionary *data) {
        dataDest = data;
        completionBlock();
    } failure:nil];
    
    [self waitForStatus:kGHUnitWaitStatusSuccess timeout:10.0];

    XBDictionaryDataMerger *dataMerger = [XBDictionaryDataMerger dataMergerWithRootKeyPath:@"authors"];

    NSDictionary *result = [dataMerger mergeDataOfSource:dataSrc withSource:dataDest];

    NSArray *authors = result[@"authors"];
    GHAssertEquals(authors.count, [@60 unsignedIntegerValue], nil);
}

@end
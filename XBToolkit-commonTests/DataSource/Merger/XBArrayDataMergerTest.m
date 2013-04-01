//
// Created by akinsella on 01/04/13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "XBArrayDataMerger.h"
#import "GHUnit.h"
#import "XBBundleJsonDataLoader.h"

@interface XBArrayDataMergerTest : GHTestCase @end

@implementation XBArrayDataMergerTest

-(void)testMerge {

    XBBundleJsonDataLoader *dataLoaderDest = [XBBundleJsonDataLoader dataLoaderWithResourcePath:@"wp-author-index-p1" resourceType:@"json"];
    XBBundleJsonDataLoader *dataLoaderSrc = [XBBundleJsonDataLoader dataLoaderWithResourcePath:@"wp-author-index-p2" resourceType:@"json"];

    __block NSArray *dataDest;
    __block NSArray *dataSrc;

    [dataLoaderSrc loadDataWithSuccess:^(NSDictionary * data) { dataSrc = data[@"authors"]; } failure:^(NSError *error) { }];
    [dataLoaderDest loadDataWithSuccess:^(NSDictionary * data) { dataDest = data[@"authors"]; } failure:^(NSError *error) { }];

    XBArrayDataMerger *dataMerger = [XBArrayDataMerger dataMerger];

    NSArray * authors = [dataMerger mergeDataFromSource:dataSrc toDest:dataDest];

    GHAssertEquals(authors.count, [@60 unsignedIntegerValue], nil);
}

@end
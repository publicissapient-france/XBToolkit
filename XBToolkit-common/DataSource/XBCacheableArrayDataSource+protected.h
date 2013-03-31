//
// Created by akinsella on 10/03/13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>

#import "XBHttpClient.h"
#import "XBHttpArrayDataSourceConfiguration.h"
#import "XBHttpArrayDataSource.h"
#import "XBCacheableArrayDataSource.h"
#import "XBCache.h"

@interface XBCacheableArrayDataSource (protected)

-(void)setCache:(NSObject<XBCache> *)cache;
-(void)setDateFormatter:(NSDateFormatter *)dateFormatter;
-(void)setMaxDataAgeInSecondsBeforeServerFetch:(NSInteger)maxDataAgeInSecondsBeforeServerFetch;
-(void)setStorageFileName:(NSString *)storageFilename;

-(void)processSuccessWithJson:(id)jsonFetched callback:(void (^)())callback;
-(void)processError:(NSError*)error json:(id)jsonFetched callback:(void (^)())callback;

@end
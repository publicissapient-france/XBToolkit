//
// Created by akinsella on 29/03/13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>
#import "XBArrayDataSource.h"
#import "XBReloadableArrayDataSource.h"

@interface XBReloadableArrayDataSource (XBLoadableArrayDataSource_protected)

@property (nonatomic, strong)NSObject<XBDataLoader> *dataLoader;
@property (nonatomic, strong)NSObject<XBDataMapper> *dataMapper;

-(void)setError:(NSError *)error;

- (void)processSuccessWithRawData:(id)rawData;

@end
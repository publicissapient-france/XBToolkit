//
// Created by akinsella on 29/03/13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>
#import "XBArrayDataSource.h"
#import "XBLoadableArrayDataSource.h"

@interface XBLoadableArrayDataSource (XBLoadableArrayDataSource_protected)

-(void)setError:(NSError *)error;
-(void)setRootKeyPath:(NSString *)rootKeyPath;
-(void)setTypeClass:(Class)typeClass;

- (void)loadArrayFromJson:(NSDictionary *)json;

@end
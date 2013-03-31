//
// Created by akinsella on 29/03/13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>
#import "XBArrayDataSource.h"


@interface XBLoadableArrayDataSource : XBArrayDataSource {
    __weak Class _typeClass;
    NSString *_rootKeyPath;
    id rawData;
    NSError *_error;
}

@property (nonatomic, strong, readonly)NSError *error;
@property (nonatomic, weak, readonly)Class typeClass;
@property (nonatomic, weak, readonly)id rawData;
@property (nonatomic, strong, readonly)NSString *rootKeyPath;

- (void)loadData;

- (void)loadDataWithCallback:(void (^)())callback;

@end
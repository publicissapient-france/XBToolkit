//
// Created by akinsella on 29/03/13.
//


#import <Foundation/Foundation.h>
#import "XBArrayDataSource.h"
#import "XBReloadableArrayDataSource.h"


@interface XBReloadableArrayDataSource (Protected)

@property (nonatomic, strong) id <XBDataLoader> dataLoader;
@property (nonatomic, strong) id <XBDataMapper> dataMapper;

- (void)setError:(NSError *)error;
- (void)processSuccessForResponseObject:(id)responseObject completion:(void (^)())completion;

@end
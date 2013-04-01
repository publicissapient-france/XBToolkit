//
// Created by akinsella on 31/03/13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>

@protocol XBDataLoader <NSObject>

-(void)loadDataWithSuccess:(void(^)(id))success failure:(void(^)(NSError *))failure;

@end
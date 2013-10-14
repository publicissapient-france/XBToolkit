//
// Created by akinsella on 31/03/13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>

typedef void(^XBDataMapperCompletionCallback)(id mappedData);

@protocol XBDataMapper <NSObject>

- (void)mapData:(id)data withCompletionCallback:(XBDataMapperCompletionCallback)callback;

@end
//
// Created by akinsella on 31/03/13.
//


#import <Foundation/Foundation.h>
@protocol XBDataMapper <NSObject>

- (id)mappedObjectFromData:(id)data error:(NSError * __autoreleasing *)error;

@end
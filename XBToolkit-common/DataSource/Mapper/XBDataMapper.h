//
// Created by akinsella on 31/03/13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>
@protocol XBDataMapper <NSObject>

#warning Careful! This method is now synchronous!
- (id)mappedObjectFromData:(id)data error:(NSError * __autoreleasing *)error;

@end
//
// Created by akinsella on 01/04/13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>
#import "XBDataMerger.h"
#import "XBDataMapper.h"

@interface XBDictionaryDataMerger : NSObject<XBDataMerger>

- (id)initWithRootKeyPath:(NSString *)rootKeyPath;

+ (id)dataMergerWithRootKeyPath:(NSString *)rootKeyPath;


@end
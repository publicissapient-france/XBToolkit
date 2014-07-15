//
// Created by akinsella on 01/04/13.
//


#import <Foundation/Foundation.h>
#import "XBDataMerger.h"
#import "XBDataMapper.h"


@interface XBDictionaryDataMerger : NSObject<XBDataMerger>

- (instancetype)initWithRootKeyPath:(NSString *)rootKeyPath;

+ (instancetype)dataMergerWithRootKeyPath:(NSString *)rootKeyPath;


@end
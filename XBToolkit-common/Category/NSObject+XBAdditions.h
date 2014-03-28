//
// Created by Alexis Kinsella on 28/03/2014.
// Copyright (c) 2014 Xebia. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (XBAdditions)

- (NSString *)serializeToJsonWithError:(NSError **)error;

- (NSString *)serializeToJsonWithDateFormatter:(NSDateFormatter *)dateFormatter error:(NSError **)error;

@end
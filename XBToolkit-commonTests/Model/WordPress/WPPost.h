//
// Created by Simone Civetta on 5/30/13.
// Copyright (c) 2013 Xebia. All rights reserved.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>
#import "XBMappingProvider.h"


@interface WPPost : NSObject<XBMappingProvider>

@property (nonatomic, strong) NSNumber *identifier;
@property (nonatomic, strong) NSString *type;
@property (nonatomic, strong) NSString *slug;
@property (nonatomic, strong) NSString *url;
@property (nonatomic, strong) NSString *status;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *title_plain;
@property (nonatomic, strong) NSString *content;

@end
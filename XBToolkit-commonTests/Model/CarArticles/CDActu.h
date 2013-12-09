//
//  WPAuthor.h
//  xebia-ios
//
//  Created by Alexis Kinsella on 24/07/12.
//  Copyright (c) 2012 Xebia France. All rights reserved.
//

#import "XBModel.h"
#import <Mantle/Mantle.h>
#import <MantleXMLAdapter/MTLXMLAdapter.h>

@interface CDActu : XBModel<MTLXMLSerializing>

@property (nonatomic, strong) NSArray *articles;
@property (nonatomic, strong) NSString *dbConnectionStatus;

- (DDXMLElement *)serializeToXMLElement;

@end


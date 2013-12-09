//
//  CDArticle.h
//  XBToolkit-ios
//
//  Created by Simone Civetta on 09/12/13.
//  Copyright (c) 2013 Xebia. All rights reserved.
//

#import "XBModel.h"
#import <MantleXMLAdapter/MTLXMLAdapter.h>

@interface CDArticle : XBModel<MTLXMLSerializing>

@property(nonatomic, strong) NSString *titre;
@property(nonatomic, strong) NSString *chapo;

@end

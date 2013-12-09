//
//  CDArticle.m
//  XBToolkit-ios
//
//  Created by Simone Civetta on 09/12/13.
//  Copyright (c) 2013 Xebia. All rights reserved.
//

#import "CDArticle.h"

@implementation CDArticle

+ (NSString *)XPathPrefix
{
    // @"@"self::element/"
    return @".";
}

+ (NSDictionary *)XMLKeyPathsByPropertyKey
{
    return @{ @"titre": @"titre",
              @"chapo": @"chapo"
              };
}

@end

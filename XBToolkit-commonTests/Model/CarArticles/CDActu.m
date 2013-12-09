//
//  WPAuthor.m
//  xebia-ios
//
//  Created by Alexis Kinsella on 24/07/12.
//  Copyright (c) 2012 Xebia France. All rights reserved.
//

#import <MantleXMLAdapter/NSValueTransformer+MTLXMLTransformerAdditions.h>
#import "CDArticle.h"
#import "CDActu.h"

@implementation CDActu

+ (NSString *)XPathPrefix
{
    return @"./actu/";
}

+ (NSDictionary *)XMLKeyPathsByPropertyKey
{
    return @{ @"dbConnectionStatus": @"_connexion_db",
              @"articles": @"_data/article"
              };
}

+ (NSValueTransformer *)articlesXMLTransformer
{
    return [NSValueTransformer mtl_XMLArrayTransformerWithModelClass:[CDArticle class]];
}

- (DDXMLElement *)serializeToXMLElement
{
    return nil;
}

@end


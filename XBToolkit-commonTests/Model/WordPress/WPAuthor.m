//
//  WPAuthor.m
//  xebia-ios
//
//  Created by Alexis Kinsella on 24/07/12.
//  Copyright (c) 2012 Xebia France. All rights reserved.
//

#import "WPAuthor.h"
#import "WPPost.h"

@implementation WPAuthor

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return nil;
}

+ (instancetype)authorWithId:(NSNumber *)identifier name:(NSString *)name
{
    WPAuthor *author = [[self alloc] init];
    author.id = identifier;
    author.name = name;
    return author;
}

+ (NSValueTransformer *)postsJSONTransformer
{
    return [NSValueTransformer mtl_JSONArrayTransformerWithModelClass:WPPost.class];
}

@end


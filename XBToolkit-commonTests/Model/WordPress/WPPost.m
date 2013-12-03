//
// Created by Simone Civetta on 5/30/13.
// Copyright (c) 2013 Xebia. All rights reserved.
//
// To change the template use AppCode | Preferences | File Templates.
//

#import "WPPost.h"


@implementation WPPost

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return nil;
}

+ (instancetype)postWithId:(NSNumber *)identifier slug:(NSString *)slug title:(NSString *)title content:(NSString *)content
{
    WPPost *post = [[self alloc] init];
    post.identifier = identifier;
    post.slug = slug;
    post.title = title;
    post.content = content;
    return post;
}


@end
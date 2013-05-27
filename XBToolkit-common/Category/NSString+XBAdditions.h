//
//  NSString+XBAdditions.h
//  LaCentrale
//
//  Created by Simone Civetta on 4/1/13.
//  Copyright (c) 2013 Xebia IT Architets. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (XBAdditions)

- (BOOL)insensitiveContainsString:(NSString *)subString;

- (NSIndexSet *)asIndexSet;

-(NSURL *) url;

@end

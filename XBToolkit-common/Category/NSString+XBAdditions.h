//
//  NSString+XBAdditions.h
//  Created by Simone Civetta on 4/1/13.
//


#import <Foundation/Foundation.h>

@interface NSString (XBAdditions)

- (BOOL)insensitiveContainsString:(NSString *)subString;

- (NSIndexSet *)asIndexSet;

- (NSURL *)url;

@end

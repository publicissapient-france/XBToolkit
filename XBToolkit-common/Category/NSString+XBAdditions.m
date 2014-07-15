//
//  NSString+XBAdditions.m
//  Created by Simone Civetta on 4/1/13.
//


#import "NSString+XBAdditions.h"


@implementation NSString (XBAdditions)

- (BOOL)insensitiveContainsString:(NSString *)subString
{
    return !subString || [[self uppercaseString] rangeOfString:[subString uppercaseString]].location != NSNotFound;
}

- (NSURL *)url
{
    return [NSURL URLWithString:self];
}


- (NSIndexSet *)asIndexSet {
    NSArray* elements = [self componentsSeparatedByString: @","];
    NSMutableIndexSet *indexSet = [NSMutableIndexSet indexSet];

    for (NSString * element in elements) {
        [indexSet addIndex:(NSUInteger)[element integerValue]];
    }

    return [indexSet copy];
}

@end

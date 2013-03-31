//
// Created by akinsella on 11/09/12.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "NSError+XBAdditions.h"


@implementation NSError (XBAdditions)


- (NSString *)debugDescription {
    //  Log the entirety of domain, code, userInfo for debugging.
    //  Operates recursively on underlying errors

    NSMutableDictionary *dictionaryRep = [[self userInfo] mutableCopy];

    [dictionaryRep setObject:[self domain] forKey:@"domain"];
    [dictionaryRep setObject:[NSNumber numberWithInteger:[self code]] forKey:@"code"];

    NSError *underlyingError = [[self userInfo] objectForKey:NSUnderlyingErrorKey];
    NSString *underlyingErrorDescription = [underlyingError debugDescription];
    if (underlyingErrorDescription) {
        [dictionaryRep setObject:underlyingErrorDescription forKey:NSUnderlyingErrorKey];
    }

    // Finish up
    return [dictionaryRep description];
}

@end
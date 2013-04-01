//
// Created by akinsella on 01/04/13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "NSDictionary+XBAdditions.h"


static NSString *toString(id object) {
    return [NSString stringWithFormat: @"%@", object];
}

static NSString *urlEncode(id object) {
    return [toString(object) stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding];
}

@implementation NSDictionary(XBAdditions)

-(NSString*) urlEncodedString {
    NSMutableArray *parts = [NSMutableArray array];

    NSArray *queryParamKeys = [[self allKeys] sortedArrayUsingComparator:^NSComparisonResult(NSString *str1, NSString *str2) {
        return [str1 caseInsensitiveCompare:str2];
    }];

    for (id key in queryParamKeys) {
        id value = [self objectForKey: key];
        NSString *part = [NSString stringWithFormat: @"%@=%@", urlEncode(key), urlEncode(value)];
        [parts addObject: part];
    }
    return [parts componentsJoinedByString: @"&"];
}

// http://stackoverflow.com/questions/5453481/how-to-do-true-deep-copy-for-nsarray-and-nsdictionary-with-have-nested-arrays-di
-(NSMutableDictionary *)deepMutableCopy {
    return (__bridge NSMutableDictionary *)(CFPropertyListCreateDeepCopy(kCFAllocatorDefault,
            (__bridge CFPropertyListRef)self,
            kCFPropertyListMutableContainersAndLeaves));
}

@end
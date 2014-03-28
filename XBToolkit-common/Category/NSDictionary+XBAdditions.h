//
// Created by akinsella on 01/04/13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>

@interface NSDictionary (XBAdditions)

-(NSString*) JSONStringWithError:(NSError **)error dateFormatter:(NSDateFormatter *)dateFormatter;
-(NSString*) urlEncodedString;
-(NSMutableDictionary *)deepMutableCopy;

@end
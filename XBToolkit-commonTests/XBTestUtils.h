//
// Created by akinsella on 01/04/13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>
#import "Underscore.h"
#import "WPAuthor.h"

@class WPPost;

@interface XBTestUtils : NSObject

+ (WPAuthor *)findAuthorInArray:(NSArray *) authors ById:(NSInteger)identifier;
+ (UnderscoreTestBlock)filterAuthorById:(NSInteger)identifier;
+ (id)getAuthorsAsJson;
+ (NSArray *)getAuthorsAsArray;
+ (WPPost *)getSinglePostAsObject;
+ (id)fakeHttpClientWithSuccessCallbackWithData:(id)data;
+ (id)fakeHttpClientWithErrorCallbackWithError:(NSError *)error data:(id)data;
+ (id)fakeHttpClientWithSuccessiveSuccessCallbackWithData:(NSArray *)data parameterName:(NSString *)parameterName;

+ (id)getAuthorsAsJsonWithPage:(NSUInteger)page;
@end
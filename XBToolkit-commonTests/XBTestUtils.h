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
+ (NSData *)getAuthorsAsData;
+ (NSArray *)getAuthorsAsArray;
+ (WPPost *)getSinglePostAsObject;
+ (id)getActusAsXml;
+ (id)fakeHttpClientWithSuccessCallbackWithData:(id)data;
+ (id)fakeHttpClientWithErrorCallbackWithError:(NSError *)error data:(id)data;
+ (id)fakeHttpClientWithSuccessiveSuccessCallbackWithData:(NSArray *)data parameterName:(NSString *)parameterName;

+ (NSArray *)getAuthors:(NSInteger)numberOfAuthors asArrayWithPage:(NSUInteger)page;

@end
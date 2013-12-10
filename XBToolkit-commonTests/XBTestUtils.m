//
// Created by akinsella on 01/04/13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <OCMock/OCMockObject.h>
#import <OCMock/OCMArg.h>

#import "XBTestUtils.h"
#import "XBHttpClient.h"
#import "OCMockRecorder.h"
#import "NSInvocation+OCMAdditions.h"
#import "NSURL+XBAdditions.h"
#import "WPPost.h"
#import <AFNetworking/AFNetworking.h>

@implementation XBTestUtils

+ (UnderscoreTestBlock)filterAuthorById:(NSInteger)identifier {
    return ^BOOL(WPAuthor * author) {
        return [author.identifier intValue] == identifier;
    };
}

+ (WPAuthor *)findAuthorInArray:(NSArray *) authors ById:(NSInteger)identifier {
    return Underscore.array(authors).filter([XBTestUtils filterAuthorById:identifier]).unwrap[0];
}

+ (id)getAuthorsAsJsonWithPage:(NSUInteger)page {
    NSString *filename = [NSString stringWithFormat:@"wp-author-index-p%d", page];
    NSString *file = [[NSBundle mainBundle] pathForResource:filename ofType:@"json"];
    NSData *jsonData = [NSData dataWithContentsOfFile:file options:0 error:nil];
    return [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:nil];
}

+ (id)getAuthorsAsJson {
    return [NSJSONSerialization JSONObjectWithData:[self getAuthorsAsData] options:0 error:nil];
}

+ (NSData *)getAuthorsAsData {
    NSString *filename = @"wp-author-index";
    NSString *file = [[NSBundle mainBundle] pathForResource:filename ofType:@"json"];
    return [NSData dataWithContentsOfFile:file options:0 error:nil];
}

+ (id)getActusAsXml {
    NSString *filename = @"article";
    NSString *file = [[NSBundle mainBundle] pathForResource:filename ofType:@"xml"];
    return [NSData dataWithContentsOfFile:file options:0 error:nil];
}

+ (NSArray *)getAuthorsAsArray {
    return @[[WPAuthor authorWithId:@(50) name:@"Alexis Kinsella"],
            [WPAuthor authorWithId:@(51) name:@"Simone Civetta"],
            [WPAuthor authorWithId:@(52) name:@"Martin Moizard-Lanvin"],
            [WPAuthor authorWithId:@(53) name:@"Thomas Guerin"],
            [WPAuthor authorWithId:@(54) name:@"Gautier Mechling"],
            [WPAuthor authorWithId:@(55) name:@"Thibaud Cavin"]];
}

+ (WPPost *)getSinglePostAsObject {
    return [WPPost postWithId:@(14332) slug:@"whats-new-in-android" title:@"What's new in Android ?" content:@"Lorem ipsum dolor sit amet"];
}

+ (id)fakeHttpClientWithSuccessCallbackWithData:(id)data {
    id httpClient = [OCMockObject mockForClass:[XBHttpClient class]];

    [[httpClient stub] httpRequestOperationManager];
    [[[httpClient stub] andReturn:@"http://blog.xebia.fr"] baseUrl];

    [[[httpClient expect] andDo:[self fakeSuccessCallbackForMethodWithData:data]] executeRequestWithPath:[OCMArg isNotNil]
                                                                                                  method:[OCMArg isNotNil]
                                                                                              parameters:[OCMArg any]
                                                                                                 success:[OCMArg isNotNil]
                                                                                                 failure:[OCMArg isNotNil]];

    return httpClient;
}

+ (id)fakeHttpClientWithSuccessiveSuccessCallbackWithData:(NSArray *)data parameterName:(NSString *)parameterName
{
    id httpClient = [OCMockObject mockForClass:[XBHttpClient class]];

    [[httpClient stub] httpRequestOperationManager];
    [[[httpClient stub] andReturn:@"http://blog.xebia.fr"] baseUrl];

    for (id element in data) {
        [[[httpClient expect] andDo:[self fakeSuccesiveSuccessCallbackWithData:data parameterName:parameterName]]
                executeRequestWithPath:[OCMArg isNotNil]
                                method:[OCMArg isNotNil]
                            parameters:[OCMArg any]
                               success:[OCMArg isNotNil]
                               failure:[OCMArg isNotNil]];

        [[[httpClient expect] andDo:[self fakeSuccesiveSuccessCallbackForMethodWithData:data parameterName:parameterName]] executeRequestWithPath:[OCMArg isNotNil]
                                                                                                                                           method:[OCMArg isNotNil]
                                                                                                                                       parameters:[OCMArg any]
                                                                                                                                          success:[OCMArg isNotNil]
                                                                                                                                          failure:[OCMArg isNotNil]];
    }

    return httpClient;
}

+ (id)fakeHttpClientWithErrorCallbackWithError:(NSError *)error data:(id)data {
    id httpClient = [OCMockObject mockForClass:[XBHttpClient class]];
    
    [[httpClient stub] httpRequestOperationManager];
    [[[httpClient stub] andDo:[self fakeErrorCallbackWithError:error data:data]] executeRequestWithPath:[OCMArg isNotNil]
                                                                                                 method:[OCMArg isNotNil]
                                                                                             parameters:[OCMArg any]
                                                                                                success:[OCMArg isNotNil]
                                                                                                failure:[OCMArg isNotNil]];

    return httpClient;
}

+ (void (^)(NSInvocation *))fakeSuccesiveSuccessCallbackWithData:(NSArray *)data parameterName:(NSString *)parameterName {
    return ^(NSInvocation *invocation) {

        NSDictionary * parameters = [invocation getArgumentAtIndexAsObject:4];
        NSUInteger page = (NSUInteger)[parameters[@"page"] integerValue];

        void (^successCb)(NSURLRequest *, NSHTTPURLResponse *, id) = nil;
        [invocation getArgument:&successCb atIndex:5];
        if (!page) {
            successCb(nil, nil, data[0]);
        }
        else {
            successCb(nil, nil, data[page]);
        }
    };
}

+(void (^)(NSInvocation *))fakeSuccesiveSuccessCallbackForMethodWithData:(NSArray *)data parameterName:(NSString *)parameterName {
    return ^(NSInvocation *invocation) {
        
        NSDictionary * parameters = [invocation getArgumentAtIndexAsObject:4];
        NSUInteger page = (NSUInteger)[parameters[@"page"] integerValue];
        
        void (^successCb)(NSURLRequest *, NSHTTPURLResponse *, id) = nil;
        [invocation getArgument:&successCb atIndex:5];
        if (!page) {
            successCb(nil, nil, data[0]);
        }
        else {
            successCb(nil, nil, data[page]);
        }
    };
}

+ (void (^)(NSInvocation *))fakeSuccessCallbackWithData:(id)data {
    return ^(NSInvocation *invocation) {
        void (^successCb)(NSURLRequest *, NSHTTPURLResponse *, id) = nil;
        [invocation getArgument:&successCb atIndex:5];
        successCb(nil, nil, data);
    };
}

+ (void (^)(NSInvocation *))fakeSuccessCallbackForMethodWithData:(id)data {
    return ^(NSInvocation *invocation) {
        XBHttpClientRequestSuccessBlock successCb = nil;
        [invocation getArgument:&successCb atIndex:5];
        successCb(nil, data);
    };
}

+ (void (^)(NSInvocation *))fakeErrorCallbackWithError:(NSError *)error data:(id)data {
    return ^(NSInvocation *invocation) {
        XBHttpClientRequestFailureBlock failureCb = nil;
        [invocation getArgument:&failureCb atIndex:6];
        
        AFHTTPRequestOperation *fakeOperation = [[AFHTTPRequestOperation alloc] init];
        failureCb(fakeOperation, @{@"status": @"ko", @"count" : @(70), @"authors": [self getAuthorsAsArray]}, error);
    };
}

@end
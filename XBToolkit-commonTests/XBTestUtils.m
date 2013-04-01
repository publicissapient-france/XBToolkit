//
// Created by akinsella on 01/04/13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <OCMock/OCMockObject.h>
#import <OCMock/OCMArg.h>

#import "XBTestUtils.h"
#import "JSONKit.h"
#import "XBHttpClient.h"
#import "OCMockRecorder.h"
#import "WPAuthor.h"

@implementation XBTestUtils

+(UnderscoreTestBlock)filterAuthorById:(NSInteger)identifier {
    return ^BOOL(WPAuthor * author) {
        return [author.identifier intValue] == identifier;
    };
}

+(WPAuthor *)findAuthorInArray:(NSArray *) authors ById:(NSInteger)identifier {
    return Underscore.array(authors).filter([XBTestUtils filterAuthorById:50]).unwrap[0];
}

+(NSDictionary *)getAuthorsAsJson {
    NSString *file = [[NSBundle mainBundle] pathForResource:@"wp-author-index" ofType:@"json"];
    NSString *jsonLoaded = [NSString stringWithContentsOfFile:file encoding:NSUTF8StringEncoding error:nil];
    return [jsonLoaded objectFromJSONString];
}

+(id)fakeHttpClientWithSuccessCallbackWithData:(id)data {
    id httpClient = [OCMockObject mockForClass:[XBHttpClient class]];

    [[[httpClient expect] andDo:[self fakeSuccessCallbackWithData: data]] executeGetJsonRequestWithPath:[OCMArg isNotNil]
                                                                                             parameters:[OCMArg any]
                                                                                                success:[OCMArg isNotNil]
                                                                                                failure:[OCMArg isNotNil]];

    return httpClient;
}

+(id)fakeHttpClientWithErrorCallbackWithError:(NSError *)error data:(id)data {
    id httpClient = [OCMockObject mockForClass:[XBHttpClient class]];

    [[[httpClient expect] andDo:[self fakeErrorCallbackWithError:error data: data]] executeGetJsonRequestWithPath:[OCMArg isNotNil]
                                                                                             parameters:[OCMArg any]
                                                                                                success:[OCMArg isNotNil]
                                                                                                failure:[OCMArg isNotNil]];

    return httpClient;
}

+(void (^)(NSInvocation *))fakeSuccessCallbackWithData:(id)data {
    return ^(NSInvocation *invocation) {
        void (^successCb)(NSURLRequest *, NSHTTPURLResponse *, id) = nil;
        [invocation getArgument:&successCb atIndex:4];
        successCb(nil, nil, data);
    };
}

+(void (^)(NSInvocation *))fakeErrorCallbackWithError:(NSError *)error data:(id)data {
    return ^(NSInvocation *invocation) {
        void (^errorCb)(NSURLRequest *, NSHTTPURLResponse *, NSError *, id) = nil;
        [invocation getArgument:&errorCb atIndex:5];
        errorCb(nil, nil, error, data);
    };
}

@end
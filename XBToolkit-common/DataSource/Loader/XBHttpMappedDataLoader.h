//
// Created by akinsella on 31/03/13.
//


#import <Foundation/Foundation.h>
#import "XBDataLoader.h"
#import "XBHttpRequestDataBuilder.h"
#import "XBHttpDataLoader.h"
#import "XBHttpClient.h"
#import <AFNetworking/AFNetworking.h>

/**
 *  XBHttpMappedDataLoader provides a dataLoader for retrieving mapped data from a given endpoint.
 */
@interface XBHttpMappedDataLoader : NSObject<XBDataLoader, XBHttpDataLoader>

/**
 *  Initializes and returns a newly allocated XBHttpMappedDataLoader object with the specified parameters.
 *
 *  @param httpClient         The HTTP client responsible for retrieving the data.
 *  @param resourcePath       The path of the resource containing the data.
 *  @param httpMethod         The HTTP method used for sending the request.
 *  @param dataMapper         An object conforming to the XBDataMapper protocol which will take in charge the mapping process.
 *  @param requestDataBuilder An object conforming to the XBHttpRequestDataBuilder responsible for serializing the parameters of the request.
 *
 *  @return A newly allocated XBHttpMappedDataLoader object.
 */
- (instancetype)initWithHttpClient:(XBHttpClient *)httpClient resourcePath:(NSString *)resourcePath httpMethod:(NSString *)httpMethod dataMapper:(AFHTTPResponseSerializer <AFURLResponseSerialization> *)dataMapper requestDataBuilder:(id <XBHttpRequestDataBuilder>)requestDataBuilder;

/**
 *  Creates and returns a newly allocated XBHttpMappedDataLoader object with the specified parameters.
 *
 *  @param httpClient   The HTTP client responsible for retrieving the data.
 *  @param resourcePath The path of the resource containing the data.
 *  @param dataMapper   An object conforming to the XBDataMapper protocol which will take in charge the mapping process.
 *
 *  @return A new XBHttpMappedDataLoader object.
 */
+ (instancetype)dataLoaderWithHttpClient:(XBHttpClient *)httpClient resourcePath:(NSString *)resourcePath dataMapper:(AFHTTPResponseSerializer <AFURLResponseSerialization> *)dataMapper;

/**
 *  Creates and returns a newly allocated XBHttpMappedDataLoader object with the specified parameters.
 *
 *  @param httpClient            The HTTP client responsible for retrieving the data.
 *  @param resourcePath          The path of the resource containing the data.
 *  @param dataMapper            An object conforming to the XBDataMapper protocol which will take in charge the mapping process.
 *  @param httpQueryParamBuilder An object conforming to the XBHttpRequestDataBuilder responsible for serializing the parameters of the request.
 *
 *  @return A new XBHttpMappedDataLoader object.
 */
+ (instancetype)dataLoaderWithHttpClient:(XBHttpClient *)httpClient resourcePath:(NSString *)resourcePath dataMapper:(AFHTTPResponseSerializer <AFURLResponseSerialization> *)dataMapper httpQueryParamBuilder:(id <XBHttpRequestDataBuilder>)httpQueryParamBuilder;

/**
 *  Creates and returns a newly allocated XBHttpMappedDataLoader object with the specified parameters.
 *
 *  @param httpClient            The HTTP client responsible for retrieving the data.
 *  @param resourcePath          The path of the resource containing the data.
 *  @param httpMethod            The HTTP method used for sending the request.
 *  @param dataMapper            An object conforming to the XBDataMapper protocol which will take in charge the mapping process.
 *  @param httpQueryParamBuilder An object conforming to the XBHttpRequestDataBuilder responsible for serializing the parameters of the request.
 *
 *  @return A new XBHttpMappedDataLoader object.
 */
+ (instancetype)dataLoaderWithHttpClient:(XBHttpClient *)httpClient resourcePath:(NSString *)resourcePath httpMethod:(NSString *)httpMethod dataMapper:(AFHTTPResponseSerializer <AFURLResponseSerialization> *)dataMapper httpQueryParamBuilder:(id <XBHttpRequestDataBuilder>)httpQueryParamBuilder;

@end
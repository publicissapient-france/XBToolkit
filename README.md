# Introduction

**XBToolkit** is a framework that provides a fast and highly customizable way to retrieve and deserialize `JSON` sources.
It mainly relies on [AFNetworking](https://github.com/AFNetworking/AFNetworking) for the network layer and [Mantle](https://github.com/Mantle/Mantle) for the deserialization layer.

# Installation
**XBToolkit** can be installed through [CocoaPods](http://cocoapods.org) or by including the source files into  your project.

If you use Cocoapods, please install XBToolkit by appending to your Podfile the following line :

	pod XBToolkit

# Usage
Here are short examples showing how to map a remote object in JSON representation onto a local instance of a class:

## Deserializing a remote JSON array

```
// 1. Create an HTTP client:
id httpClient = [XBHttpClient httpClientWithBaseUrl:@"http://myfancyblog.com"];

// 2. Instantiate an dataMapper, allowing the response to be deserialized to a given class (e.g. WPAuthor):
XBJsonToArrayDataMapper *dataMapper = [XBJsonToArrayDataMapper mapperWithRootKeyPath:@"authors" typeClass:[WPAuthor class]];
		
// 3. Instantiate an dataLoader from your HTTP client and a given resourcePath:
XBHttpJsonDataLoader *dataLoader = [XBHttpJsonDataLoader dataLoaderWithHttpClient:httpClient resourcePath:@"/wp-json-api/get_author_index/" dataMapper:dataMapper];

// 4. Create the data source from the dataLoader and the dataMapper:
XBReloadableArrayDataSource *dataSource = [XBReloadableArrayDataSource dataSourceWithDataLoader:dataLoader];

// 5. Load the data:
[dataSource loadData:^(id operation) {
	NSLog(@"%@", dataSource.array.count); // Will output the number of authors of myfancyblog.com
}];
```
    
## Deserializing a remote JSON object

```
// 1. Create an HTTP client:
id httpClient = [XBHttpClient httpClientWithBaseUrl:@"http://myfancyblog.com"];

// 2. Instantiate an dataMapper, allowing the response to be deserialized to a given class (e.g. WPPost):
XBJsonToObjectDataMapper *dataMapper = [XBJsonToObjectDataMapper mapperWithRootKeyPath:@"post" typeClass:[WPPost class]];

// 3. Instantiate an dataLoader from your HTTP client and a given resourcePath:
XBHttpJsonDataLoader *dataLoader = [XBHttpJsonDataLoader dataLoaderWithHttpClient:httpClient resourcePath:@"/wp-json-api/get_post/?slug=xbtoolkit-is-so-sweet" dataMapper:dataMapper];

// 4. Create the data source from the dataLoader and the dataMapper:
XBReloadableObjectDataSource *dataSource = [XBReloadableObjectDataSource dataSourceWithDataLoader:dataLoader];

// 5. Load the data:
[dataSource loadData:^(id operation) {
	NSLog(@"%@", dataSource.object.slug); // Prints "my-great-post"
}];    
```
    
    
## How to deserialize to a specific a data model
A class representing your data model should subclass `MTLModel` and define all the properties that our object contains. For instance, let's suppose we have the following JSON object:
```

{
	"status": "ok",
	"post": {
		"id": 14332,
		"type": "post",
		"slug": "xbtoolkit-is-nice",
		"url": "http:\/\/myfancyblog.com\/2013\/05\/30\/xbtoolkit-is-cool\/",
		"status": "publish",
		"title": "XBToolkit is nice",
		"title_plain": "XBToolkit is nice",
		"content": "XBToolkit is nice"
}
```
If we want to deserialize this object to a WPPost class, what we'll have o do is to create a WPPost class coded as follows:

```
// WPPost.h

#import <Foundation/Foundation.h>
#import <Mantle/Mantle.h>

@interface WPPost : MTLModel<MTLJSONSerializing>

@property (nonatomic, strong) NSNumber *identifier;
@property (nonatomic, strong) NSString *type;
@property (nonatomic, strong) NSString *slug;
@property (nonatomic, strong) NSString *url;
@property (nonatomic, strong) NSString *status;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *title_plain;
@property (nonatomic, strong) NSString *content;

@end
```	

```
// WPPost.m

#import "WPPost.h"

@implementation WPPost

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return nil;
}

@end
```

The class method `mappings` must contain the configuration specific to the class.
Since **XBToolkit** relies on `Mantle` for the mapping of an object, you could find more detailed information on the mapping configuration in the [project's readme page](https://github.com/Mantle/Mantle).

# Tearing to pieces

## HTTP Client
The httpClient (`XBHttpClient`) is responsible of establishing an HTTP connection with a remote source.

## Data loader
The `dataLoader` object is responsible for retrieving data from the source. Convenience subclasses are included in **XBToolkit** in order to provide the most common data loaders. These include:

* `XBHttpJsonDataLoader`: provides a data loader which retrieves its data from a remote JSON resource. An instance of XBHttpLoader can be created through the following factory:

```
+ (XBHttpJsonDataLoader *)dataLoaderWithHttpClient:(XBHttpClient *)httpClient resourcePath:(NSString *)path
```

## Data mapper
The `dataMapper` object allows the mapping of a resource into a local data model by the means of what described in the section [_Deserializing to a specific a data model_](#how-to-deserialize-to-a-specific-a-data-model). Convenience subclasses shipped in the framework include:

* `XBJsonToObjectDataMapper`: converts a JSON object to a local instance. 
* `XBJsonToArrayDataMapper`: converts a JSON array to a local NSArray. 

## Data source
The `dataSource` provides a managed access to an instance of an object.
The following dataSources are bundled in **XBToolkit**:

* `XBObjectDataSource`: The simplest form of a `dataSource`, it is basically a wrapper around an object.
* `XBReloadableObjectDataSource`: a class providing the capability of reloading the object wrapped by the dataSource. This make sense for all the reloadable object data sources that are created from a `dataLoader` and a `dataMapper`. An object of this class can be instantiated as follows:

```
+ (XBReloadableObjectDataSource *)dataSourceWithDataLoader:(XBDataSource *)dataSource dataMapper:(XBDataMapper *)dataMapper;
```

* `XBArrayDataSource`: XBArrayDataSource provides array-like methods for accessing an ordered list of elements.
* `XBReloadableArrayDataSource`: a class providing the capability of reloading the elements contained in a dataSource. This make sense for the data sources that are created from a `dataLoader` and a `dataMapper`. An object of this class can be instantiated as follows:

```
+ (XBReloadableArrayDataSource *)dataSourceWithDataLoader:(XBDataSource *)dataSource dataMapper:(XBDataMapper *)dataMapper;
```

# Team
## Authors
* Alexis Kinsella (akinsella) - _Xebia IT Architects_
* Simone Civetta (viteinfinite) - _Xebia IT Architects_

    
# License
Apache License, Version 2.0

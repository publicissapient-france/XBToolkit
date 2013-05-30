Introduction
=========================

**XBToolkit** is a framework that provides a fast and highly customizable way to retrieve and deserialize `JSON` sources.

It mainly relies on [AFNetworking](https://github.com/AFNetworking/AFNetworking) for the network layer and [DCKeyValueObjectMapping](https://github.com/dchohfi/KeyValueObjectMapping) for the deserialization layer.

Installation
-------------------------
At the time of writing **XBToolkit** can be installed through `CocoaPods` or by including the source files into  your project.

Usage
-------------------------
Short example showing how to map a remote object in JSON representation onto a local instance of a class:

1) Create an HTTP client:

	id httpClient = [XBHttpClient httpClientWithBaseUrl:@"http://myfancyblog.com"];
		
2) Instantiate an `dataLoader` from your HTTP client and a given `resourcePath`:

	XBHttpJsonDataLoader *dataLoader = [XBHttpJsonDataLoader dataLoaderWithHttpClient:httpClient resourcePath:@"/wp-json-api/get_author_index/"];

3) Instantiate an `dataMapper`, allowing the response to be deserialized onto a given class (e.g. `WPAuthor`):

    XBJsonToArrayDataMapper * dataMapper = [XBJsonToArrayDataMapper mapperWithRootKeyPath:@"authors" typeClass:[WPAuthor class]];

4) Create the data source from the `dataLoader` and the `dataMapper`:
    
    XBReloadableArrayDataSource *dataSource = [XBReloadableArrayDataSource dataSourceWithDataLoader:dataLoader dataMapper:dataMapper];

5) Load the data:

	[dataSource loadDataWithCallback:^() {
	NSLog(@"%@", dataSource.array.count); // Will output the number of authors of myfancyblog.com
    }];
    
License
-------------------------   
Apache License, Version 2.0
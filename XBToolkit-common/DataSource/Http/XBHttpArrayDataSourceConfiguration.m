//
// Created by akinsella on 24/03/13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "XBHttpArrayDataSourceConfiguration.h"
#import "NSDateFormatter+XBAdditions.h"
#import "XBPaginator.h"


@implementation XBHttpArrayDataSourceConfiguration

+ (XBHttpArrayDataSourceConfiguration *)configuration {
    XBHttpArrayDataSourceConfiguration *configuration = [[self alloc] init];
    configuration.maxDataAgeInSecondsBeforeServerFetch = 120;
    configuration.dateFormat = [NSDateFormatter initWithDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSSZZZ"];

    return configuration;
}

+ (XBHttpArrayDataSourceConfiguration *)configurationWithResourcePath:(NSString *)resourcePath
                                                  storageFileName:(NSString *)storageFileName
                                                        typeClass:(Class)typeClass
                                                      rootKeyPath:(NSString *)rootKeyPath {

    XBHttpArrayDataSourceConfiguration *configuration = [XBHttpArrayDataSourceConfiguration configuration];

    configuration.storageFileName = storageFileName;
    configuration.resourcePath = resourcePath;
    configuration.typeClass = typeClass;
    configuration.rootKeyPath = rootKeyPath;

    return configuration;
}

@end
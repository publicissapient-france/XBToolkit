//
// Created by akinsella on 17/03/13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "DCParserConfiguration+XBAdditions.h"
#import "DCCustomInitialize.h"
#import "DCCustomParser.h"


@implementation DCParserConfiguration (XBAdditions)


-(void) mergeConfig:(DCParserConfiguration *) parserConfiguration {

    for (DCObjectMapping * objectMapping in parserConfiguration.objectMappers) {
        DCArrayMapping * arrayMapping = [parserConfiguration arrayMapperForMapper:objectMapping];
        if (arrayMapping) {
            [self addArrayMapper:arrayMapping];
        }
        else{
            [self addObjectMapping:objectMapping];
        }
    }

    for (DCPropertyAggregator * propertyAggregator in parserConfiguration.aggregators) {
        [self addAggregator:propertyAggregator];
    }

    for (DCCustomInitialize *  customInitialize in parserConfiguration.customInitializers) {
        [self addCustomInitializersObject:customInitialize];
    }

    for (DCCustomParser *  customParser in parserConfiguration.customParsers) {
        [self addCustomParsersObject:customParser];
    }

}

@end
//
// Created by akinsella on 29/03/13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "XBLoadableArrayDataSource.h"
#import "XBArrayDataSource+protected.h"
#import "XBMapper.h"


@implementation XBLoadableArrayDataSource

-(void)setError:(NSError *)error {
    _error = error;
}

-(void)setRootKeyPath:(NSString *)rootKeyPath {
    _rootKeyPath = rootKeyPath;
}

-(void)setTypeClass:(Class)typeClass {
    _typeClass = typeClass;
}

- (void)loadData {
    [self loadDataWithCallback: nil];
}

- (void)loadDataWithCallback:(void (^)())callback {
    if (callback) {
        callback();
    }
}

- (void)loadArrayFromJson:(NSDictionary *)json {
    NSArray *array = self.rootKeyPath ? [json valueForKeyPath:self.rootKeyPath] : json;
    self.array = [XBMapper parseArray:array intoObjectsOfType:self.typeClass];
}

@end
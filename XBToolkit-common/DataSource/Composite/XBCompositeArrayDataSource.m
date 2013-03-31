//
// Created by akinsella on 25/03/13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "XBCompositeArrayDataSource.h"
#import "XBCompositeArrayDataSource+protected.h"
#import "XBArrayDataSource.h"
#import "XBArrayDataSource+protected.h"
#import "XBLoadableArrayDataSource.h"
#import "XBLoadableArrayDataSource+protected.h"

@implementation XBCompositeArrayDataSource {
    XBLoadableArrayDataSource *_firstDataSource;
    XBLoadableArrayDataSource *_secondDataSource;
}

+ (id)dataSourceWithFirstDataSource:(XBLoadableArrayDataSource *)firstDataSource
                   secondDataSource:(XBLoadableArrayDataSource *)secondDataSource {
    return [[self alloc] initWithFirstDataSource:firstDataSource secondDataSource:secondDataSource];
}

- (id)initWithFirstDataSource:(XBLoadableArrayDataSource *)firstDataSource
             secondDataSource:(XBLoadableArrayDataSource *)secondDataSource {
    self = [super init];
    if (self) {
        _firstDataSource = firstDataSource;
        _secondDataSource = secondDataSource;
    }

    return self;
}

- (id)objectAtIndexedSubscript:(NSUInteger)idx {
    return [self.secondDataSource objectAtIndexedSubscript:idx];
}

- (NSUInteger)count {
    return self.secondDataSource.count;
}

- (NSError *)error {
    return self.firstDataSource.error ? self.firstDataSource.error : self.secondDataSource.error;
}

- (NSArray *)array {
    return self.secondDataSource.array;
}

- (void)loadDataWithForceReload:(BOOL)force callback:(void(^)())callback {
    [self.firstDataSource loadDataWithCallback:^{
            if (self.firstDataSource.error) {
                if (callback) {
                    callback();
                }
            }
            else {
                [self.secondDataSource loadDataWithCallback:callback];
            }
    }];
}

@end
#import "XBHttpClient.h"

@interface XBHttpClient (protected)

- (NSString *)URLWithPath:(NSString *)path method:(NSString *)method parameters:(NSDictionary *)parameters;

@end

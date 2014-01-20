#import "XBHttpClient.h"

@interface XBHttpClient (protected)

- (NSString *)URLStringWithPath:(NSString *)path method:(NSString *)method parameters:(NSDictionary *)parameters;

@end

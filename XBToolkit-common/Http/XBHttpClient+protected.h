#import "XBHttpClient.h"

@interface XBHttpClient (protected)

- (NSString *)URLStringWithUrlPath:(NSString *)urlPath method:(NSString *)method parameters:(NSDictionary *)parameters;

@end

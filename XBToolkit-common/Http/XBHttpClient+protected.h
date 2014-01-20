#import "XBHttpClient.h"

@interface XBHttpClient (protected)

@property(nonatomic, strong) NSString *baseUrl;

- (NSString *)URLWithPath:(NSString *)path method:(NSString *)method parameters:(NSDictionary *)parameters
{
    return [[NSURL URLWithString:path relativeToURL:self.HTTPRequestOperationManager.baseURL] absoluteString];
}

@end

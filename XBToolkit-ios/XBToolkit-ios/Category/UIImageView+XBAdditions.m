//
// Created by akinsella on 24/09/12.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "UIImageView+XBAdditions.h"

@implementation UIImageView (XBAdditions)

+(UIImageView *)initWithImageNamed:(NSString *)imageNamed {
    return [[UIImageView alloc] initWithImage:[UIImage imageNamed:imageNamed]];
}

@end
//
//  UIColor+XBAdditions.h
//  xebia-ios
//
//  Created by Alexis Kinsella on 26/08/12.
//
//

#import <UIKit/UIKit.h>

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@interface UIColor (XBAdditions)

+ (UIColor*)colorWithPatternImageName:(NSString *)imageName;

// wrapper for [UIColor colorWithRed:green:blue:alpha:]
// values must be in range 0 - 255
+ (UIColor*)colorWith8BitRed:(NSInteger)red
                       green:(NSInteger)green
                        blue:(NSInteger)blue
                       alpha:(CGFloat)alpha;

+ (UIColor*)colorWithHex:(NSString*)hex;

// Creates color using hex representation
// hex - must be in format: #FF00CC
// alpha - must be in range 0.0 - 1.0
+ (UIColor*)colorWithHex:(NSString*)hex
                   alpha:(CGFloat)alpha;

@end

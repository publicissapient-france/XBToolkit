//
//  UIImage+WPAdditions.h
//  
//
//  Created by Alexis Kinsella on 20/08/12.
//
//

#import <UIKit/UIKit.h>

@interface UIImage (WPAdditions)

-(UIImage*) centerImage:(UIImage *)inImage inRect:(CGRect) thumbRect;

- (UIImage*)imageScaledToSize:(CGSize)size;

+(UIImage *)scale:(UIImage *)image toSize:(CGSize)size;

@end

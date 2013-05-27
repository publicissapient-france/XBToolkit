//
//  UIImage+XBAdditions.m
//  
//
//  Created by Alexis Kinsella on 20/08/12.
//
//
#import <UIKit/UIKit.h>

@implementation UIImage (XBAdditions)

-(UIImage*) centerImage:(UIImage *)inImage inRect:(CGRect) thumbRect {
    
    CGSize size= thumbRect.size;
    UIGraphicsBeginImageContext(size);
    //calculation
    [inImage drawInRect:CGRectMake((size.width-inImage.size.width)/2, (size.height-inImage.size.height)/2, inImage.size.width, inImage.size.height)];
    UIImage *newThumbnail = UIGraphicsGetImageFromCurrentImageContext();
    // pop the context
    UIGraphicsEndImageContext();
    return newThumbnail;
}

- (UIImage*)imageScaledToSize:(CGSize)size {
    UIGraphicsBeginImageContext(size);
    [self drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

+ (UIImage *)scale:(UIImage *)image toSize:(CGSize)size {
    UIGraphicsBeginImageContext(size);
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return scaledImage;
}

@end

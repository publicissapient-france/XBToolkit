//
//  UIStoryboard+XBAdditions.h
//  xebia-ios
//
//  Created by Alexis Kinsella on 06/09/12.
//
//

#import <UIKit/UIKit.h>

@interface UIStoryboard (XBAdditions)

+ (id)instantiateViewControllerWithIdentifier:(NSString *)viewControllerIdentifier
                           storyboardWithName:(NSString *)storyboardName
                                       bundle:(NSBundle *)bundle;

@end

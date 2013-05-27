//
//  UISearchBar+XBAdditions.m
//  xebia-ios
//
//  Created by Alexis Kinsella on 22/08/12.
//
//

#import "UISearchBar+XBAdditions.h"
#import <QuartzCore/QuartzCore.h>

@implementation UISearchBar (XBAdditions)

- (UITextField *)field {
    // HACK: This may not work in future iOS versions
    for (UIView *subview in self.subviews) {
        if ([subview isKindOfClass:[UITextField class]]) {
            return (UITextField *)subview;
        }
    }
    return nil;
}

-(void)removeBackground {
    for (UIView *subview in [self subviews]) {
//        if ([subview isKindOfClass:NSClassFromString(@"UISearchBarBackground")]) {
//            [subview removeFromSuperview];
//        }
//
//        if([subview isMemberOfClass:[UISegmentedControl class]]){
//            UISegmentedControl *scopeBar=(UISegmentedControl *) subview;
//            scopeBar.tintColor =  [UIColor redColor];
//        }
        
//        if ([subview isKindOfClass:NSClassFromString(@"UISearchBarBackground")]) {
//            UIView *bg = [[UIView alloc] initWithFrame:subview.frame];
//            bg.backgroundColor = [UIColor redColor];
//            [self insertSubview:bg aboveSubview:subview];
//            [subview removeFromSuperview];
//            break;
//        }
        
        if ([subview isKindOfClass:NSClassFromString(@"UITextField")]) {
            UITextField *searchField = (UITextField *)subview;
//            [textField setBackground: [UIImage imageNamed:@"menu-cell-bg.png"] ];
            
            searchField.autoresizingMask = UIViewAutoresizingFlexibleWidth;
//            searchField.textColor = [UIColor colorWithRed:0.239 green:0.047 blue:0.192 alpha:1] /*#3d0c31*/;
//            searchField.layer.cornerRadius = 14;
            searchField.borderStyle = UITextBorderStyleRoundedRect;//To change borders to rounded
//            searchField.backgroundColor = [UIColor colorWithRed:0.6 green:0.435 blue:0.58 alpha:1] /*#996f94*/;//To change borders to rounded
//            [searchField setValue:[UIColor colorWithRed:0.443 green:0.306 blue:0.42 alpha:1] /*#714e6b*/
//                            forKeyPath:@"_placeholderLabel.textColor"];
            
//            searchField.layer.borderWidth = 1.0f; //To hide the square corners
//            searchField.layer.borderColor = [[UIColor grayColor] CGColor]; //assigning the default border color
//            UIBarButtonItem *searchFieldItem = [[UIBarButtonItem alloc] initWithCustomView:searchField];
//            [textField setBorderStyle:UITextBorderStyleNone];
        }
    }
}

- (UIColor *)textColor {
    return self.field.textColor;
}

- (void)setTextColor:(UIColor *)color {
    self.field.textColor = color;
}

- (UIColor *)backgroundColor {
    return self.field.backgroundColor;
}

- (void)setBackgroundColor:(UIColor *)color {
    self.field.backgroundColor = color;
}

@end
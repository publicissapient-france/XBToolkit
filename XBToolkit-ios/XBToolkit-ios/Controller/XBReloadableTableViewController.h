//
// Created by akinsella on 05/04/13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>
#import "XBTableViewController.h"


@interface XBReloadableTableViewController : XBTableViewController

- (void)initProgressHUD;

- (void)showProgressHUD;

- (void)showProgressHUDWithMessage:(NSString *)message graceTime:(float)graceTime;

- (void)showErrorProgressHUD;

- (void)showErrorProgressHUDWithMessage:(NSString *)errorMessage afterDelay:(float)delay;

- (void)dismissProgressHUD;

@end
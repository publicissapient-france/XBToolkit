//
// Created by akinsella on 05/04/13.
//
// To change the template use AppCode | Preferences | File Templates.
//

#import "XBReloadableTableViewController.h"
#import "SVPullToRefresh.h"
#import "MBProgressHUD.h"

@interface XBReloadableTableViewController()

@property (nonatomic, strong) MBProgressHUD *progressHUD;

@end


@implementation XBReloadableTableViewController

-(XBReloadableArrayDataSource *)reloadableDataSource {
    return (XBReloadableArrayDataSource *)self.dataSource;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [self initProgressHUD];
}

- (void)configureTableView {
    [super configureTableView];

    __weak typeof(self) weakSelf = self;
    [self.tableView addPullToRefreshWithActionHandler:^{
        [weakSelf loadDataWithProgress:NO callback:^{
            [weakSelf.tableView.pullToRefreshView stopAnimating];
            [weakSelf.tableView reloadData];
        }];
    }];

    self.tableView.pullToRefreshView.arrowColor = [UIColor whiteColor];
    self.tableView.pullToRefreshView.textColor = [UIColor whiteColor];
    self.tableView.pullToRefreshView.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhite;
}

-(void)loadData {
    [self loadDataWithProgress:YES callback:^{
        [self.tableView reloadData];
    }];
}

-(void)loadDataWithProgress:(BOOL)showProgress callback:(void(^)())callback {
    if (showProgress) {
        [self showProgressHUD];
    }
    [self.reloadableDataSource loadDataWithCallback:^() {
        if (self.reloadableDataSource.error) {
            [self showErrorProgressHUD];
        }
        else {
            if (showProgress) {
                [self dismissProgressHUD];
            }
        }

        if (callback) {
            callback();
        }
    }];
}

- (void)initProgressHUD {
    self.progressHUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
}

- (void)showProgressHUD {
    [self showProgressHUDWithMessage:NSLocalizedString(@"Chargement...", @"Chargement...")
                           graceTime:0.5];
    [self.navigationController.view addSubview:self.progressHUD];
}

- (void)showProgressHUDWithMessage:(NSString *)message graceTime:(float)graceTime {
    self.progressHUD.mode = MBProgressHUDModeIndeterminate;
    self.progressHUD.labelText = NSLocalizedString(message, message);
    self.progressHUD.graceTime = graceTime;
    self.progressHUD.taskInProgress = YES;
    [self.navigationController.view addSubview:self.progressHUD];
    [self.progressHUD show:YES];
}

- (void)showErrorProgressHUD {
    [self showErrorProgressHUDWithMessage:NSLocalizedString(@"Erreur pendant le chargement", @"Erreur pendant le chargement")
                               afterDelay:1.0];
}

- (void)showErrorProgressHUDWithMessage:(NSString *)errorMessage afterDelay:(float)delay {
    self.progressHUD.mode = MBProgressHUDModeText;
    self.progressHUD.labelText = errorMessage;
    [self.progressHUD hide:YES afterDelay:delay];
    self.progressHUD.taskInProgress = NO;
    [self.navigationController.view addSubview:self.progressHUD];
}

- (void)dismissProgressHUD {
    self.progressHUD.taskInProgress = NO;
    [self.progressHUD hide:YES];
}

@end
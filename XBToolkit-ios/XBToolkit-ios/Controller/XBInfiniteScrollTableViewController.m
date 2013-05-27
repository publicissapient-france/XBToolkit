//
// Created by akinsella on 05/04/13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "XBInfiniteScrollTableViewController.h"
#import "UIScrollView+SVInfiniteScrolling.h"
#import "XBInfiniteScrollArrayDataSource.h"


@implementation XBInfiniteScrollTableViewController

-(XBInfiniteScrollArrayDataSource *)infiniteScrollDataSource {
    return (XBInfiniteScrollArrayDataSource *)self.dataSource;
}

- (void)configureTableView {
    [super configureTableView];

    __weak typeof(self) weakSelf = self;
    [self.tableView addInfiniteScrollingWithActionHandler:^{
        [weakSelf loadNextPageWithProgress:NO callback:^{
            [weakSelf.tableView.infiniteScrollingView stopAnimating];
            [weakSelf.tableView reloadData];
        }];
    }];

    self.tableView.showsInfiniteScrolling = YES;
}

-(void)loadNextPageWithProgress:(BOOL)showProgress callback:(void(^)())callback {
    if (showProgress) {
        [self showProgressHUD];
    }
    [self.infiniteScrollDataSource loadMoreDataWithCallback:^() {
        if (self.infiniteScrollDataSource.error) {
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

@end
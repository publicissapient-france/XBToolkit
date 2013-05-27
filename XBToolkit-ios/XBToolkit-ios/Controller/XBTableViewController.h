//
// Created by akinsella on 19/12/12.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>
#import "XBHttpClient.h"
#import "XBReloadableArrayDataSource.h"

@protocol XBTableViewControllerDelegate<NSObject>

@required

- (NSString *)cellReuseIdentifier;

- (NSString *)cellNibName;

- (void)configureCell: (UITableViewCell *)cell atIndex:(NSIndexPath *)indexPath;

@optional

-(void)onSelectCell: (UITableViewCell *)cell forObject: (id) object withIndex: (NSIndexPath *)indexPath;

@end

@interface XBTableViewController : UITableViewController<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) id<XBTableViewControllerDelegate> delegate;
@property(nonatomic, strong, readonly) XBArrayDataSource *dataSource;

- (XBArrayDataSource *)buildDataSource;
- (void)configureTableView;
-(void)loadData;

@end

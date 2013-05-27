//
//  XBTableViewController.m
//  xebia-ios
//
//  Created by Alexis Kinsella on 25/07/12.
//  Copyright (c) 2012 Xebia France. All rights reserved.
//

#import "UIColor+XBAdditions.h"
#import "UITableViewCell+VariableHeight.h"
#import "XBToolkit.h"
#import "XBArrayDataSource.h"
#import "XBTableViewController.h"

@interface XBTableViewController()

@property(nonatomic, strong)XBArrayDataSource *dataSource;

@end

@implementation XBTableViewController


-(void)loadData {
    [self.tableView reloadData];
}

-(void)initialize {
    _dataSource = [self buildDataSource];
}

- (XBArrayDataSource *)buildDataSource {
    mustOverride();
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initialize];
    [self configureTableView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self loadData];
}

- (void)configureTableView {
    self.tableView.backgroundColor = [UIColor colorWithPatternImageName:@"bg_home_pattern"];
//    self.tableView.backgroundColor = [UIColor colorWithHex:@"#191919" alpha:1.0];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;

    [self.tableView registerNib:[UINib nibWithNibName:[self.delegate cellNibName] bundle:nil] forCellReuseIdentifier:[self.delegate cellReuseIdentifier]];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:[self.delegate cellReuseIdentifier]];

    if (!cell) {
        // fix for rdar://11549999 (registerNib… fails on iOS 5 if VoiceOver is enabled)
        cell = [[[NSBundle mainBundle] loadNibNamed:[self.delegate cellNibName] owner:self options:nil] objectAtIndex:0];
    }

    [self.delegate configureCell:cell atIndex:indexPath];

    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    UITableViewCell *cell = [self tableView:tableView cellForRowAtIndexPath:indexPath];

    return [cell respondsToSelector:@selector(heightForCell)] ? [cell heightForCell] : self.tableView.rowHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    if ([self.delegate respondsToSelector:@selector(onSelectCell:forObject:withIndex:)]) {
        UITableViewCell *cell = [self tableView:tableView cellForRowAtIndexPath:indexPath];

        [self.delegate onSelectCell:cell forObject:self.dataSource[(NSUInteger)indexPath.row] withIndex:indexPath];
    }
}

- (void)didReceiveMemoryWarning{
    NSLog(@"Did received a memory warning in controller: %@", [self class]);
    [super didReceiveMemoryWarning];
}

@end
//
//  BaseTableViewController.h
//  Demo-ObjC
//
//  Created by wudan on 2020/4/23.
//  Copyright © 2020 wudan. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface BaseTableViewController : BaseViewController<UITableViewDelegate, UITableViewDataSource>
/** TableView */
@property (nonatomic, strong) UITableView *tableView;

#pragma mark - UITableView DataSource Methods
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView;
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;

#pragma mark - UITableView Delegate Methods
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
@end

NS_ASSUME_NONNULL_END

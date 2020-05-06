//
//  SplitMasterViewController.m
//  Demo-ObjC
//
//  Created by wudan on 2020/5/6.
//  Copyright © 2020 wudan. All rights reserved.
//

#import "SplitMasterViewController.h"
#import "SplitContentViewController.h"
@interface SplitMasterViewController ()

@end

@implementation SplitMasterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    self.tableView.frame = self.view.bounds;
}

#pragma mark - UITableView DataSource Methods
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell" forIndexPath:indexPath];
    cell.textLabel.text = [NSString stringWithFormat:@"%ld", indexPath.row + 1];
    return cell;
}

#pragma mark - UITableView Delegate Methods
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    // 小屏幕不支持分屏
    BOOL isLandscape = (UIApplication.sharedApplication.statusBarOrientation == UIInterfaceOrientationLandscapeLeft || UIApplication.sharedApplication.statusBarOrientation == UIInterfaceOrientationLandscapeRight);
    if (isLandscape && UIScreen.mainScreen.bounds.size.height > 375) {
        // 点击直接修改显示内容
        UINavigationController *nav = self.splitViewController.viewControllers.lastObject;
        if (nav.viewControllers.count > 0) {
            [nav.viewControllers.lastObject.navigationController popToRootViewControllerAnimated:YES];
        }
        SplitContentViewController *vc = nav.viewControllers.firstObject;
        vc.contentText = [NSString stringWithFormat:@"%ld", indexPath.row + 1];
    } else {
        // 点击进行push跳转
        SplitContentViewController *vc = [[SplitContentViewController alloc] init];
        vc.contentText = [NSString stringWithFormat:@"%ld", indexPath.row + 1];
        [self.navigationController pushViewController:vc animated:YES];
    }
}
@end

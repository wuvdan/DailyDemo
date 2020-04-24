//
//  HomeViewController.m
//  AllDemo-ObjC
//
//  Created by wudan on 2020/4/23.
//  Copyright © 2020 wudan. All rights reserved.
//

#import "HomeViewController.h"

#import "WDPopMenuShowViewController.h"
#import "WDAlterSheetViewShowViewController.h"
#import "WDComboBoxControlViewController.h"
#import "WDDropViewViewController.h"


@interface HomeViewController ()
@property (nonatomic, copy) NSArray<NSString *> *titleArray;
@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"日常-案例";
    self.titleArray = @[@"PopMenu - 弹窗菜单", @"AlterSheetView - 底部弹窗", @"ComboBoxControl - 分类展开", @"DropView - 下拉分类"];
    [self.view addSubview:self.tableView];
    self.tableView.frame = self.view.bounds;
}

#pragma mark - UITableView DataSource Methods
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.titleArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell" forIndexPath:indexPath];
    cell.textLabel.text = self.titleArray[indexPath.row];
    return cell;
}

#pragma mark - UITableView Delegate Methods
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    switch (indexPath.row) {
        case 0:
        {
            WDPopMenuShowViewController *vc = [[WDPopMenuShowViewController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 1:
        {
            WDAlterSheetViewShowViewController *vc = [[WDAlterSheetViewShowViewController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 2:
        {
            WDComboBoxControlViewController *vc = [[WDComboBoxControlViewController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 3:
        {
            WDDropViewViewController *vc = [[WDDropViewViewController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        default:
            break;
    }
}
@end

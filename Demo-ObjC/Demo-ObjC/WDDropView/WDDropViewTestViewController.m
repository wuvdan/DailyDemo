//
//  WDDropViewTestViewController.m
//  Demo-ObjC
//
//  Created by wudan on 2020/4/24.
//  Copyright © 2020 wudan. All rights reserved.
//

#import "WDDropViewTestViewController.h"

@interface WDDropViewTestViewController ()

@end

@implementation WDDropViewTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
//    [self.view addSubview:self.tableView];
//    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.edges.mas_equalTo(0);
//    }];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
}

@end

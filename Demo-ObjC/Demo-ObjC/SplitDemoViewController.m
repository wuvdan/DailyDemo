//
//  SplitDemoViewController.m
//  Demo-ObjC
//
//  Created by wudan on 2020/5/6.
//  Copyright © 2020 wudan. All rights reserved.
//

#import "SplitDemoViewController.h"

#import "SplitMasterViewController.h"
#import "SplitContentViewController.h"

@interface SplitDemoViewController ()
@property (nonatomic, strong) UIButton *tappdButton;
@end

@implementation SplitDemoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"UISplitViewController - 大屏幕分屏";
    
    self.tappdButton = [[UIButton alloc] init];
    [self.tappdButton setTitle:@"点击跳转" forState:UIControlStateNormal];
    [self.tappdButton setTitleColor:[UIColor systemBlueColor] forState:UIControlStateNormal];
    self.tappdButton.titleLabel.font = [UIFont systemFontOfSize:50 weight:UIFontWeightBold];
    [self.tappdButton addTarget:self action:@selector(handleTappdButtonEvent:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.tappdButton];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    self.tappdButton.frame = self.view.bounds;
}

- (void)handleTappdButtonEvent:(id)sender {
    UISplitViewController *vc = [[UISplitViewController alloc] init];
    vc.preferredDisplayMode = UISplitViewControllerDisplayModeAllVisible;
    // 主控制
    UINavigationController *master = [[UINavigationController alloc] initWithRootViewController:[[SplitMasterViewController alloc] init]];
    // 内容显示控制器
    UINavigationController *content = [[UINavigationController alloc] initWithRootViewController:[[SplitContentViewController alloc] init]];
       
    vc.viewControllers = @[master, content];
    
    [self presentViewController:vc animated:YES completion:nil];
}

@end

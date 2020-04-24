//
//  WDPopMenuShowViewController.m
//  Demo-ObjC
//
//  Created by wudan on 2020/4/24.
//  Copyright © 2020 wudan. All rights reserved.
//

#import "WDPopMenuShowViewController.h"
#import "WDPopMenu.h"

@interface WDPopMenuShowViewController ()
@property (nonatomic, strong) UIButton *leftTopButton;
@property (nonatomic, strong) UIButton *rightTopButton;

@property (nonatomic, strong) UIButton *leftCenterButton;
@property (nonatomic, strong) UIButton *rightCenterButton;

@property (nonatomic, strong) UIButton *centerButton;

@property (nonatomic, strong) UIButton *leftBottomButton;
@property (nonatomic, strong) UIButton *rightBottomButton;
@end

@implementation WDPopMenuShowViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"PopMenu -  弹出菜单";
    
    self.leftTopButton = [self createButton];
    self.rightTopButton = [self createButton];
    self.leftCenterButton = [self createButton];
    self.leftTopButton = [self createButton];
    self.rightCenterButton = [self createButton];
    self.centerButton = [self createButton];
    self.leftBottomButton = [self createButton];
    self.rightBottomButton = [self createButton];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    [self.leftTopButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(15);
        make.top.mas_equalTo(kSafeAreaTopHeight + 15);
    }];
    
    [self.rightTopButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.mas_equalTo(-15);
        make.top.mas_equalTo(kSafeAreaTopHeight + 15);
    }];
    
    [self.leftBottomButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(15);
        make.bottom.mas_equalTo(- kSafeAreaBottomHeight - 15);
    }];
    
    [self.rightBottomButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.mas_equalTo(-15);
        make.bottom.mas_equalTo(- kSafeAreaBottomHeight - 15);
    }];
    
    [self.leftCenterButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(15);
        make.centerY.mas_equalTo(0);
    }];
    
    [self.rightCenterButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.mas_equalTo(-15);
        make.centerY.mas_equalTo(0);
    }];
    
    [self.centerButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(0);
    }];
}

- (void)buttonTargetAction:(UIButton *)sender {
    
    if (CGRectGetMaxY(sender.frame) > kScreenHeight * 0.7) {
        CGPoint point = CGPointMake(CGRectGetMidX(sender.frame), CGRectGetMinY(sender.frame));
        [WDPopMenu showPopMenuWithTitles:@[@"菜单1", @"菜单2", @"菜单3"] originPosition:point selectedItemComplete:^(NSInteger currentIndex) {
            
        }];
    } else {
        CGPoint point = CGPointMake(CGRectGetMidX(sender.frame), CGRectGetMaxY(sender.frame));
        [WDPopMenu showPopMenuWithTitles:@[@"菜单1", @"菜单2", @"菜单3"] originPosition:point selectedItemComplete:^(NSInteger currentIndex) {
            
        }];
    }
}

- (UIButton *)createButton {
    UIButton *b = [UIButton buttonWithType:UIButtonTypeInfoLight];
    [b addTarget:self action:@selector(buttonTargetAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:b];
    return b;
}

@end

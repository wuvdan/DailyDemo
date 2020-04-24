//
//  WDDropViewViewController.m
//  Demo-ObjC
//
//  Created by wudan on 2020/4/24.
//  Copyright © 2020 wudan. All rights reserved.
//

#import "WDDropViewViewController.h"
#import "WDDropView.h"
#import "WDDropViewTestView.h"

@interface WDDropViewViewController ()<WDDropViewDelegate, WDDropViewDataSource>
@property (nonatomic, strong) WDDropView *dropView;
@end

@implementation WDDropViewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.dropView = [[WDDropView alloc] init];
    self.dropView.delegate = self;
    self.dropView.dataSorce = self;
    [self.view addSubview:self.dropView];
    
    [self.view addSubview:self.tableView];
    
    [self.dropView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.mas_equalTo(0);
        make.top.mas_equalTo(kSafeAreaTopHeight);
        make.height.mas_equalTo(45);
    }];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.bottom.trailing.mas_equalTo(0);
        make.top.mas_equalTo(self.dropView.mas_bottom).mas_offset(10);
    }];
}

#pragma mark - LZDropViewDataSource
- (NSArray<NSString *> *)setupCategoryTitleNameInDropView:(WDDropView *)dropView {
    return @[@"全部",
             @"附近",
             @"只能排序",
             @"筛选"];
}

- (NSArray<UIView *> *)setupCategoryViewInDropView:(WDDropView *)dropView {
    return @[[[WDDropViewTestView alloc] init],
             [[WDDropViewTestView alloc] init],
             [[WDDropViewTestView alloc] init],
             [[WDDropViewTestView alloc] init]];
}

- (NSArray<NSNumber *> *)setupCategoryViewHeightInDropView:(WDDropView *)dropView {
    return @[[NSNumber numberWithFloat:300],
             [NSNumber numberWithFloat:400],
             [NSNumber numberWithFloat:410],
             [NSNumber numberWithFloat:420]];
}

#pragma mark - WDDropView Delegate

- (void)dropView:(WDDropView *)dropView didSelectAtColumn:(NSInteger)column info:(NSString *)info {
    NSLog(@"%ld---%@", column, info);
}
@end

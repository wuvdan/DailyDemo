//
//  WDAlterSheetViewShowViewController.m
//  Demo-ObjC
//
//  Created by wudan on 2020/4/24.
//  Copyright © 2020 wudan. All rights reserved.
//

#import "WDAlterSheetViewShowViewController.h"
#import "WDAlterSheetView.h"

@interface WDAlterSheetViewShowViewController ()
@property (nonatomic, strong) UIStackView *stackView;
@property (nonatomic, strong) UIButton *button1;
@property (nonatomic, strong) UIButton *button2;
@property (nonatomic, strong) UIButton *button3;
@property (nonatomic, strong) UIButton *button4;
@end

@implementation WDAlterSheetViewShowViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.button1 = [[UIButton alloc] init];
    [self.button1 setTitle:@"样式一" forState:UIControlStateNormal];
    [self.button1 setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    self.button1.titleLabel.font = [UIFont systemFontOfSize:18];
    [self.button1 addTarget:self action:@selector(buttonTargetAction:) forControlEvents:UIControlEventTouchUpInside];
    
    self.button2 = [[UIButton alloc] init];
    [self.button2 setTitle:@"样式二" forState:UIControlStateNormal];
    [self.button2 setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    self.button2.titleLabel.font = [UIFont systemFontOfSize:18];
    [self.button2 addTarget:self action:@selector(buttonTargetAction:) forControlEvents:UIControlEventTouchUpInside];
    
    self.button3 = [[UIButton alloc] init];
    [self.button3 setTitle:@"样式三" forState:UIControlStateNormal];
    [self.button3 setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    self.button3.titleLabel.font = [UIFont systemFontOfSize:18];
    [self.button3 addTarget:self action:@selector(buttonTargetAction:) forControlEvents:UIControlEventTouchUpInside];
    
    self.button4 = [[UIButton alloc] init];
    [self.button4 setTitle:@"样式四" forState:UIControlStateNormal];
    [self.button4 setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    self.button4.titleLabel.font = [UIFont systemFontOfSize:18];
    [self.button4 addTarget:self action:@selector(buttonTargetAction:) forControlEvents:UIControlEventTouchUpInside];
    
    self.stackView = [[UIStackView alloc] initWithArrangedSubviews:@[self.button1, self.button2, self.button3, self.button4]];
    self.stackView.distribution = UIStackViewDistributionEqualSpacing;
    self.stackView.spacing = 15;
    self.stackView.axis = UILayoutConstraintAxisVertical;
    self.stackView.alignment = UIStackViewAlignmentFill;
    [self.view addSubview:self.stackView];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    [self.stackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(0);
    }];
}

- (void)buttonTargetAction:(UIButton *)sender {
    if ([sender isEqual:self.button1]) {
        [WDAlterSheetView showAlterWithTitleItems:@[@"标题一", @"标题二", @"标题三"] didSelectBlock:^(NSUInteger index) {
            
        }];
    } else if ([sender isEqual:self.button2]) {
        [WDAlterSheetView showAlterWithTitleItems:@[@"保存图片"] cancelText:@"取消" cancelColor:[UIColor redColor] didSelectBlock:^(NSUInteger index) {
            
        }];
    } else if ([sender isEqual:self.button3]) {
        WDAlterSheetModel *m1 = [WDAlterSheetModel setupWithTitle:@"拍摄" titleColor:UIColor.blackColor titleFont:[UIFont systemFontOfSize:16] subTitle:@"照片或视频" subTitleColor:UIColor.lightGrayColor subTitleFont:[UIFont systemFontOfSize:11]];
        WDAlterSheetModel *m2 = [WDAlterSheetModel setupWithTitle:@"从手机相册选择" titleColor:UIColor.blackColor];
        [WDAlterSheetView showAlterWithTitleAttItems:@[m1, m2] didSelectBlock:^(NSUInteger index) {
            
        }];
    } else {
        WDAlterSheetModel *m1 = [WDAlterSheetModel setupWithTitle:@"拍摄" titleColor:UIColor.blackColor titleFont:[UIFont systemFontOfSize:16] subTitle:@"照片或视频" subTitleColor:UIColor.lightGrayColor subTitleFont:[UIFont systemFontOfSize:11]];
        WDAlterSheetModel *m2 = [WDAlterSheetModel setupWithTitle:@"从手机相册选择" titleColor:UIColor.blackColor];
        [WDAlterSheetView showAlterWithTitleAttItems:@[m1, m2] cancelText:@"取消" cancelColor:[UIColor blackColor] didSelectBlock:^(NSUInteger index) {
           
        }];
    }
}
@end

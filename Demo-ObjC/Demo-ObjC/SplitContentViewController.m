//
//  SplitContentViewController.m
//  Demo-ObjC
//
//  Created by wudan on 2020/5/6.
//  Copyright © 2020 wudan. All rights reserved.
//

#import "SplitContentViewController.h"
#import "SplitOtherViewController.h"

@interface SplitContentViewController ()<UINavigationControllerDelegate>
@property (nonatomic, strong) UILabel *textLabel;

@end

@implementation SplitContentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.delegate = self;
    
    self.view.backgroundColor = [UIColor colorWithRed:arc4random_uniform(256.0) / 255.0 green:arc4random_uniform(256.0) / 255.0 blue:arc4random_uniform(256.0) / 255.0 alpha:1];

    self.textLabel = [[UILabel alloc] init];
    self.textLabel.textColor = [UIColor whiteColor];
    self.textLabel.textAlignment = NSTextAlignmentCenter;
    self.textLabel.font = [UIFont systemFontOfSize:100 weight:UIFontWeightMedium];
    [self.view addSubview:self.textLabel];
    self.textLabel.text = self.contentText.length > 0 ? self.contentText : @"1";
}

#pragma mark - UINavigationControllerDelegate
- (void)navigationController:(UINavigationController *)navigationController
      willShowViewController:(UIViewController *)viewController
                    animated:(BOOL)animated {
    
    BOOL isLandscape = (UIApplication.sharedApplication.statusBarOrientation == UIInterfaceOrientationLandscapeLeft ||
                        UIApplication.sharedApplication.statusBarOrientation == UIInterfaceOrientationLandscapeRight);
    // 为了Demo显示好看，分屏时隐藏了内容控制器的导航栏
    if (isLandscape && UIScreen.mainScreen.bounds.size.height > 375) {
        BOOL isShowHomePage = [viewController isKindOfClass:[self class]];
        [self.navigationController setNavigationBarHidden:isShowHomePage animated:YES];
    } else {
        [self.navigationController setNavigationBarHidden:NO animated:YES];
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    SplitOtherViewController *vc = [[SplitOtherViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)setContentText:(NSString *)contentText {
    _contentText = contentText;
    self.textLabel.text = contentText;
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    self.textLabel.frame = self.view.bounds;
}

@end

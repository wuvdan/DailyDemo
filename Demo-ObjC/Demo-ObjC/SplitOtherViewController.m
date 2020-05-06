//
//  SplitOtherViewController.m
//  Demo-ObjC
//
//  Created by wudan on 2020/5/6.
//  Copyright © 2020 wudan. All rights reserved.
//

#import "SplitOtherViewController.h"

@interface SplitOtherViewController ()

@end

@implementation SplitOtherViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:arc4random_uniform(256.0) / 255.0 green:arc4random_uniform(256.0) / 255.0 blue:arc4random_uniform(256.0) / 255.0 alpha:1];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

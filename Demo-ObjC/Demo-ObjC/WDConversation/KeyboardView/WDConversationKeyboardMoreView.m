//
//  WDConversationKeyboardMoreView.m
//  Demo-ObjC
//
//  Created by wudan on 2020/4/26.
//  Copyright © 2020 wudan. All rights reserved.
//

#import "WDConversationKeyboardMoreView.h"

@implementation WDConversationKeyboardMoreView

- (instancetype)init {
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self setupSubViews];
        [self setupLayouts];
    }
    return self;
}

- (UIButton *)createButtonWithTitle:(NSString *)title imageName:(NSString *)imageName {
    UIButton *button = [[UIButton alloc] init];
    [button setTitle:title forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:15];
    [self addSubview:button];
    return button;
}

- (void)setupSubViews {
    self.pictureButton = [self createButtonWithTitle:@"图库" imageName:@""];
    self.takePhotoButton = [self createButtonWithTitle:@"拍摄" imageName:@""];
    self.orderButton = [self createButtonWithTitle:@"订单" imageName:@""];
}

- (void)setupLayouts {
    [self.pictureButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(15);
        make.top.mas_equalTo(kSafeAreaTopHeight);
    }];
    
    [self.takePhotoButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self.pictureButton.mas_trailing).mas_offset(15);
        make.top.mas_equalTo(kSafeAreaTopHeight);
    }];
    
    [self.orderButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self.takePhotoButton.mas_trailing).mas_offset(15);
        make.top.mas_equalTo(kSafeAreaTopHeight);
    }];
}

@end

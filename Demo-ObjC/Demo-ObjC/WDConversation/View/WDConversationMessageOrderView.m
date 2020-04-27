//
//  WDConversationMessageOrderView.m
//  Demo-ObjC
//
//  Created by wudan on 2020/4/26.
//  Copyright © 2020 wudan. All rights reserved.
//

#import "WDConversationMessageOrderView.h"

@implementation WDConversationMessageOrderView

- (instancetype)init {
    self = [super init];
    if (self) {
        [self setupSubviews];
        [self setupLayouts];
    }
    return self;
}

- (void)setupSubviews {
    self.backgroundColor = [UIColor colorWithRed:0.85 green:0.85 blue:0.85 alpha:1];
    self.layer.cornerRadius = 5;
    
    self.pathLabel = [[UILabel alloc] init];
    self.pathLabel.textColor = [UIColor blackColor];
    self.pathLabel.font = [UIFont systemFontOfSize:13];
    [self addSubview:self.pathLabel];
    
    self.beginTimeLabel = [[UILabel alloc] init];
    self.beginTimeLabel.textColor = [UIColor blackColor];
    self.beginTimeLabel.font = [UIFont systemFontOfSize:9];
    [self addSubview:self.beginTimeLabel];
    
    self.endTimeLabel = [[UILabel alloc] init];
    self.endTimeLabel.textColor = [UIColor blackColor];
    self.endTimeLabel.font = [UIFont systemFontOfSize:9];
    [self addSubview:self.endTimeLabel];
    
    self.priceLabel = [[UILabel alloc] init];
    self.priceLabel.textColor = [UIColor blackColor];
    self.priceLabel.font = [UIFont systemFontOfSize:10];
    [self addSubview:self.priceLabel];
}

- (void)setupLayouts {
    [self.pathLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.mas_equalTo(self).inset(5);
        make.top.mas_equalTo(10);
    }];
    
    [self.beginTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.mas_equalTo(self).inset(5);
        make.top.mas_equalTo(self.pathLabel.mas_bottom).mas_offset(8);
    }];
    
    [self.endTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.mas_lessThanOrEqualTo(self.priceLabel.mas_leading).mas_offset(-5);
        make.top.mas_equalTo(self.beginTimeLabel.mas_bottom).mas_offset(8);
        make.leading.mas_equalTo(self).inset(5);
    }];
    
    [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.mas_equalTo(-5);
        make.centerY.mas_equalTo(self.endTimeLabel);
    }];
    
    [self.priceLabel setContentCompressionResistancePriority:950 forAxis:UILayoutConstraintAxisHorizontal];
    [self.endTimeLabel setContentCompressionResistancePriority:940 forAxis:UILayoutConstraintAxisHorizontal];
}

@end

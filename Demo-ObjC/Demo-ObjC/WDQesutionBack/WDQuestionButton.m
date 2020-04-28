//
//  WDQuestionButton.m
//  Demo-ObjC
//
//  Created by wudan on 2020/4/28.
//  Copyright © 2020 wudan. All rights reserved.
//

#import "WDQuestionButton.h"

@implementation WDQuestionButton

- (instancetype)init {
    self = [super init];
    if (self) {
        _logoImageView = [[UIImageView alloc] init];
        _logoImageView.contentMode = UIViewContentModeScaleAspectFit;
        [self addSubview:_logoImageView];
        
        _arrowImageView = [[UIImageView alloc] init];
        _arrowImageView.contentMode = UIViewContentModeScaleAspectFit;
        [self addSubview:_arrowImageView];
        
        _textLabel = [[UILabel alloc] init];
        _textLabel.textAlignment = NSTextAlignmentCenter;
        _textLabel.font = [UIFont systemFontOfSize:15];
        _textLabel.textColor = [UIColor blackColor];
        [self addSubview:_textLabel];
        
        _rightBorder = [[UIView alloc] init];
        _rightBorder.backgroundColor = [UIColor lightGrayColor];
        [self addSubview:_rightBorder];

        [_logoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.trailing.mas_equalTo(0);
            make.top.mas_equalTo(10);
        }];
        
        [_textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.trailing.mas_equalTo(0);
            make.top.mas_equalTo(_logoImageView.mas_bottom).mas_offset(10);
        }];
        
        [_arrowImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.trailing.mas_equalTo(0);
            make.top.mas_equalTo(_textLabel.mas_bottom).mas_offset(0);
        }];
        
        [_rightBorder mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.trailing.bottom.mas_equalTo(0);
            make.width.mas_equalTo(0.5);
        }];
    }
    return self;
}

@end

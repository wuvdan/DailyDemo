//
//  WDQuestionListButton.m
//  Demo-ObjC
//
//  Created by wudan on 2020/4/28.
//  Copyright © 2020 wudan. All rights reserved.
//

#import "WDQuestionListButton.h"

@implementation WDQuestionListButton
- (instancetype)init {
    self = [super init];
    if (self) {
        _textLabel = [[UILabel alloc] init];
        _textLabel.font = [UIFont systemFontOfSize:15];
        _textLabel.textColor = [UIColor blackColor];
        [self addSubview:_textLabel];
        
        _topBorder = [[UIView alloc] init];
        _topBorder.backgroundColor = [UIColor lightGrayColor];
        [self addSubview:_topBorder];

        [_textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.trailing.mas_equalTo(self).inset(5);
            make.centerY.mas_equalTo(0);
        }];
    
        [_topBorder mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.trailing.top.mas_equalTo(0);
            make.height.mas_equalTo(0.5);
        }];
    }
    return self;
}

@end

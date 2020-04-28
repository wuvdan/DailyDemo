//
//  WDCommonQuestionListTableViewCell.m
//  Demo-ObjC
//
//  Created by wudan on 2020/4/28.
//  Copyright © 2020 wudan. All rights reserved.
//

#import "WDCommonQuestionListTableViewCell.h"
#import "WDQuestionListButton.h"

@implementation WDCommonQuestionListTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _bottomLineView = [[UIView alloc] init];
        _bottomLineView.backgroundColor = [UIColor lightGrayColor];
        [self.contentView addSubview:_bottomLineView];
        
        _questionButton = [[WDQuestionButton alloc] init];
        [self.contentView addSubview:_questionButton];

        [_questionButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.top.mas_equalTo(0);
            make.width.mas_equalTo(kScreenWidth * 0.2);
            make.bottom.mas_equalTo(0);
        }];
        
        [_bottomLineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.trailing.bottom.mas_equalTo(0);
            make.height.mas_equalTo(0.5);
        }];
    }
    return self;
}

- (void)setQuestionsList:(NSArray<NSString *> *)questionsList {
    _questionsList = questionsList;
    
    for (UIView *button in self.contentView.subviews) {
        if ([button isKindOfClass:[WDQuestionListButton class]]) {
            [button removeFromSuperview];
        }
    }
    
    [questionsList enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        WDQuestionListButton *v = [[WDQuestionListButton alloc] init];
        v.textLabel.text = obj;
        v.topBorder.hidden = idx == 0;
        [self.contentView addSubview:v];
        v.frame = CGRectMake(kScreenWidth * 0.2, 50 * idx, kScreenWidth * 0.8, 50);
    }];
}

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end

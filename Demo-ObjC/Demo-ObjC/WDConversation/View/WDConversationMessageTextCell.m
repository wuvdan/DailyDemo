//
//  WDConversationMessageTextCell.m
//  Demo-ObjC
//
//  Created by wudan on 2020/4/26.
//  Copyright © 2020 wudan. All rights reserved.
//

#import "WDConversationMessageTextCell.h"

@implementation WDConversationMessageTextCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupSubviews];
    }
    return self;
}

- (void)setupSubviews {
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.backgroundColor = [UIColor clearColor];
    self.contentView.backgroundColor = [UIColor clearColor];
    
    self.headerImageView = [[UIImageView alloc] init];
    self.headerImageView.backgroundColor = [UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:1];
    self.headerImageView.contentMode = UIViewContentModeScaleAspectFill;
    self.headerImageView.clipsToBounds = YES;
    self.headerImageView.layer.cornerRadius = kMessageHeaderSize.width / 2;
    self.headerImageView.layer.masksToBounds = YES;
    [self.contentView addSubview:self.headerImageView];
    
    self.labelContentView = [[UIView alloc] init];
    self.labelContentView.backgroundColor = kRGBColor(109, 156, 248);
    self.labelContentView.layer.cornerRadius = 5;
    [self.contentView addSubview:self.labelContentView];
    
    self.contentTextLabel = [[UILabel alloc] init];
    self.contentTextLabel.textColor = [UIColor whiteColor];
    self.contentTextLabel.font = [UIFont systemFontOfSize:13 weight:UIFontWeightMedium];
    self.contentTextLabel.numberOfLines = 0;
    [self.contentView addSubview:self.contentTextLabel];
}

- (void)setMessageDirectionTypeSend:(WDConversationMessageDirectionType)messageDirectionTypeSend {
    _messageDirectionTypeSend = messageDirectionTypeSend;
    if (messageDirectionTypeSend == WDConversationMessageDirectionTypeRecive) {
        [self.headerImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.height.mas_equalTo(40);
            make.leading.mas_equalTo(15);
            make.top.mas_equalTo(0);
        }];
    
        [self.contentTextLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.mas_equalTo(self.headerImageView.mas_trailing).mas_offset(20);
            make.top.mas_equalTo(5);
            make.width.mas_lessThanOrEqualTo(kScreenWidth * 0.7);
            make.bottom.mas_equalTo(-10);
        }];
    } else {
        [self.headerImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.height.mas_equalTo(40);
            make.trailing.mas_equalTo(-15);
            make.top.mas_equalTo(0);
        }];
        
        [self.contentTextLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.trailing.mas_equalTo(self.headerImageView.mas_leading).mas_offset(-20);
            make.top.mas_equalTo(5);
            make.width.mas_lessThanOrEqualTo(kScreenWidth * 0.7);
            make.bottom.mas_equalTo(-10);
        }];
    }
    
    [self.labelContentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self.contentTextLabel).mas_offset(-10);
        make.trailing.mas_equalTo(self.contentTextLabel).mas_offset(10);
        make.top.mas_equalTo(self.contentTextLabel).mas_offset(-5);
        make.bottom.mas_equalTo(self.contentTextLabel).mas_offset(5);
    }];
}

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end

//
//  WDConversationMessageTextCell.h
//  Demo-ObjC
//
//  Created by wudan on 2020/4/26.
//  Copyright © 2020 wudan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WDConversationMessageConstant.h"
NS_ASSUME_NONNULL_BEGIN

@interface WDConversationMessageTextCell : UITableViewCell
@property (nonatomic, assign) WDConversationMessageDirectionType messageDirectionTypeSend;
@property (nonatomic, strong) UIImageView *headerImageView;
@property (nonatomic, strong) UILabel *contentTextLabel;
@property (nonatomic, strong) UIView *labelContentView;
@end

NS_ASSUME_NONNULL_END

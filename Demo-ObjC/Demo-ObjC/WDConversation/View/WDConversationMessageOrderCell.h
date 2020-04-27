//
//  WDConversationMessageOrderCell.h
//  Demo-ObjC
//
//  Created by wudan on 2020/4/26.
//  Copyright © 2020 wudan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WDConversationMessageConstant.h"
#import "WDConversationMessageOrderView.h"
NS_ASSUME_NONNULL_BEGIN

@interface WDConversationMessageOrderCell : UITableViewCell
@property (nonatomic, assign) WDConversationMessageDirectionType messageDirectionTypeSend;
@property (nonatomic, strong) UIImageView *headerImageView;
@property (nonatomic, strong) WDConversationMessageOrderView *contentOrderView;
@end

NS_ASSUME_NONNULL_END

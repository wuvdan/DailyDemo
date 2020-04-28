//
//  WDCommonQuestionListTableViewCell.h
//  Demo-ObjC
//
//  Created by wudan on 2020/4/28.
//  Copyright © 2020 wudan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WDQuestionButton.h"
NS_ASSUME_NONNULL_BEGIN

@interface WDCommonQuestionListTableViewCell : UITableViewCell
@property (nonatomic, strong) UIView *bottomLineView;
@property (nonatomic, strong) WDQuestionButton *questionButton;
@property (nonatomic, copy) NSArray<NSString *> *questionsList;
@end

NS_ASSUME_NONNULL_END

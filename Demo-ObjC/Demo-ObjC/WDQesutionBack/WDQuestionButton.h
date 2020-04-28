//
//  WDQuestionButton.h
//  Demo-ObjC
//
//  Created by wudan on 2020/4/28.
//  Copyright © 2020 wudan. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface WDQuestionButton : UIControl
@property (nonatomic, strong) UIView *rightBorder;
@property (nonatomic, strong) UILabel *textLabel;
@property (nonatomic, strong) UIImageView *logoImageView;
@property (nonatomic, strong) UIImageView *arrowImageView;
@end

NS_ASSUME_NONNULL_END

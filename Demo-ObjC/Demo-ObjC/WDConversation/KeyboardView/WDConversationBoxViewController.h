//
//  WDConversationBoxViewController.h
//  Demo-ObjC
//
//  Created by wudan on 2020/4/26.
//  Copyright © 2020 wudan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WDConversationKeyboardView.h"
#import "WDConversationKeyboardMoreView.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, WDChatBoxStatus) {
    WDChatBoxStatusNothing,     // 默认状态
    WDChatBoxStatusMore,    // 显示“更多”页面状态
    WDChatBoxStatusShowKeyboard// 正常键盘
};


@class WDConversationBoxViewController;

@protocol WDConversationBoxViewControllerDelegate <NSObject>

/** 文字高度改变 */
- (void)chatBoxViewController:(WDConversationBoxViewController *)chatboxViewController
      didChangeTextViewHeight:(CGFloat)height;

/** 键盘弹起与收起 */
- (void)chatBoxViewController:(WDConversationBoxViewController *)chatboxViewController
        didChangeChatBoxHeight:(CGFloat)height;

/** 键盘发送按钮点击 */
- (void)chatBoxViewController:(WDConversationBoxViewController *)chatboxViewController
               sendTextMessage:(NSString *)messageStr;

/** 发送图片 */
- (void)chatBoxViewController:(WDConversationBoxViewController *)chatboxViewController
              sendImageMessage:(UIImage *)image
                     imagePath:(NSString *)imgPath;
@end

@interface WDConversationBoxViewController : UIViewController
@property(nonatomic, weak) id<WDConversationBoxViewControllerDelegate>delegate;
@property (nonatomic, strong) WDConversationKeyboardView *keybordView;
@property (nonatomic, strong) WDConversationKeyboardMoreView *moreView;
@end

NS_ASSUME_NONNULL_END

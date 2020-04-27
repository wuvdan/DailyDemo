//
//  WDConversationKeyboardView.h
//  Demo-ObjC
//
//  Created by wudan on 2020/4/26.
//  Copyright © 2020 wudan. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class WDConversationKeyboardView;

@protocol WDConversationKeyboardViewDelegate <NSObject>
- (void)conversationKeyboardView:(WDConversationKeyboardView *)view textViewFrameDidChanged:(UITextView *)textView;
- (void)conversationKeyboardView:(WDConversationKeyboardView *)view textViewDidChanged:(NSString *)text;
- (void)conversationKeyboardView:(WDConversationKeyboardView *)view sendText:(NSString *)text;
- (void)conversationKeyboardViewButtonDidTapped:(WDConversationKeyboardView *)view;
@end

@interface WDConversationKeyboardView : UIView
@property (nonatomic, weak) id<WDConversationKeyboardViewDelegate> delegate;
@property (nonatomic, strong) UITextView *textView;
@property (nonatomic, strong) UIButton *addButton;

@end

NS_ASSUME_NONNULL_END

//
//  WDConversationBoxViewController.m
//  Demo-ObjC
//
//  Created by wudan on 2020/4/26.
//  Copyright © 2020 wudan. All rights reserved.
//

#import "WDConversationBoxViewController.h"

@interface WDConversationBoxViewController ()<WDConversationKeyboardViewDelegate>
@property (nonatomic, assign) CGRect keyboardFrame;
@end

@implementation WDConversationBoxViewController


- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillChangeFrameNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.keybordView = [[WDConversationKeyboardView alloc] init];
    self.keybordView.delegate = self;
    self.keybordView.frame = CGRectMake(0, 0, kScreenWidth, kTabbarHeight);
    [self.view addSubview:self.keybordView];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardFrameWillChange:) name:UIKeyboardWillChangeFrameNotification object:nil];
    
    self.moreView = [[WDConversationKeyboardMoreView alloc] init];
    self.moreView.frame = CGRectMake(0, kScreenHeight, kScreenWidth, kScreenWidth / 2);
    [self.view addSubview:self.moreView];
}

- (void)conversationKeyboardView:(WDConversationKeyboardView *)view textViewFrameDidChanged:(nonnull UITextView *)textView {

    float textViewHeight =  [textView sizeThatFits:CGSizeMake(textView.frame.size.width, MAXFLOAT)].height;
    CGRect frame = textView.frame;
    frame.size.height = textViewHeight;
    textView.frame = frame;
    self.keybordView.frame = CGRectMake(0, 0, kScreenWidth, frame.size.height + 10);
    
    if (_delegate && [_delegate respondsToSelector:@selector(chatBoxViewController:didChangeTextViewHeight:)]) {
        [_delegate chatBoxViewController:self didChangeTextViewHeight:self.keybordView.frame.size.height];
    }
}

- (void)conversationKeyboardView:(WDConversationKeyboardView *)view textViewDidChanged:(NSString *)text {

}

- (void)conversationKeyboardView:(WDConversationKeyboardView *)view sendText:(NSString *)text {
    
}

- (void)conversationKeyboardViewButtonDidTapped:(WDConversationKeyboardView *)view {
    [self.keybordView.textView resignFirstResponder];
    
    self.keyboardFrame = CGRectZero;
    if (_delegate && [_delegate respondsToSelector:@selector(chatBoxViewController:didChangeChatBoxHeight:)]) {
        [_delegate chatBoxViewController:self didChangeChatBoxHeight:kScreenWidth / 2];
    }
    
    [UIView animateWithDuration:0.35 animations:^{
        self.moreView.frame = CGRectMake(0, kTabbarHeight, kScreenWidth, kScreenWidth / 2);
    }];
}

- (void)keyboardWillHide:(NSNotification *)notification {
    self.keyboardFrame = CGRectZero;
    if (_delegate && [_delegate respondsToSelector:@selector(chatBoxViewController:didChangeChatBoxHeight:)]) {
        [_delegate chatBoxViewController:self didChangeChatBoxHeight:kTabbarHeight];
    }
}

- (void)keyboardFrameWillChange:(NSNotification *)notification {
    self.keyboardFrame = [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    if (_delegate && [_delegate respondsToSelector:@selector(chatBoxViewController:didChangeChatBoxHeight:)]) {
        [_delegate chatBoxViewController:self didChangeChatBoxHeight: self.keyboardFrame.size.height];
    }
}


@end

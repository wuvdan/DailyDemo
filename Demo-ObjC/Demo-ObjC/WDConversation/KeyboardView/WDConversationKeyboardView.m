//
//  WDConversationKeyboardView.m
//  Demo-ObjC
//
//  Created by wudan on 2020/4/26.
//  Copyright © 2020 wudan. All rights reserved.
//

#import "WDConversationKeyboardView.h"

@interface WDConversationKeyboardView () <UITextViewDelegate>

@end

@implementation WDConversationKeyboardView
- (instancetype)init {
    self = [super init];
    if (self) {
        [self setupSubViews];
    }
    return self;
}

- (void)setupSubViews {
    self.backgroundColor = kRGBColor(243, 243, 243);
    
    self.textView = [[UITextView alloc] init];
    self.textView.delegate = self;
    self.textView.layer.cornerRadius = 5;
    self.textView.layer.borderWidth = 0.5;
    self.textView.font = [UIFont systemFontOfSize:15];
    self.textView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.textView.returnKeyType = UIReturnKeySend;
    [self addSubview:self.textView];
    
    self.addButton = [[UIButton alloc] init];
    [self.addButton setTitle:@"+" forState:UIControlStateNormal];
    [self.addButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.addButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [self.addButton addTarget:self action:@selector(addButtonTargetAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.addButton];
}

- (void)addButtonTargetAction:(id)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(conversationKeyboardViewButtonDidTapped:)]) {
        [self.delegate conversationKeyboardViewButtonDidTapped:self];
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.textView.frame = CGRectMake(15, 5, kScreenWidth - 15 - 30 - 15, CGRectGetHeight(self.bounds) - 10);
    self.addButton.frame = CGRectMake(kScreenWidth - 15 - 30, CGRectGetHeight(self.bounds) - 30 - 10, 30, 30);
}

- (void)textViewDidChange:(UITextView *)textView {
    if (self.delegate && [self.delegate respondsToSelector:@selector(conversationKeyboardView:textViewDidChanged:)]) {
        [self.delegate conversationKeyboardView:self textViewDidChanged:self.textView.text];
    }
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(conversationKeyboardView:textViewFrameDidChanged:)]) {
        [self.delegate conversationKeyboardView:self textViewFrameDidChanged:self.textView];
    }
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    if ([text isEqualToString:@"\n"]){ //判断输入的字是否是回车，即按下return
        if (self.delegate && [self.delegate respondsToSelector:@selector(conversationKeyboardView:sendText:)]) {
            [self.delegate conversationKeyboardView:self sendText:self.textView.text];
        }
        return NO;
    }
    return YES;
}

@end

//
//  WDDropView.m
//  Demo-ObjC
//
//  Created by wudan on 2020/4/24.
//  Copyright © 2020 wudan. All rights reserved.
//

#import "WDDropView.h"

NSString *kDropViewNotificationName = @"com.notification.name.WDDropView";

@interface WDDropView ()

@property (nonatomic, strong) NSArray<UIView *> *viewArray;
@property (nonatomic, strong) NSArray<NSString *> *titleArray;
@property (nonatomic, strong) UIButton *containerView;
@property (nonatomic, strong) UIView *backView;
@property (nonatomic, strong) NSArray<NSNumber *> *controllerHeightArray;
@property (nonatomic, strong) NSMutableArray<UIButton *> *buttonArray;
@property (nonatomic, assign) NSUInteger currentButtonTag;
@property (nonatomic, assign) BOOL hasShowView;
@end

@implementation WDDropView

#pragma mark - Release memory

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - Initialization

- (instancetype)init {
    self = [super init];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notificationAction:) name:kDropViewNotificationName object:nil];
        self.backgroundColor = [UIColor whiteColor];
        self.hasShowView = NO;
    }
    return self;
}

#pragma mark - Draw the page

- (void)setupTitleButton:(NSArray<NSString *> *)array {
    CGFloat width = UIScreen.mainScreen.bounds.size.width / array.count;
    self.buttonArray = [NSMutableArray array];
    for (NSString *name in array) {
        NSInteger index = [array indexOfObject:name];
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.titleLabel.font = [UIFont systemFontOfSize:15];
        [button setTitle:[NSString stringWithFormat:@"%@ ▼", name] forState:UIControlStateNormal];
        [button setTitle:[NSString stringWithFormat:@"%@ ▲", name] forState:UIControlStateSelected];
        [button setTitleColor:UIColor.grayColor forState:UIControlStateNormal];
        [button setTitleColor:UIColor.orangeColor forState:UIControlStateSelected];
        button.frame = CGRectMake(width * index, 0, width, 45);
        button.tag = index;
        [button addTarget:self action:@selector(buttonTouched:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
        [self.buttonArray addObject:button];
    }
}

#pragma mark - Button click event

- (void)buttonTouched:(UIButton *)sender {
    if (self.hasShowView) {
        [self.containerView removeFromSuperview];
        [self.viewArray[self.currentButtonTag] removeFromSuperview];
        [self openControllerViewWithButton:sender];
    } else {
        if (sender.selected) {
            [self closeControllerView];
        } else {
            [self openControllerViewWithButton:sender];
        }
    }
}

- (void)backButtonTouched:(UIButton *)sender {
    [self closeControllerView];
}

#pragma mark - Notification event

- (void)notificationAction:(NSNotification *)notification {
    if (![self.viewArray containsObject:notification.object]) {
        return;
    }
    
    NSInteger index = [self.viewArray indexOfObject:notification.object];
    UIButton *button = self.buttonArray[index];
    [button setTitle:[NSString stringWithFormat:@"%@ ▼", notification.userInfo.allValues.firstObject] forState:UIControlStateNormal];
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(dropView:didSelectAtColumn:info:)]) {
        [self.delegate dropView:self didSelectAtColumn:index info:notification.userInfo.allValues.firstObject];
    }
    
    [self closeControllerView];
}

#pragma mark - Close all controllers.

- (void)closeControllerView {
    [self endAnimations];
    
    for (UIButton *button in self.buttonArray) {
        button.selected = false;
    }
}

#pragma mark - Open the corresponding controller.

- (void)openControllerViewWithButton:(UIButton *)sender {
    
    self.currentButtonTag = sender.tag;
    
    self.containerView.frame = CGRectMake(0, CGRectGetMaxY(self.frame), UIScreen.mainScreen.bounds.size.width, UIScreen.mainScreen.bounds.size.height - CGRectGetMaxY(self.frame));
    
    [self.superview addSubview:self.containerView];
    [self.superview addSubview:self.viewArray[self.currentButtonTag]];
    
    for (UIButton *button in self.buttonArray) {
        button.selected = false;
    }
    
    [self beginAnimations];
    sender.selected = true;
}

// 展开动画
- (void)beginAnimations {
    self.hasShowView = YES;
    CGFloat vcHeight = [self.controllerHeightArray[self.currentButtonTag] floatValue];
        
    self.viewArray[self.currentButtonTag].frame = CGRectMake(0, CGRectGetMaxY(self.frame), UIScreen.mainScreen.bounds.size.width, 0);
    self.viewArray[self.currentButtonTag].clipsToBounds = YES;
    self.containerView.backgroundColor = [UIColor colorWithWhite:0 alpha:0];
        
    [UIView animateWithDuration:0.35 delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        self.viewArray[self.currentButtonTag].frame = CGRectMake(0, CGRectGetMaxY(self.frame), UIScreen.mainScreen.bounds.size.width, vcHeight);
        self.containerView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.4];
    } completion:^(BOOL finished) {

    }];
}
 
// 收起动画
- (void)endAnimations {
    self.hasShowView = NO;
    [UIView animateWithDuration:0.35 delay:0 options:UIViewAnimationOptionOverrideInheritedOptions animations:^{
        self.containerView.backgroundColor = [UIColor colorWithWhite:0 alpha:0];
        self.viewArray[self.currentButtonTag].frame = CGRectMake(0, CGRectGetMaxY(self.frame), UIScreen.mainScreen.bounds.size.width, 0);
    } completion:^(BOOL finished) {
        [self.containerView removeFromSuperview];
        [self.viewArray[self.currentButtonTag] removeFromSuperview];
    }];
}

#pragma mark - Getter

- (UIButton *)containerView {
    if (!_containerView) {
        _containerView = [[UIButton alloc] init];
        [_containerView addTarget:self action:@selector(backButtonTouched:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _containerView;
}

#pragma mark - Setter

- (void)setDataSorce:(id<WDDropViewDataSource>)dataSorce {
    _dataSorce = dataSorce;
    
    if (self.dataSorce && [self.dataSorce respondsToSelector:@selector(setupCategoryViewInDropView:)]){
        self.viewArray = [self.dataSorce setupCategoryViewInDropView:self];
    }
    
    if (self.dataSorce && [self.dataSorce respondsToSelector:@selector(setupCategoryTitleNameInDropView:)]){
        self.titleArray = [self.dataSorce setupCategoryTitleNameInDropView:self];
        [self setupTitleButton:self.titleArray];
    }
    
    if (self.dataSorce && [self.dataSorce respondsToSelector:@selector(setupCategoryViewHeightInDropView:)]) {
        self.controllerHeightArray = [self.dataSorce setupCategoryViewHeightInDropView:self];
    }
    
    if (self.viewArray.count != self.titleArray.count ||
        self.viewArray.count != self.controllerHeightArray.count) {
        @throw [NSException exceptionWithName:NSStringFromClass([self class]) reason:@"The number of corresponding arrays is inconsistent." userInfo:nil];
    }
}

@end

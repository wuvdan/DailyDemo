//
//  WDUserTakeScreenShotView.m
//  Demo-ObjC
//
//  Created by wudan on 2020/4/28.
//  Copyright © 2020 wudan. All rights reserved.
//

#import "WDUserTakeScreenShotView.h"

@interface WDUserTakeScreenShotView ()
@property (nonatomic, copy) DidJumpToSubmitQuestionBlock submitQuestionBlock;
@property (nonatomic, strong) UIImageView *screenImageView;
@property (nonatomic, strong) UIButton *submitQuestionButton;
@property (nonatomic, weak) NSTimer *timer;

@end

@implementation WDUserTakeScreenShotView
// 截取当前屏幕
- (NSData *)dataWithScreenshotInPNGFormat {
    CGSize imageSize = CGSizeZero;
    UIInterfaceOrientation orientation = [UIApplication sharedApplication].statusBarOrientation;
    if (UIInterfaceOrientationIsPortrait(orientation)) {
        imageSize = [UIScreen mainScreen].bounds.size;
    } else {
        imageSize = CGSizeMake([UIScreen mainScreen].bounds.size.height, [UIScreen mainScreen].bounds.size.width);
    }
         
    UIGraphicsBeginImageContextWithOptions(imageSize, NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    for (UIWindow *window in [[UIApplication sharedApplication] windows]) {
        CGContextSaveGState(context);
        CGContextTranslateCTM(context, window.center.x, window.center.y);
        CGContextConcatCTM(context, window.transform);
        CGContextTranslateCTM(context, -window.bounds.size.width * window.layer.anchorPoint.x, -window.bounds.size.height * window.layer.anchorPoint.y);
        if (orientation == UIInterfaceOrientationLandscapeLeft) {
            CGContextRotateCTM(context, M_PI_2);
            CGContextTranslateCTM(context, 0, -imageSize.width);
        } else if (orientation == UIInterfaceOrientationLandscapeRight) {
            CGContextRotateCTM(context, -M_PI_2);
            CGContextTranslateCTM(context, -imageSize.height, 0);
        } else if (orientation == UIInterfaceOrientationPortraitUpsideDown) {
            CGContextRotateCTM(context, M_PI);
            CGContextTranslateCTM(context, -imageSize.width, -imageSize.height);
        }
        
        if ([window respondsToSelector:@selector(drawViewHierarchyInRect:afterScreenUpdates:)]) {
            [window drawViewHierarchyInRect:window.bounds afterScreenUpdates:YES];
        } else {
            [window.layer renderInContext:context];
        }
        CGContextRestoreGState(context);
    }
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return UIImagePNGRepresentation(image);
}

//返回截取到的图片
- (UIImage *)imageWithScreenshot {
    NSData *imageData = [self dataWithScreenshotInPNGFormat];
    return [UIImage imageWithData:imageData];
}

- (instancetype)init {
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.frame = [[UIScreen mainScreen] bounds];
        [self addTarget:self action:@selector(hidenView) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

+ (void)showView:(DidJumpToSubmitQuestionBlock)goToSubmitQuestionBlock {
    WDUserTakeScreenShotView *view = [[WDUserTakeScreenShotView alloc] init];
    view.submitQuestionBlock = goToSubmitQuestionBlock;
    [view showView];
}

- (void)showView {
    self.screenImageView.image = [self imageWithScreenshot];
    [self addSubview:self.screenImageView];
    [self addSubview:self.submitQuestionButton];
    [UIApplication.sharedApplication.keyWindow addSubview:self];
    [self startTimer];
}

- (void)hidenView {
    [self removeFromSuperview];
}

#pragma mark - Timer

- (void)startTimer {
    __weak typeof(self) weakself = self;
    self.timer = [NSTimer scheduledTimerWithTimeInterval:5 repeats:NO block:^(NSTimer * _Nonnull timer) {
        [weakself hidenView];
        [weakself endTimer];
    }];
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}

- (void)endTimer {
    [self.timer invalidate];
    self.timer = nil;
}

#pragma mark - Target Action

- (void)submitQuestionButtonTargetAction:(UIButton *)sender {
    if (self.submitQuestionBlock) {
        self.submitQuestionBlock(self.screenImageView.image);
    }
    [self hidenView];
}

#pragma mark - Getter

- (UIImageView *)screenImageView {
    if (!_screenImageView) {
        _screenImageView = [[UIImageView alloc] init];
        _screenImageView.layer.borderColor = [UIColor systemBlueColor].CGColor;
        _screenImageView.layer.borderWidth = 1;
        _screenImageView.frame = CGRectMake(kScreenWidth * 0.6 - 15, UIApplication.sharedApplication.statusBarFrame.size.height, kScreenWidth * 0.4, kScreenHeight * 0.4);
    }
    return _screenImageView;
}

- (UIButton *)submitQuestionButton {
    if (!_submitQuestionButton) {
        _submitQuestionButton = [[UIButton alloc] init];
        [_submitQuestionButton setTitle:@"意见反馈" forState:UIControlStateNormal];
        [_submitQuestionButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _submitQuestionButton.titleLabel.font = [UIFont systemFontOfSize:18];
        _submitQuestionButton.backgroundColor = [UIColor systemBlueColor];
        [_submitQuestionButton addTarget:self action:@selector(submitQuestionButtonTargetAction:) forControlEvents:UIControlEventTouchUpInside];
        _submitQuestionButton.frame = CGRectMake(kScreenWidth * 0.6 - 15, CGRectGetMaxY(self.screenImageView.frame), kScreenWidth * 0.4, 55);
    }
    return _submitQuestionButton;
}

@end

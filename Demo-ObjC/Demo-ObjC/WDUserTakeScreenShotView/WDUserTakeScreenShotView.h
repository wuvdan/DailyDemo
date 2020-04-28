//
//  WDUserTakeScreenShotView.h
//  Demo-ObjC
//
//  Created by wudan on 2020/4/28.
//  Copyright © 2020 wudan. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^DidJumpToSubmitQuestionBlock)(UIImage *image);

@interface WDUserTakeScreenShotView : UIControl
+ (void)showView:(DidJumpToSubmitQuestionBlock)goToSubmitQuestionBlock;
@end

NS_ASSUME_NONNULL_END

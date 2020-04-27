//
//  WDConversationModel.m
//  Demo-ObjC
//
//  Created by wudan on 2020/4/26.
//  Copyright © 2020 wudan. All rights reserved.
//

#import "WDConversationModel.h"
#import <UIKit/UIKit.h>

@implementation WDConversationOrderModel

@end


@implementation WDConversationModel
- (CGFloat)getContentHeight {
    if (self.contentText.length != 0 && self.imagePath.length == 0 && self.orderModel == nil) {
        if ([self calculationTextHeight:self.contentText] <= kMessageHeaderSize.height) {
            return kMessageHeaderSize.height;
        } else {
            return [self calculationTextHeight:self.contentText];
        }
    } else if (self.contentText.length == 0 && self.imagePath.length == 0 && self.orderModel != nil) {
        return [self calculationOrderHeight:self.orderModel];
    } else {
        return kScreenWidth * 0.35;
    }
}

- (CGFloat)calculationTextHeight:(NSString *)text {
    return [text boundingRectWithSize:kMessageTextMaxSize options:(NSStringDrawingUsesLineFragmentOrigin) attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13 weight:UIFontWeightMedium]} context:nil].size.height + 20;
}

- (CGFloat)calculationOrderHeight:(WDConversationOrderModel *)model {
    CGFloat path = [model.path boundingRectWithSize:kMessageOrderMaxSize options:(NSStringDrawingUsesLineFragmentOrigin) attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13]} context:nil].size.height + 20;
    CGFloat beginTime = [model.beginTime boundingRectWithSize:kMessageOrderMaxSize options:(NSStringDrawingUsesLineFragmentOrigin) attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:9]} context:nil].size.height + 8;
    CGFloat endTime = [model.endTime boundingRectWithSize:kMessageOrderMaxSize options:(NSStringDrawingUsesLineFragmentOrigin) attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:9]} context:nil].size.height + 8 + 10;
    return path + beginTime + endTime;
}
@end

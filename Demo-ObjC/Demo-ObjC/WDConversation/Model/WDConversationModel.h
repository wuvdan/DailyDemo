//
//  WDConversationModel.h
//  Demo-ObjC
//
//  Created by wudan on 2020/4/26.
//  Copyright © 2020 wudan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WDConversationMessageConstant.h"
NS_ASSUME_NONNULL_BEGIN

@interface WDConversationOrderModel : NSObject
@property (nonatomic, copy) NSString *path;
@property (nonatomic, copy) NSString *beginTime;
@property (nonatomic, copy) NSString *endTime;
@property (nonatomic, copy) NSString *price;
@end

@interface WDConversationModel : NSObject
@property (nonatomic, assign) WDConversationMessageDirectionType directionType;
@property (nonatomic, copy, nullable) NSString *contentText;
@property (nonatomic, copy, nullable) NSString *imagePath;
@property (nonatomic, strong, nullable) WDConversationOrderModel *orderModel;

- (CGFloat)getContentHeight;
@end

NS_ASSUME_NONNULL_END

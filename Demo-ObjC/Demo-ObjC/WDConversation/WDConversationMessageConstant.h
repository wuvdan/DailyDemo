//
//  WDConversationMessageConstant.h
//  Demo-ObjC
//
//  Created by wudan on 2020/4/26.
//  Copyright © 2020 wudan. All rights reserved.
//

#ifndef WDConversationMessageConstant_h
#define WDConversationMessageConstant_h

typedef NS_ENUM(NSInteger, WDConversationMessageDirectionType) {
    WDConversationMessageDirectionTypeSend,
    WDConversationMessageDirectionTypeRecive
};

typedef NS_ENUM(NSInteger, WDConversationMessageContentType) {
    WDConversationMessageContentTypeText,
    WDConversationMessageContentTypeImage,
    WDConversationMessageContentTypeOrder
};

#define kMessageHeaderSize CGSizeMake(40, 40)

#define kMessageOrderMaxSize CGSizeMake([[UIScreen mainScreen] bounds].size.width * 0.7 + 10, CGFLOAT_MAX)

#define kMessageTextMaxSize CGSizeMake([[UIScreen mainScreen] bounds].size.width * 0.7, CGFLOAT_MAX)

#endif /* WDConversationMessageConstant_h */

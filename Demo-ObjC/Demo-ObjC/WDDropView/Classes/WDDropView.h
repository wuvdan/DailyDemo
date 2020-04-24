//
//  WDDropView.h
//  Demo-ObjC
//
//  Created by wudan on 2020/4/24.
//  Copyright © 2020 wudan. All rights reserved.
//

#import <UIKit/UIKit.h>

UIKIT_EXTERN NSString *kDropViewNotificationName;

NS_ASSUME_NONNULL_BEGIN

@class WDDropView;
@protocol WDDropViewDataSource <NSObject>

@required

/** Height corresponding to controller display */
- (NSArray<NSNumber *> *)setupCategoryViewHeightInDropView:(WDDropView *)dropView;
/** Title corresponding controller array */
- (NSArray<UIView *> *)setupCategoryViewInDropView:(WDDropView *)dropView;
/** Default display of Title Array */
- (NSArray<NSString *> *)setupCategoryTitleNameInDropView:(WDDropView *)dropView;

@end

@protocol WDDropViewDelegate <NSObject>

/** Click the column and select the information. */
- (void)dropView:(WDDropView *)dropView didSelectAtColumn:(NSInteger)column info:(NSString *)info;

@end

@interface WDDropView : UIView
/** Simple page configuration */
@property (nonatomic, weak) id <WDDropViewDataSource> dataSorce;
/** Click proxy event<##> */
@property (nonatomic, weak) id <WDDropViewDelegate> delegate;

@end

NS_ASSUME_NONNULL_END

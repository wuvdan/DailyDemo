//
//  WDComboBoxControl.h
//  Demo-ObjC
//
//  Created by wudan on 2020/4/24.
//  Copyright © 2020 wudan. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, WDComboBoxControlDirection) {
    WDComboBoxControlDirectionTop,
    WDComboBoxControlDirectionLeading,
    WDComboBoxControlDirectionTrailing,
    WDComboBoxControlDirectionBottom,
};

@protocol WDComboBoxControlDataSource <NSObject>
@optional
/** < 数据数组 > */
- (NSArray<NSArray<NSString *> *> *)dataSourceOfColunm;
@required
/** < 标题数组 > */
- (NSArray<NSString *> *)titleOfSection;
@end

@protocol WDComboBoxControlDelegate <NSObject>

/**
 点击事件
 
 @param indexPath indexPath description
 @param title title description
 @param sourceView sourceView description
 */
- (void)selectedAtIndexPath:(NSIndexPath *)indexPath resultTitle:(NSString *)title fromSourceView:(UIView *)sourceView;
@end

@interface WDComboBoxControl : UIView

@property (nonatomic, weak) id <WDComboBoxControlDataSource> dataSource;
@property (nonatomic, weak) id <WDComboBoxControlDelegate> delegate;
/** < 背景按钮，可以定义需要的属性 > */
@property (nonatomic, strong) UIButton *backgroundButton;
/** < 内容TableView，也可以定义一些属性 > */
@property (nonatomic, strong) UITableView *tableView;

/**
 初始化方法

 @param height 显示内容高度
 @param view 参考View
 @return return value description
 */
- (instancetype)initViewWithMaxHeight:(CGFloat)height fromView:(UIView *)view showDirection:(WDComboBoxControlDirection)direction;
/**
 显示页面
 */
- (void)showInView;

@end

NS_ASSUME_NONNULL_END

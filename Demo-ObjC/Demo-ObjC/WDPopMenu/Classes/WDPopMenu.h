//
//  WDPopMenu.h
//  Demo-ObjC
//
//  Created by wudan on 2020/4/23.
//  Copyright © 2020 wudan. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface WDPopMenu : UIView
@property (nonatomic, copy, readonly) NSArray<NSString *> *titles;
@property (nonatomic, copy, readonly) NSArray<NSString *> *iconImageNames;

/**
 仅显示图标 + 默认样式
 
 @param iconImageNames 图标数组
 @param position 初始位置
 @param complete 点击回调
 */
+ (void)showPopMenuWithIconImageNames:(NSArray<NSString *> *)iconImageNames
                       originPosition:(CGPoint)position
                 selectedItemComplete:(void(^)(NSInteger currentIndex))complete;


/**
 仅显示图标 + 默认样式
 
 @param iconImageNames 图标数组
 @param position 初始位置
 @param isNeedSeparatorLine 是否显示分割线
 @param complete 点击回调
 */
+ (void)showPopMenuWithIconImageNames:(NSArray<NSString *> *)iconImageNames
                       originPosition:(CGPoint)position
                    needSeparatorLine:(BOOL)isNeedSeparatorLine
                 selectedItemComplete:(void(^)(NSInteger currentIndex))complete;



/**
 仅显示标题 + 默认样式
 
 @param titles 标题数组
 @param position 初始位置
 @param complete 点击回调
 */
+ (void)showPopMenuWithTitles:(NSArray<NSString *> *)titles
               originPosition:(CGPoint)position
         selectedItemComplete:(void(^)(NSInteger currentIndex))complete;


/**
 仅显示标题 + 默认样式
 
 @param titles 标题数组
 @param position 初始位置
 @param isNeedSeparatorLine 是否显示分割线
 @param complete 点击回调
 */
+ (void)showPopMenuWithTitles:(NSArray<NSString *> *)titles
               originPosition:(CGPoint)position
            needSeparatorLine:(BOOL)isNeedSeparatorLine
         selectedItemComplete:(void(^)(NSInteger currentIndex))complete;



/**
 显示文字和图标 + 默认样式
 
 @param iconImageNames 图标数组
 @param titles 标题数组
 @param position 初始位置
 @param complete 点击回调
 */
+ (void)showPopMenuWithIconImageNames:(NSArray<NSString *> * _Nullable)iconImageNames
                               titles:(NSArray<NSString *> * _Nullable)titles
                       originPosition:(CGPoint)position
                 selectedItemComplete:(void(^)(NSInteger currentIndex))complete;


/**
 显示文字和图标 + 默认样式
 
 @param iconImageNames 图标数组
 @param titles 标题数组
 @param position 初始位置
 @param isNeedSeparatorLine 是否显示分割线
 @param complete 点击回调
 */
+ (void)showPopMenuWithIconImageNames:(NSArray<NSString *> * _Nullable)iconImageNames
                               titles:(NSArray<NSString *> * _Nullable)titles
                       originPosition:(CGPoint)position
                    needSeparatorLine:(BOOL)isNeedSeparatorLine
                 selectedItemComplete:(void(^)(NSInteger currentIndex))complete;



/**
 可选显示图标、标题
 
 @param iconImageNames 图片数组 可以为空
 @param titles 标题数组 可以为空
 @param position 初始位置
 @param height 单个item高度 默认为45
 @param width 显示View的高度 默认为屏幕宽度的一半
 @param color 显示View的背景颜色
 @param isNeedSeparatorLine 是否显示分割线
 @param complete 点击回调
 */
+ (void)showPopMenuWithIconImageNames:(NSArray<NSString *> * _Nullable)iconImageNames
                               titles:(NSArray<NSString *> * _Nullable)titles
                       originPosition:(CGPoint)position
                         heightOfItem:(CGFloat)height
                          widthOfView:(CGFloat)width
                backgroundColorOfView:(UIColor *)color
                    needSeparatorLine:(BOOL)isNeedSeparatorLine
                 selectedItemComplete:(void(^)(NSInteger currentIndex))complete;


/**
 可选显示图标、标题
 
 @param iconImageNames 图片数组 可以为空
 @param titles 标题数组 可以为空
 @param position 初始位置
 @param height 单个item高度 默认为45
 @param width 显示View的高度 默认为屏幕宽度的一半
 @param color 显示View的背景颜色
 @param isNeedSeparatorLine 是否显示分割线
 @param titleLabel 自定义Item的Label样式
 @param complete 点击回调
 */
+ (void)showPopMenuWithIconImageNames:(NSArray<NSString *> * _Nullable)iconImageNames
                               titles:(NSArray<NSString *> * _Nullable)titles
                       originPosition:(CGPoint)position
                         heightOfItem:(CGFloat)height
                          widthOfView:(CGFloat)width
                backgroundColorOfView:(UIColor *)color
                     titleLabelOfItem:(UILabel * _Nullable)titleLabel
                    needSeparatorLine:(BOOL)isNeedSeparatorLine
                 selectedItemComplete:(void(^)(NSInteger currentIndex))complete;
@end

NS_ASSUME_NONNULL_END

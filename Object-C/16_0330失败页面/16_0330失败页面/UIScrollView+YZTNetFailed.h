//
//  UIScrollView+YZTNetFailed.h
//  16_0330失败页面
//
//  Created by ChuckonYin on 16/3/30.
//  Copyright © 2016年 PingAn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIScrollView+EmptyDataSet.h"

NS_ENUM(NSInteger, YZTNetFailedType){
    YZTNetFailedDefaultEmpty,
    YZTNetFailedRequestFailed,
    YZTNetFailedFirstAppear
};

@interface UIScrollView (YZTNetFailed)<DZNEmptyDataSetDelegate, DZNEmptyDataSetSource>

@property (nonatomic, assign, readonly) BOOL isFailedViewShow;

@property (nonatomic, weak, readwrite) id netFailedDelegate;

@property (nonatomic, weak, readwrite) id netFailedSource;

@property (nonatomic, assign) BOOL netFaiedViewTapEnable;
/**
 *  弹出失败页
 */
- (void)yzt_showFailedView;
/**
 *  隐藏失败页
 */
- (void)yzt_hideFailedView;

@end

@protocol YZTNetFailedViewSource <NSObject>
@optional
/**
 *   失败标题
 */
- (NSAttributedString *)yzt_titleForNetFailedView:(UIScrollView *)scrollView;
/**
 *   失败详情
 */
- (NSAttributedString *)yzt_descriptionForNetFailedView:(UIScrollView *)scrollView;
/**
 *   失败图片
 */
- (UIImage *)yzt_imageForNetFailedView:(UIScrollView *)scrollView;
/**
 *   图片渐显颜色
 */
- (UIColor *)yzt_imageTintColorForNetFailedView:(UIScrollView *)scrollView;
/**
 *   图片动画设置
 */
- (CAAnimation *)yzt_imageAnimationForNetFailedView:(UIScrollView *) scrollView;
/**
 *   按钮文字
 */
- (NSAttributedString *)yzt_buttonTitleForNetFailedView:(UIScrollView *)scrollView forState:(UIControlState)state;
/**
 *   按钮图片
 */
- (UIImage *)yzt_buttonImageNetFailedView:(UIScrollView *)scrollView forState:(UIControlState)state;
/**
 *   按钮背景图
 */
- (UIImage *)yzt_buttonBackgroundImageForNetFailedView:(UIScrollView *)scrollView forState:(UIControlState)state;
/**
 *   失败页背景色
 */
- (UIColor *)yzt_backgroundColorForNetFailedView:(UIScrollView *)scrollView;
/**
 *   自定义视图
 */
- (UIView *)yzt_customViewForNetFailedView:(UIScrollView *)scrollView;
/**
 *   垂直偏移
 */
- (CGFloat)yzt_verticalOffsetForNetFailedView:(UIScrollView *)scrollView;
/**
 *   高度
 */
- (CGFloat)yzt_spaceHeightForNetFailedView:(UIScrollView *)scrollView;
@end

@protocol YZTNetFailedViewDelegate <NSObject>
@optional
/**
 *   淡入淡出效果
 */
- (BOOL)yzt_netFailedViewShouldFadeIn:(UIScrollView *)scrollView;
/**
 *   是否显示失败页
 */
- (BOOL)yzt_netFailedViewShouldDisplay:(UIScrollView *)scrollView;
/**
 *   失败页是否响应交互
 */
- (BOOL)yzt_netFailedViewShouldAllowTouch:(UIScrollView *)scrollView;
/**
 *   失败页是否可以滑动
 */
- (BOOL)yzt_netFailedViewShouldAllowScroll:(UIScrollView *)scrollView;
/**
 *   动画是否生效
 */
- (BOOL)yzt_netFailedViewShouldAnimateImageView:(UIScrollView *)scrollView;
/**
 *   点击失败页,从图片到按钮。并非全屏。
 */
- (void)yzt_netFailedView:(UIScrollView *)scrollView didTapView:(UIView *)view;
/**
 *   点击失败页按钮
 */
- (void)yzt_netFailedView:(UIScrollView *)scrollView didTapButton:(UIButton *)button;
/**
 *   失败页即将出现
 */
- (void)yzt_netFailedViewWillAppear:(UIScrollView *)scrollView;
/**
 *   失败页已经出现
 */
- (void)yzt_netFailedViewDidAppear:(UIScrollView *)scrollView;
/**
 *   失败页即将消失
 */
- (void)yzt_netFailedViewWillDisappear:(UIScrollView *)scrollView;
/**
 *   失败页已经消失
 */
- (void)yzt_netFailedViewDidDisappear:(UIScrollView *)scrollView;

@end






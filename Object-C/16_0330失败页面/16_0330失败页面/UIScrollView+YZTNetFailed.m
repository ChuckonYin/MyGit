//
//  UIScrollView+YZTNetFailed.m
//  16_0330失败页面
//
//  Created by ChuckonYin on 16/3/30.
//  Copyright © 2016年 PingAn. All rights reserved.
//

#import "UIScrollView+YZTNetFailed.h"
#import <objc/runtime.h>

@interface UIScrollView()

@end

@implementation UIScrollView (YZTNetFailed)

- (void)yzt_showFailedView{
    self.isFailedViewShow = YES;
    [self initFailedViewSetting];
    [self reloadEmptyDataSet];
    [self resetSuceessView];
};

- (void)resetSuceessView{
    if ([self isKindOfClass:[UITableView class]]) {
        UITableView *tableView = (UITableView *)self;
        [tableView reloadData];
    }
    if ([self isKindOfClass:[UICollectionView class]]) {
        UICollectionView *collectionView = (UICollectionView *)self;
        [collectionView reloadData];
    }
}


- (void)yzt_hideFailedView{
    self.isFailedViewShow = NO;
    [self reloadEmptyDataSet];
    [self resetSuceessView];
}

- (void)initFailedViewSetting{
    if (!self.emptyDataSetDelegate) {
        self.emptyDataSetDelegate = self;
    }
    if (!self.emptyDataSetSource) {
        self.emptyDataSetSource = self;
    }
}

#pragma mark - DZNEmptyDataSetSource

- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView{
    if (self.netFailedSource && [self.netFailedSource respondsToSelector:@selector(yzt_titleForNetFailedView:)]) {
        return [self.netFailedSource yzt_titleForNetFailedView:scrollView];
    }
    else{
        NSString *str = @"一账通";
        NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:str];
        [attrStr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0, str.length)];
        return nil;
    }
}

- (NSAttributedString *)descriptionForEmptyDataSet:(UIScrollView *)scrollView{
    if (self.netFailedSource && [self.netFailedSource respondsToSelector:@selector(yzt_descriptionForNetFailedView:)]) {
        return [self.netFailedSource yzt_descriptionForNetFailedView:scrollView];
    }
    else{
        NSString *str = @"网络不给力，请稍后再试";
        NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:str];
        [attrStr addAttribute:NSForegroundColorAttributeName value:[UIColor lightGrayColor] range:NSMakeRange(0, str.length)];
        return attrStr;
    }
   
}
- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView{
    if (self.netFailedSource && [self.netFailedSource respondsToSelector:@selector(yzt_imageForNetFailedView:)]) {
        return [self.netFailedSource yzt_imageForNetFailedView:scrollView];
    }
    else{
        return [UIImage imageNamed:@"yztFailImage2"];;
    }
}
- (UIColor *)imageTintColorForEmptyDataSet:(UIScrollView *)scrollView{
    if (self.netFailedSource && [self.netFailedSource respondsToSelector:@selector(yzt_imageTintColorForNetFailedView:)]) {
        return [self.netFailedSource yzt_imageTintColorForNetFailedView:scrollView];
    }
    else{
        return nil;
    }
}
- (CAAnimation *)imageAnimationForEmptyDataSet:(UIScrollView *) scrollView{
    if (self.netFailedSource && [self.netFailedSource respondsToSelector:@selector(yzt_imageAnimationForNetFailedView:)]) {
        return [self.netFailedSource yzt_imageAnimationForNetFailedView:scrollView];
    }
    else{
        return nil;
    }
}
- (NSAttributedString *)buttonTitleForEmptyDataSet:(UIScrollView *)scrollView forState:(UIControlState)state{
    if (self.netFailedSource && [self.netFailedSource respondsToSelector:@selector(yzt_buttonTitleForNetFailedView:forState:)]) {
        return [self.netFailedSource yzt_buttonTitleForNetFailedView:scrollView forState:state];
    }
    else{
        NSString *str = @"点我, 立即刷新";
        NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:str];
        if (state == UIControlStateNormal) {
            [attrStr addAttribute:NSForegroundColorAttributeName value:[UIColor blueColor] range:NSMakeRange(0, str.length)];
            return attrStr;
        }
    }
    return nil;
}
- (UIImage *)buttonImageForEmptyDataSet:(UIScrollView *)scrollView forState:(UIControlState)state{
    if (self.netFailedSource && [self.netFailedSource respondsToSelector:@selector(yzt_buttonImageNetFailedView:forState:)]) {
        return [self.netFailedSource yzt_buttonImageNetFailedView:scrollView forState:state];
    }
    else{
//        return [UIImage imageNamed:@"yztFailImage2"];
        return nil;
    }
    
}
- (UIImage *)buttonBackgroundImageForEmptyDataSet:(UIScrollView *)scrollView forState:(UIControlState)state{
    if (self.netFailedSource && [self.netFailedSource respondsToSelector:@selector(yzt_buttonBackgroundImageForNetFailedView:forState:)]) {
        return [self.netFailedSource yzt_buttonBackgroundImageForNetFailedView:scrollView forState:state];
    }
    else{
        return nil;
    }
}
- (UIColor *)backgroundColorForEmptyDataSet:(UIScrollView *)scrollView{
    if (self.netFailedSource && [self.netFailedSource respondsToSelector:@selector(yzt_backgroundColorForNetFailedView:)]) {
        return [self.netFailedSource yzt_backgroundColorForNetFailedView:scrollView];
    }
    else{
        return [UIColor colorWithRed:0.96 green:0.96 blue:0.96 alpha:1.00];
    }
}
- (UIView *)customViewForEmptyDataSet:(UIScrollView *)scrollView{
    if (self.netFailedSource && [self.netFailedSource respondsToSelector:@selector(yzt_customViewForNetFailedView:)]) {
        return [self.netFailedSource yzt_customViewForNetFailedView:scrollView];
    }
    else{
        return nil;
    }
}

- (CGFloat)verticalOffsetForEmptyDataSet:(UIScrollView *)scrollView{
    if (self.netFailedSource && [self.netFailedSource respondsToSelector:@selector(yzt_verticalOffsetForNetFailedView:)]) {
        return [self.netFailedSource yzt_verticalOffsetForNetFailedView:scrollView];
    }
    else{
        return -100;
    }
}
- (CGFloat)spaceHeightForEmptyDataSet:(UIScrollView *)scrollView{
    if (self.netFailedSource && [self.netFailedSource respondsToSelector:@selector(yzt_verticalOffsetForNetFailedView:)]) {
        return [self.netFailedSource yzt_spaceHeightForNetFailedView:scrollView];
    }
    else{
        return 20;
    }
}

#pragma mark - DZNEmptyDataSetDelegate

- (BOOL)emptyDataSetShouldFadeIn:(UIScrollView *)scrollView{
    if (self.netFailedDelegate && [self.netFailedDelegate respondsToSelector:@selector(yzt_netFailedViewShouldFadeIn:)]) {
       return [self.netFailedDelegate yzt_netFailedViewShouldFadeIn:scrollView];
    }
    else{
       return YES;
    }
}
//返回是否加载失败页面
- (BOOL)emptyDataSetShouldDisplay:(UIScrollView *)scrollView{
    NSLog(@"%@", self.netFailedDelegate);
    if (self.netFailedDelegate && [self.netFailedDelegate respondsToSelector:@selector(yzt_netFailedViewShouldDisplay:)]) {
        return [self.netFailedDelegate yzt_netFailedViewShouldDisplay:scrollView];
    }
    else{
        return self.isFailedViewShow;
    }
}
- (BOOL)emptyDataSetShouldAllowTouch:(UIScrollView *)scrollView{
    if (self.netFailedDelegate && [self.netFailedDelegate respondsToSelector:@selector(yzt_netFailedViewShouldAllowTouch:)]) {
        return [self.netFailedDelegate yzt_netFailedViewShouldAllowTouch:scrollView];
    }
    else{
        return YES;
    }
}
- (BOOL)emptyDataSetShouldAllowScroll:(UIScrollView *)scrollView{
    if (self.netFailedDelegate && [self.netFailedDelegate respondsToSelector:@selector(yzt_netFailedViewShouldAllowScroll:)]) {
        return [self.netFailedDelegate yzt_netFailedViewShouldAllowScroll:scrollView];
    }
    else{
        return NO;
    }
}
- (BOOL)emptyDataSetShouldAnimateImageView:(UIScrollView *)scrollView{
    if (self.netFailedDelegate && [self.netFailedDelegate respondsToSelector:@selector(yzt_netFailedViewShouldAnimateImageView:)]) {
        return [self.netFailedDelegate yzt_netFailedViewShouldAnimateImageView:scrollView];
    }
    else{
        return YES;
    }
    
}

- (void)emptyDataSet:(UIScrollView *)scrollView didTapView:(UIView *)view{
    if (self.netFailedDelegate && [self.netFailedDelegate respondsToSelector:@selector(yzt_netFailedView:didTapView:)]) {
        [self.netFailedDelegate yzt_netFailedView:scrollView didTapView:view];
    }
    else{
        //默认操作。。。
    }
}
- (void)emptyDataSet:(UIScrollView *)scrollView didTapButton:(UIButton *)button{
    if (self.netFailedDelegate && [self.netFailedDelegate respondsToSelector:@selector(yzt_netFailedView:didTapButton:)]) {
        [self.netFailedDelegate yzt_netFailedView:scrollView didTapButton:button];
    }
    else{
        //默认操作...
    }
}
- (void)emptyDataSetWillAppear:(UIScrollView *)scrollView{
    if (self.netFailedDelegate && [self.netFailedDelegate respondsToSelector:@selector(yzt_netFailedViewWillAppear:)]) {
        [self.netFailedDelegate yzt_netFailedViewWillAppear:scrollView];
    }
    else{
       //默认操作...
    }
}
- (void)emptyDataSetDidAppear:(UIScrollView *)scrollView{
    if (self.netFailedDelegate && [self.netFailedDelegate respondsToSelector:@selector(yzt_netFailedViewDidAppear:)]) {
        [self.netFailedDelegate yzt_netFailedViewDidAppear:scrollView];
    }
    else{
        //默认操作...
    }
}
- (void)emptyDataSetWillDisappear:(UIScrollView *)scrollView{
    if (self.netFailedDelegate && [self.netFailedDelegate respondsToSelector:@selector(yzt_netFailedViewWillDisappear:)]) {
        [self.netFailedDelegate yzt_netFailedViewWillDisappear:scrollView];
    }
    else{
        //默认操作...
    }
}
- (void)emptyDataSetDidDisappear:(UIScrollView *)scrollView{
    if (self.netFailedDelegate && [self.netFailedDelegate respondsToSelector:@selector(yzt_netFailedViewDidDisappear:)]) {
        [self.netFailedDelegate yzt_netFailedViewDidDisappear:scrollView];
    }
    else{
        //默认操作...
    }
}

#pragma mark - get & set

- (id)netFailedSource{
    return objc_getAssociatedObject(self, @selector(netFailedSource));
}

- (void)setNetFailedSource:(id)netFailedSource{
    objc_setAssociatedObject(self, @selector(netFailedSource), netFailedSource, OBJC_ASSOCIATION_ASSIGN);
}

- (id)netFailedDelegate{
    return objc_getAssociatedObject(self, @selector(netFailedDelegate));
}

- (void)setNetFailedDelegate:(id)netFailedDelegate{
    return objc_setAssociatedObject(self, @selector(netFailedDelegate), netFailedDelegate, OBJC_ASSOCIATION_ASSIGN);
}

- (BOOL)isFailedViewShow{
    return [objc_getAssociatedObject(self, @selector(isFailedViewShow)) integerValue];
}

- (void)setIsFailedViewShow:(BOOL)isFailedViewShow{
    objc_setAssociatedObject(self, @selector(isFailedViewShow), @(isFailedViewShow), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)netFaiedViewTapEnable{
    return [objc_getAssociatedObject(self, @selector(netFaiedViewTapEnable)) integerValue];
}

-(void)setNetFaiedViewTapEnable:(BOOL)netFaiedViewTapEnable{
    objc_setAssociatedObject(self, @selector(netFaiedViewTapEnable), @(netFaiedViewTapEnable), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end

//
//  UIScrollView+YZTRefresh.m
//  MJ新版
//
//  Created by ChuckonYin on 16/2/22.
//  Copyright © 2016年 PingAn. All rights reserved.
//

#import "UIScrollView+YZTRefresh.h"
#import <objc/runtime.h>
#import "MJRefresh.h"

@implementation UIScrollView (YZTRefresh)

//header
- (void)yzt_addHeaderWithCallback:(void(^)())callback{
    self.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:callback];
    self.hiddenHeaderLastRefreshTime = YES;
   
}
- (void)yzt_addHeaderWithTarget:(id)target action:(SEL)sel{
    self.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:target refreshingAction:sel];
    self.hiddenHeaderLastRefreshTime = YES;
}
- (void)yzt_headerBeginRefreshing{
    [self.mj_header beginRefreshing];
}
- (void)yzt_headerEndRefreshing{
    [self.mj_header endRefreshing];
}
- (void)yzt_addHeaderWithTarget:(id)target action:(SEL)sel dateKey:(NSString*)dateKey{
    [self yzt_addHeaderWithTarget:target action:sel];
}
//footer
- (void)yzt_addFooterWithCallback:(void (^)())callback{
    self.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:callback];
}
- (void)yzt_addFooterWithTarget:(id)target action:(SEL)action{
    self.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:target refreshingAction:action];
}
- (void)yzt_footerBeginRefreshing{
    [self.mj_footer beginRefreshing];
}
- (void)yzt_footerEndRefreshing{
    [self.mj_footer endRefreshing];
}

- (void)yzt_setHeaderRefreshingTextColorWhite:(BOOL)isCustom{
    if (self.mj_header && [self.mj_header isKindOfClass:[MJRefreshNormalHeader class]]) {
        self.mj_header.isCustomHeaderTextColor = isCustom;
    }
}

- (void)yzt_setRefreshingArrowColorWhite:(BOOL)isCustom{
    if (self.mj_header && [self.mj_header isKindOfClass:[MJRefreshNormalHeader class]]) {
        self.mj_header.isCustomHeaderColor = isCustom;
        self.mj_header.arrowView.circleColor = isCustom ? [UIColor whiteColor] : [UIColor lightGrayColor];
    }
}

- (void)yzt_setFooterRefreshingText:(NSString*)text{
    
}

#pragma mark - get & set

-(BOOL)hiddenHeaderLastRefreshTime{
    if ([self.mj_header isKindOfClass:[MJRefreshStateHeader class]]) {
        MJRefreshStateHeader *h = (MJRefreshStateHeader *)self.mj_header;
        return h.lastUpdatedTimeLabel.hidden;
    }
    NSLog(@"未找到显示时间的头视图");
    return NO;
}
- (void)setHiddenHeaderLastRefreshTime:(BOOL)hiddenHeaderLastRefreshTime{
    if ([self.mj_header isKindOfClass:[MJRefreshStateHeader class]]) {
        MJRefreshStateHeader *h = (MJRefreshStateHeader *)self.mj_header;
        h.lastUpdatedTimeLabel.hidden = hiddenHeaderLastRefreshTime;
    }
}
-(BOOL)isHeaderRefreshing{
    return self.mj_header.state == MJRefreshStateRefreshing ? YES : NO;
}
-(BOOL)headerRefreshing{
    return self.isHeaderRefreshing;
}

-(BOOL)footerRefreshing{
    return self.mj_footer.state == MJRefreshStateRefreshing ? YES : NO;
}

- (void)yzt_adjustRefreshHeaderToYZTGlobalColor{
    [self yzt_setRefreshingArrowColorWhite:YES];
    [self yzt_setHeaderRefreshingTextColorWhite:YES];
    UIView *yztRefreshBg = [[UIView alloc] initWithFrame:CGRectMake(0, -600, kScreenWidth, 600)];
    yztRefreshBg.backgroundColor = kGlobalColor;
    [self insertSubview:yztRefreshBg atIndex:0];
}


@end

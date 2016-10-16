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
#import "YZTRefreshNormalHeader.h"
#import "YZTRefreshBackNormalFooter.h"

@implementation UIScrollView (YZTRefresh)

//header
- (void)yzt_addHeaderWithCallback:(void(^)())callback{
    self.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:callback];
    self.hiddenHeaderLastRefreshTime = YES;
   
}
- (void)yzt_addHeaderWithTarget:(id)target action:(SEL)sel{
    self.mj_header = [YZTRefreshNormalHeader headerWithRefreshingTarget:target refreshingAction:sel];
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
    self.mj_footer = [YZTRefreshBackNormalFooter footerWithRefreshingBlock:callback];
}
- (void)yzt_addFooterWithTarget:(id)target action:(SEL)action{
    self.mj_footer = [YZTRefreshBackNormalFooter footerWithRefreshingTarget:target refreshingAction:action];
}
- (void)yzt_footerBeginRefreshing{
    [self.mj_footer beginRefreshing];
}
- (void)yzt_footerEndRefreshing{
    [self.mj_footer endRefreshing];
}

- (void)yzt_setHeaderRefreshingTextColorWhite:(BOOL)isCustom{
    if (self.mj_header && [self.mj_header isKindOfClass:[YZTRefreshNormalHeader class]]) {
        YZTRefreshNormalHeader *header = (YZTRefreshNormalHeader *)self.mj_header;
        if (isCustom) {
            header.stateTextColor = [UIColor whiteColor];
        }
        else{
            header.stateTextColor = [UIColor grayColor];
        }
    }
}

- (void)yzt_setRefreshingArrowColorWhite:(BOOL)isCustom{
    if (self.mj_header && [self.mj_header isKindOfClass:[YZTRefreshNormalHeader class]]) {
        YZTRefreshNormalHeader *header = (YZTRefreshNormalHeader *)self.mj_header;
        if (isCustom) {
            header.circleColor = [UIColor whiteColor];
        }
        else{
            header.circleColor = [UIColor grayColor];
        }
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
    UIView *yztRefreshBg = [[UIView alloc] initWithFrame:CGRectMake(0, -600, [[UIScreen mainScreen] bounds].size.width, 600)];
//    yztRefreshBg.backgroundColor = kGlobalColor;
    [self insertSubview:yztRefreshBg atIndex:0];
}

- (void)yzt_setRefreshStateTextAndCircleColor:(UIColor *)color{
    if (self.mj_header && [self.mj_header isKindOfClass:[YZTRefreshNormalHeader class]]) {
        YZTRefreshNormalHeader *header = (YZTRefreshNormalHeader *)self.mj_header;
        header.circleColor = color;
        header.stateTextColor = color;
    }
    if (self.mj_footer && [self.mj_footer isKindOfClass:[YZTRefreshBackNormalFooter class]]) {
        YZTRefreshBackNormalFooter *header = (YZTRefreshBackNormalFooter *)self.mj_header;
        header.circleColor = color;
        header.stateTextColor = color;
    }
}


@end









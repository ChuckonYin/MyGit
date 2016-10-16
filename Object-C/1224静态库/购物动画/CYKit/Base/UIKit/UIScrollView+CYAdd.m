//
//  UIScrollView+CYAdd.m
//  CYKitDemo
//
//  Created by ChuckonYin on 15/12/3.
//  Copyright © 2015年 PingAn. All rights reserved.
//

#import "UIScrollView+CYAdd.h"
#import <objc/runtime.h>

@interface UIScrollView()

@property (nonatomic, assign) id<UIScrollViewDelegate> ctrlDelegate;
@property (nonatomic, copy) void(^callBack)(UIScrollView *, CGFloat offX, CGFloat offY);

@end

@implementation UIScrollView (CYAdd)

-(void)setDelegate:(id<UIScrollViewDelegate>)delegate ScrollDidScroll:(CallBack) callBack
{
    objc_setAssociatedObject(self, @selector(ctrlDelegate), delegate, OBJC_ASSOCIATION_ASSIGN);
    objc_setAssociatedObject(self, @selector(callBack), callBack, OBJC_ASSOCIATION_COPY_NONATOMIC);
    self.delegate = self;
}

-(void)scrollToTop{
    CGPoint offP = self.contentOffset;
    self.contentOffset = point(offP.x, 0);
}
-(void)scrollToLeft{
    CGPoint offP = self.contentOffset;
    self.contentOffset = point(0, offP.y);
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    id<UIScrollViewDelegate> delegate = objc_getAssociatedObject(self, @selector(ctrlDelegate));
    if ([delegate respondsToSelector:@selector(scrollViewDidScroll:)]) {
        [delegate scrollViewDidScroll:scrollView];
    }
    CallBack callback = objc_getAssociatedObject(self, @selector(callBack));
    if (callback) {
        callback(scrollView,scrollView.contentOffset.x,scrollView.contentOffset.y);
    }
}

-(void)removeDelaysContentTouches
{
    self.delaysContentTouches = NO;
    self.canCancelContentTouches = YES;
    // Remove touch delay (since iOS 8)
    UIView *wrapView = self.subviews.firstObject;
    // UITableViewWrapperView
    if (wrapView && [NSStringFromClass(wrapView.class) hasSuffix:@"WrapperView"]) {
        for (UIGestureRecognizer *gesture in wrapView.gestureRecognizers) {
            // UIScrollViewDelayedTouchesBeganGestureRecognizer
            if ([NSStringFromClass(gesture.class) containsString:@"DelayedTouchesBegan"] ) {
                gesture.enabled = NO;
                break;
            }
        }
    }
}


@end

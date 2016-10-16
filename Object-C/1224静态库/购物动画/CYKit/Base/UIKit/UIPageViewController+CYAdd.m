//
//  UIPageViewController+CYAdd.m
//  CYKitDemo
//
//  Created by ChuckonYin on 15/12/3.
//  Copyright © 2015年 PingAn. All rights reserved.
//

#import "UIPageViewController+CYAdd.h"

@implementation UIPageViewController (CYAdd)

-(UIScrollView *)scrollView
{
    for (UIView *view in self.view.subviews) {
        if ([view isKindOfClass:[UIScrollView class]]) {
            return (UIScrollView*)view;
        }
    }
    return nil;
}
-(CGPoint)contentOffSet
{
    return self.scrollView.contentOffset;
}
-(void)setScrollViewDelegate:(id<UIScrollViewDelegate>)scrollViewDelegate
{
    __unsafe_unretained id delegate = scrollViewDelegate;
    self.scrollView.delegate = delegate;
}
-(id<UIScrollViewDelegate>)scrollViewDelegate
{
    return self.scrollView.delegate;
}

@end

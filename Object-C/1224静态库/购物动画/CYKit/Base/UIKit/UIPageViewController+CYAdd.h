//
//  UIPageViewController+CYAdd.h
//  CYKitDemo
//
//  Created by ChuckonYin on 15/12/3.
//  Copyright © 2015年 PingAn. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIPageViewController (CYAdd)

//scroll in UIPageViewController, but apple don‘t provide
@property (nonatomic, strong, readonly) UIScrollView *scrollView;
@property (nonatomic, assign, readonly) CGPoint contentOffSet;
@property (nonatomic, assign, readwrite) id<UIScrollViewDelegate> scrollViewDelegate;

@end

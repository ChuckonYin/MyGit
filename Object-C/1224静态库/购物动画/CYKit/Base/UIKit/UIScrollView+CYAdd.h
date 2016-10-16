//
//  UIScrollView+CYAdd.h
//  CYKitDemo
//
//  Created by ChuckonYin on 15/12/3.
//  Copyright © 2015年 PingAn. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^CallBack)(UIScrollView *scroll, CGFloat offX, CGFloat offY);

@interface UIScrollView (CYAdd)<UIScrollViewDelegate>

-(void)setDelegate:(id<UIScrollViewDelegate>)delegate ScrollDidScroll:(CallBack) callBack;

- (void)scrollToTop;

- (void)scrollToLeft;

//change the view active when scroll
- (void)removeDelaysContentTouches;


@end

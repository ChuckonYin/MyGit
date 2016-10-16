//
//  CYAdScrollView.h
//  0103轮播
//
//  Created by ChuckonYin on 16/1/3.
//  Copyright © 2016年 PingAn. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CYAdScrollView : UIView

@property (nonatomic, strong, readonly) NSMutableArray *imgArr;

@property (nonatomic, assign) CGFloat pageIndicatorTintHeight;

- (void)refreshWithImageArray:(NSArray*)imgArr;

@end

//
//  CYAdScrollView.h
//
//  Created by ChuckonYin on 15/10/26.
//  Copyright © 2015年 PingAn. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CYAdScrollView : UIView

@property (nonatomic, strong, readonly) NSMutableArray *adArr;

@property (nonatomic, strong, readonly) UIPageViewController *pageCtrl;

@property (nonatomic, strong, readonly) NSMutableArray *vcArr;

@property (nonatomic, assign, readonly) CGFloat inteval;

@property (nonatomic, strong) UIPageControl *pageControl;

/**
 *  滑动至目的广告后停留时间
 */
@property (nonatomic, assign) CGFloat focusInterval;
/**
 *  设置进入广告后停止滚动 default NO
 */
@property (nonatomic, assign) BOOL isStopRollIntoAdvertisement;

/**
 *  界面跳转至广告页后timer默认停止。
 *
 */
@property (nonatomic, strong) NSTimer *timer;

@property (nonatomic, copy, readonly) void(^callBack)(NSInteger clickIndex);

/**
 *
 *  @param inteval  frequency
 *  @param callback the index of ad
 *
 *  @return self
 */
-(instancetype)initWithFrame:(CGRect)frame inteval:(CGFloat)inteval clickIndex:(void(^)(NSInteger clickIndex))callback;
/**
 *  start roll
 *
 *  @param adImgArr NSString or UIImage
 */
- (void)refrehAdViewwith:(id)adImgArr;
/**
 *  重新启动滚动
 */
-(void)reRollAgain;

@end







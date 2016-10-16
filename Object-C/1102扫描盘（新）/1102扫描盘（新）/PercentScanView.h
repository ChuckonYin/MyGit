//
//  PercentScanView.h
//  1102扫描盘（新）
//
//  Created by ChuckonYin on 15/11/2.
//  Copyright © 2015年 PingAn. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PercentScanView : UIView
/**
 *  表盘总偏角范围 default 3/4
 */
@property (nonatomic, assign) CGFloat totalPercent;
/**
 *  default 1.0f
 */
@property (nonatomic, assign) CGFloat scale;
/**
 *  Y轴调整 default 0
 */
@property (nonatomic, assign) CGFloat vertical;
/**
 *  总刻度数 default 50
 */
@property (nonatomic, assign) NSInteger markNumber;
/**
 *  偏转速度 default 0.1
 */
@property (nonatomic, assign) CGFloat interval;

@property (nonatomic, assign, readonly) CGFloat value;

@property (nonatomic, strong) NSArray *dscInfos;
/**
 *  描述文字控件
 */
@property (nonatomic, strong) UIView *dscView;
@property (nonatomic, assign) CGRect dscViewBounds;
@property (nonatomic, strong) UILabel *lable0;// default 好信分
@property (nonatomic, strong) UILabel *lable1;// default 716
@property (nonatomic, strong) UILabel *lable2;// default 信用极好
@property (nonatomic, strong) UILabel *lable3;// default 高于99%用户

/**
 *  刷新扫描图
 *
 *  @param value    @0.88
 *  @param dscInfos 例如 ： 716、信用极好、高于99%用户
 *  @param animated 动画
 */
- (void)refreshViewValue:(NSNumber*)value and:(NSArray*)dscInfos animate:(BOOL)animated;

@end


@interface ScanRuler : UIView

@property(nonatomic, assign) CGFloat width;

@property(nonatomic, assign) CGFloat height;

@property(nonatomic, assign) CGFloat cr;

@end

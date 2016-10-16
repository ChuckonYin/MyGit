//
//  HealthExamView.h
//  五维图（新）
//
//  Created by ChuckonYin on 15/11/2.
//  Copyright © 2015年 PingAn. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HealthExamView <NSObject>

- (void)HealthExamViewClickIndex:(NSInteger)index;

@end

@interface HealthExamView : UIView
/**
 *  vertical adjust default 0
 */
@property (nonatomic, assign) CGFloat vertical;
/**
 *  default 1.0
 */
@property (nonatomic, assign) CGFloat scale;
/**
 *  default 2.0
 */
@property (nonatomic, assign) CGFloat outBorderWidth;
/**
 *  default 1.0
 */
@property (nonatomic, assign) CGFloat trestleWidth;
/**
 *  default white
 */
@property (nonatomic, strong) UIColor *lineColor;

@property (nonatomic, strong) UIColor *outBgColor;
/**
 *  default 2.0
 */
@property (nonatomic, strong) UIColor *insideBgColor;
/**
 *  default 1.0
 */
@property (nonatomic, assign) id<HealthExamView> delegate;
/**
 *  default 0.03
 */
@property (nonatomic, assign) CGFloat interval;

- (void)refreshWithValues:(NSArray*)values animate:(BOOL)animated;

@end






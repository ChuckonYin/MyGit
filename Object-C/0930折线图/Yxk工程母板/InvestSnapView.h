//
//  InvestSnapView.h
//  Yxk工程母板
//
//  Created by ChuckonYin on 15/9/30.
//  Copyright © 2015年 PingAn. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InvestSnapView : UIView


@property (nonatomic, strong) NSArray *values;

@property (nonatomic, strong) UIView *rule;   //标尺

@property (nonatomic, assign) BOOL rulerMoveEnable;

@property (nonatomic, strong) UIColor *snapLineColor; //折线颜色

@property (nonatomic, strong) UIColor *coordLineColor; //坐标轴颜色

-(void)setNeedsDisplay:(NSArray*)values;

//-(void)resetMeasureRuler:(CGFloat)x;
//
//-(void)startMoveRuler:(CGFloat)x;
//
//-(void)stopMoveRuler;

@end

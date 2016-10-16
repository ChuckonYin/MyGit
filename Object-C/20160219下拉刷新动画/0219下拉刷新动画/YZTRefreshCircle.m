//
//  YZTRefreshCircle.m
//  0219下拉刷新动画
//
//  Created by ChuckonYin on 16/2/19.
//  Copyright © 2016年 PingAn. All rights reserved.
//

#import "YZTRefreshCircle.h"

@interface YZTRefreshCircle ()

@property (nonatomic, assign) CGFloat currentAngle;

@end

@implementation YZTRefreshCircle

- (instancetype)initWithFrame:(CGRect)frame andTotoalTurns:(CGFloat)turns circleColor:(UIColor*)circleColor{
    if (self = [super initWithFrame:frame]) {
        self.circleBoderWidth = 1.5f;
        self.circleColor = [UIColor blackColor];
    }
    return self;
}

- (void)resetCurrentRotationAngle:(CGFloat)angle{
    self.currentAngle = -M_PI/2 + angle*self.totoalTurns*2*M_PI;
    [self setNeedsDisplay];
}
/**
 *  开始高速旋转
 */
- (void)startTurnningFast{
    
}
/**
 *  停止旋转
 */
- (void)stopTurnning{
    
}

- (void)drawRect:(CGRect)rect {
    UIBezierPath *ciclePath = [UIBezierPath bezierPathWithArcCenter:self.center radius:self.frame.size.width/2-5 startAngle:-M_PI/2 endAngle:self.currentAngle clockwise:YES];
    [self.circleColor setStroke];
    ciclePath.lineWidth = self.circleBoderWidth;
    [ciclePath stroke];
}

@end








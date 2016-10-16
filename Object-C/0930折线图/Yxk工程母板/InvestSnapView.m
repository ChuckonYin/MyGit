//
//  InvestSnapView.m
//  Yxk工程母板
//
//  Created by ChuckonYin on 15/9/30.
//  Copyright © 2015年 PingAn. All rights reserved.
//

#import "InvestSnapView.h"
#define zeroGap 20  //坐标原点离边界距离
#define coordW (_selfWith -2*zeroGap)  //横坐标总长度
#define coordH (_selfHeight -2*zeroGap) //纵坐标总长度

@interface InvestSnapView()
{
    CGPoint zeroP;  //坐标原点坐标
    CGFloat _selfWith; //总图宽
    CGFloat _selfHeight; //总图长
    NSInteger _pointNum; //点数
    CGFloat _pointXgap;  //X轴点间距
    NSMutableArray *_pointArr; //坐标点数组
    NSTimer *_timer;
    NSInteger _timerRec;  //定时器纪录
    
    CGFloat _oldRuleX; //偏移量纪录
    UILabel *_changeLAB; //显示器
}
@end
@implementation InvestSnapView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        _timerRec   = 0;
        _selfWith   = frame.size.width;
        _selfHeight = frame.size.height;
        zeroP = CGPointMake(zeroGap, _selfHeight-zeroGap);
        _snapLineColor = [UIColor whiteColor];
        _coordLineColor = [UIColor whiteColor];
        
        _rule = [[UIView alloc] initWithFrame:CGRectMake(zeroP.x, 0, 2, _selfHeight)];
        [self addSubview:_rule];
        _rule.backgroundColor = colorRed;
        self.rulerMoveEnable  = NO;
      
        _changeLAB = [[UILabel alloc] initWithFrame:CGRectMake(70, 30, 70, 30)];
        [self addSubview:_changeLAB];
        _changeLAB.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    UIBezierPath *path = [UIBezierPath bezierPath];
    [_coordLineColor setStroke];
    [path moveToPoint:zeroP];
    [[UIColor whiteColor] setStroke];
    //x
    [path addLineToPoint:CGPointMake(zeroP.x+coordW, zeroP.y)];
    [path stroke];
    [path moveToPoint:zeroP];
    //y
    [path addLineToPoint:CGPointMake(zeroP.x, zeroP.y-coordH)];
    [path stroke];
   
    //连点
    [_snapLineColor setStroke];
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(ctx, 1.5);
    CGContextSetLineJoin(ctx, kCGLineJoinRound);
    //开启抗锯齿
    CGContextSetAllowsAntialiasing(ctx, true);
    CGContextSetShouldAntialias(ctx, true);
    for (int i=0; i<_timerRec; i++) {
        CGPoint p = [_pointArr[i] CGPointValue];
        if (i==0) {
            CGContextMoveToPoint(ctx, p.x, p.y);
        }
        else{
            CGContextAddLineToPoint(ctx, p.x, p.y);
            [self setRulerTansformAndShowInfo:_pointXgap*i];
            _oldRuleX = _pointXgap*i + zeroP.x;
        }
    }
     CGContextStrokePath(ctx);
}

-(void)setNeedsDisplay:(NSArray*)values
{
    _values = values;
    _pointArr = [NSMutableArray new];
    _pointNum = values.count;
    _pointXgap = coordW/_pointNum;
    for (int i=0; i<_pointNum; i++) {
        CGFloat y = zeroP.y - [values[i] floatValue] * coordH;
        CGPoint p = CGPointMake(zeroP.x + i*_pointXgap, y);
        [_pointArr addObject:[NSValue valueWithCGPoint:p]];
    }
    if (!_timer) {
        _timer = [NSTimer scheduledTimerWithTimeInterval:0.05 target:self selector:@selector(progressDraw) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
    }
    [_timer fire];
}

-(void)progressDraw{
    if (_timerRec<_pointNum) {
        _timerRec ++;
        [self setNeedsDisplay];
    }
    else{
        _timerRec = 0;
        [_timer invalidate];
    }
}

-(void)setRulerTansformAndShowInfo:(CGFloat)transX;
{
     _rule.transform = CGAffineTransformMakeTranslation(transX, 0);
     NSInteger index = round(transX/_pointXgap);
    if (index < _values.count) {
        _changeLAB.text = [NSString stringWithFormat:@"%.3f",[_values[index]floatValue]];
    }
}
#pragma mark -- 标尺周期

-(void)resetMeasureRuler:(CGFloat)x
{
    //
    //下手未触发，但当手指移动到标尺时一样会触发
    //
    if (ABS(x - _oldRuleX)<15) {
        _rulerMoveEnable = YES;
    }
    //终止状态不可移动
    if (!_rulerMoveEnable) {
        return ;
    }
    //更新位置
    if (x<zeroP.x) {
        _oldRuleX = zeroP.x;
    }
    else if (x>zeroP.x + coordW) {
        _oldRuleX = zeroP.x + coordW;
    }
    else{
        _oldRuleX = x;
    }
    [self setRulerTansformAndShowInfo:_oldRuleX - zeroP.x];
    NSLog(@"_rule====%f",_rule.frame.origin.x);
}

-(void)startMoveRuler:(CGFloat)x
{
    //
    //当触摸距离大，不会触发移动
    //
    if (ABS(x - _oldRuleX)>25) {
        _rulerMoveEnable = NO;
    }
    else{
        _rulerMoveEnable = YES;
    }
}
-(void)stopMoveRuler
{
    _rulerMoveEnable = NO;
}

#pragma mark -- 触控事件周期

-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    CGPoint p = [[touches anyObject] locationInView:self];
    [self resetMeasureRuler:p.x];
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    CGPoint p = [[touches anyObject] locationInView:self];
    [self startMoveRuler:p.x];
}
-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self stopMoveRuler];
}

@end









//
//  HealthExamView.m
//  五维图（新）
//
//  Created by ChuckonYin on 15/11/2.
//  Copyright © 2015年 PingAn. All rights reserved.
//

#import "HealthExamView.h"

@interface HealthExamView ()
{
    CGSize _size;
    CGFloat _r;
    NSInteger _timerRec;
    NSArray *_tempValues;
}
@property (nonatomic, assign) CGPoint zeroP;
@property (nonatomic, strong) NSMutableArray *values;
@property (nonatomic, strong) NSMutableArray *angleArr;
@property (nonatomic, strong) NSMutableArray *inPointArr;
@property (nonatomic, strong) NSMutableArray *outPointArr;
@property (nonatomic, strong) NSTimer *timer;
@end

@implementation HealthExamView


- (instancetype)initWithFrame:(CGRect)frame{
    //frame激活drawRect
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor orangeColor];
        _vertical = 0.0f;
        _scale = 1.0f;
        _outBorderWidth = 2.0f;
        _trestleWidth = 0.25f;
        _lineColor = [UIColor whiteColor];
        _outBgColor = [UIColor colorWithWhite:1.0f alpha:0.2];
        _insideBgColor = [UIColor colorWithWhite:1.0f alpha:0.5];
        _interval = 0.03;
        
        CGFloat perAngle = 2*M_PI/5;
        CGFloat startAngle = -(M_PI-perAngle*2)/2;
        _angleArr = [NSMutableArray new];
        for (int i=0; i<5; i++) {
            CGFloat angle = startAngle - perAngle*i;
            [_angleArr addObject:[NSNumber numberWithFloat:angle]];
        }
    }
    return self;
}
- (void)reSetViewSize{
    _size = CGSizeMake(self.frame.size.width, self.frame.size.height);
    _zeroP = CGPointMake(_size.width/2, _vertical + _size.height/2);
    _r = _size.width/4*_scale;
    _outPointArr = [NSMutableArray new];
    for (int i=0; i<5; i++) {
        CGPoint outP = CGPointMake(_zeroP.x + _r*cos([_angleArr[i] floatValue]), _zeroP.y + _r*sin([_angleArr[i] floatValue]));
        [_outPointArr addObject:[NSValue valueWithCGPoint:outP]];
    }
}
- (void)drawRect:(CGRect)rect{
    if (_angleArr.count<5) {
        return;
    }
    _inPointArr = [NSMutableArray new];
    for (int i=0; i<5; i++) {
        CGFloat f = [_values[i] floatValue];
        CGPoint inP = CGPointMake(_zeroP.x + _r*cos([_angleArr[i] floatValue])*f, _zeroP.y + _r*sin([_angleArr[i] floatValue])*f);
        NSValue *newValue = [NSValue valueWithCGPoint:inP];
        [_inPointArr addObject:newValue];
    }
    
    UIBezierPath *trestlePath = [UIBezierPath bezierPath];
    UIBezierPath *outPath = [UIBezierPath bezierPath];
    UIBezierPath *inPath = [UIBezierPath bezierPath];
    UIBezierPath *ringPath = [UIBezierPath bezierPath];
    
    trestlePath.lineWidth = _trestleWidth;
    [outPath moveToPoint:[_outPointArr[4] CGPointValue]];
    [inPath moveToPoint:[_inPointArr[4] CGPointValue]];
    
    for (int i=0; i<5; i++)
    {
        CGPoint outP = [_outPointArr[i] CGPointValue];
        
        [trestlePath moveToPoint:_zeroP];
        [trestlePath addLineToPoint:outP];
        
        [outPath addLineToPoint:outP];
        
        CGPoint inP = [_inPointArr[i] CGPointValue];
        [inPath addLineToPoint:inP];
        
        [ringPath moveToPoint:inP];
        [ringPath addArcWithCenter:inP radius:5 startAngle:0 endAngle:3*M_PI clockwise:0];
    }
    [_lineColor setStroke];
    
    [trestlePath stroke];
    
    [_outBgColor setFill];
    outPath.lineWidth = _outBorderWidth;
    [outPath fill];
    [outPath stroke];
 
    
    [_insideBgColor setFill];
    inPath.lineWidth = _outBorderWidth;
    [inPath fill];
    [inPath stroke];
    //画圆环
    for (int i=0; i < 5; i++) {
        CGPoint inP = [_inPointArr[i] CGPointValue];
        UIBezierPath *ringPath = [UIBezierPath bezierPathWithArcCenter:inP radius:5 startAngle:0 endAngle:2*M_PI clockwise:0];
        [ringPath addArcWithCenter:inP radius:5 startAngle:0 endAngle:3*M_PI clockwise:0];
        [self.backgroundColor setFill];
        [ringPath fill];
        [ringPath stroke];
    }
}

- (void)refreshWithValues:(NSArray*)values animate:(BOOL)animated{
    if (values && [values isKindOfClass:[NSArray class]] && values.count==5) {
        _values = [values mutableCopy];
        [self reSetViewSize];
        [self creatBtn];
        if (!animated)
        {
            [self setNeedsDisplay];
        }
        else
        {
            if (!_timer) {
                _timer = 0;
                _tempValues = [_values mutableCopy];
                _timer = [NSTimer timerWithTimeInterval:_interval target:self selector:@selector(timerAct) userInfo:nil repeats:YES];
                [[NSRunLoop mainRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
                [_timer
                 setFireDate:[NSDate distantPast]];
            }
        }
    }
}
-(void)timerAct
{
    if (_timerRec<=20) {
        _values = [NSMutableArray new];
        for (int i=0; i<_tempValues.count; i++) {
            NSNumber *newValue = [NSNumber numberWithFloat:[_tempValues[i] floatValue]*_timerRec/20];
            [_values addObject:newValue];
        }
        _timerRec++;
        [self setNeedsDisplay];
    }
    else{
        [_timer setFireDate:[NSDate distantFuture]];
        _timerRec = 0;
    }
}
-(void)creatBtn
{
    if (self.subviews.count>=5) {
        return;
    }
    for (int i = 0; i < 5; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        btn.frame = CGRectMake(0, 0, 80, 30);
        btn.tag = 1990 + i;
        CGPoint center = [_outPointArr[i] CGPointValue];
        switch (i) {
            case 0:
            {
                btn.center = CGPointMake(center.x-3+btn.frame.size.width/2, center.y);
                [btn setTitle:@"还贷能力" forState:UIControlStateNormal];
            }
                break;
            case 1:
            {
                btn.center = CGPointMake(center.x, center.y-btn.frame.size.height/2);
                [btn setTitle:@"投资分布" forState:UIControlStateNormal];
               
            }
                   break;
            case 2:
            {
                btn.center = CGPointMake(center.x+10-btn.frame.size.width/2, center.y);
                [btn setTitle:@"流动性" forState:UIControlStateNormal];
              
            }
               break;
            case 3:
            {
                btn.center = CGPointMake(center.x + 10 -btn.frame.size.width/2, center.y-btn.frame.size.height/2+15);
                [btn setTitle:@"保险" forState:UIControlStateNormal];
                btn.titleEdgeInsets=UIEdgeInsetsMake(0,15, 0, 0);
               
                //                [btn setTitleColor:[UIColor colorWithRed:0.11 green:0.54 blue:1 alpha:1] forState:UIControlStateNormal];
            }
                break;
            case 4:
            {
                btn.center = CGPointMake(center.x+btn.frame.size.width/2-10, center.y-btn.frame.size.height/2+15);
                [btn setTitle:@"信用" forState:UIControlStateNormal];
                btn.titleEdgeInsets=UIEdgeInsetsMake(0,0, 0, 15);
            }
                break;
            default:
                break;
        }
        [self addSubview:btn];
        btn.titleLabel.font=[UIFont systemFontOfSize:14];
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
}

- (void)btnClick:(UIButton*)btn{
    /**
     *   0-4  x轴逆时针
     */
    NSLog(@"%li",btn.tag-1990);
    [_delegate HealthExamViewClickIndex:btn.tag-1990];
    
}







@end

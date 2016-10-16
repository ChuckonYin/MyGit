//
//  YZTProgressButtun.m
//  YZTProgressButtun
//
//  Created by ChuckonYin on 16/4/22.
//  Copyright © 2016年 pinAn.com. All rights reserved.
//

#import "YZTProgressButtun.h"

@interface YZTProgressButtun()

@property (nonatomic, assign) CGFloat cr;

@property (nonatomic, assign) CGPoint centerP;

@property (nonatomic, strong) CAShapeLayer *progressLayer;

@property (nonatomic, copy) void(^clickAction)();

@property (nonatomic, copy) void(^endAction)();

@property (nonatomic, strong) NSTimer *timer;

@property (nonatomic, assign) CGFloat currentProgress;

@property (nonatomic, assign) NSTimeInterval interval;

@end

@implementation YZTProgressButtun

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.centerP = CGPointMake(frame.size.width/2.0, frame.size.height/2.0);
        self.cr = frame.size.width/2.0;
        self.clipsToBounds = YES;
        self.layer.cornerRadius = self.cr;
        [self.layer addSublayer:self.progressLayer];
        [self setTitle:@"跳过" forState:UIControlStateNormal];
        self.titleLabel.font = [UIFont systemFontOfSize:15];
        [self addTarget:self action:@selector(clickBtn) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextAddArc(ctx, _centerP.x, _centerP.y, _cr-5, 0, M_PI*2.0, YES);
    CGContextSetRGBStrokeColor(ctx, 0.5, 0.5, 0.5, 0.5);
    CGContextSetLineWidth(ctx, 2.5);
    CGContextStrokePath(ctx);
}

- (CAShapeLayer *)progressLayer{
    if (!_progressLayer) {
        _progressLayer = [CAShapeLayer layer];
        _progressLayer.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
        _progressLayer.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.4].CGColor;
        _progressLayer.strokeColor = [UIColor whiteColor].CGColor;
        _progressLayer.fillColor = [UIColor clearColor].CGColor;
        _progressLayer.lineWidth = 2.5;
        UIBezierPath *circlePath = [UIBezierPath bezierPathWithArcCenter:self.centerP radius:_cr-5 startAngle:-M_PI/2.0 endAngle:M_PI*1.5 clockwise:YES];
        _progressLayer.path = circlePath.CGPath;
        _progressLayer.strokeStart = 0;
        _progressLayer.strokeEnd = 0;
    }
    return _progressLayer;
}

- (void)clickBtn{
    _endAction = nil;
    [_timer invalidate];
    _timer = nil;
    self.progressLayer.strokeEnd = 1.0;
    if (_clickAction) {
        _clickAction();
    }
}

- (void)startWithTimeInterval:(NSTimeInterval)interval clickAction:(void(^)())clickAction endAction:(void(^)())endAction{
    _clickAction = clickAction;
    _endAction = endAction;
    _interval = interval;
    [self startAnimation];
}

- (void)startAnimation{
    _currentProgress = 0;
    _timer = [NSTimer scheduledTimerWithTimeInterval:_interval/50.0 target:self selector:@selector(refreshProgress:) userInfo:nil repeats:YES];
}

- (void)refreshProgress:(NSTimer *)timer{
    if (_currentProgress>1.00001) {
        [timer invalidate];
        if (_endAction) {
            _endAction();
        }
    }
    else{
        self.progressLayer.strokeEnd = _currentProgress;
    }
    _currentProgress += 1.0/50.0;
}

- (void)dealloc{
    NSLog(@"");
}

@end





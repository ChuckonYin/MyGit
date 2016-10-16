//
//  PercentScanView.m
//  1102扫描盘（新）
//
//  Created by ChuckonYin on 15/11/2.
//  Copyright © 2015年 PingAn. All rights reserved.
//

#import "PercentScanView.h"
//刻标内外半径
#define R0 (_insideR - 30)
#define R1 (_insideR - 24)
//最外层圆弧
#define outR (_insideR  + 25)

@interface PercentScanView()
{
    CGSize _size;
    //小刻标间距角
    CGFloat _minAngle;
    CGPoint _zeroP;
    CGFloat _startAngle;
    CGFloat _endAngle;
    //渐变色圆弧内半径
    CGFloat _insideR;
    
    ScanRuler *_ruler;
    //标尺偏转半径
    CGFloat _rulerR;
    CGFloat _endRulerAngle;
    NSTimer *_timer;
    NSInteger _timerRec;
}
@end

@implementation PercentScanView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        _totalPercent = 0.70f;
        _scale = 1.0;
        _markNumber = 50;
        _interval = 0.02;
        _dscViewBounds = CGRectMake(0, 0, frame.size.width/4, frame.size.width/4);
        [self initSubviews];
    }
    return self;
}

- (void)initSubviews{
    //初始化数据
    _size = self.frame.size;
    _zeroP      = CGPointMake(_size.width/2, _size.height/2+_vertical);
    _minAngle   = 2*M_PI*_totalPercent/(_markNumber-1);
    _startAngle = M_PI/2 + 2*M_PI*(1-_totalPercent)/2;
    _endAngle   = _startAngle + 2*M_PI*_totalPercent;
    _insideR    = _size.width/4*_scale;
    
    _ruler = [[ScanRuler alloc] initWithFrame:CGRectMake(20, 20, 35, 18)];
    _rulerR = _insideR - (_ruler.width/2-_ruler.cr);
    [self addSubview:_ruler];
    
    [self addDscView];
}

-(void)addDscView
{
    _dscView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, _dscViewBounds.size.width, _dscViewBounds.size.height)];
    _dscView.center = _zeroP;
    _dscView.backgroundColor = [UIColor lightGrayColor];
    [self addSubview:_dscView];
    
    CGFloat dscViewW = _dscView.frame.size.width;
    CGFloat dscLabelH = _dscView.frame.size.height/5;
    
    _lable0 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, dscViewW, dscLabelH)];
    _lable0.text = @"好信分";
    _lable0.textAlignment = NSTextAlignmentCenter;
    _lable0.font = [UIFont systemFontOfSize:14];
    _lable0.textColor = [UIColor whiteColor];
    [_dscView addSubview:_lable0];
    
    _lable1 = [[UILabel alloc] initWithFrame:CGRectMake(0, dscLabelH, dscViewW, dscLabelH*2)];
    _lable1.text = @"716";
    _lable1.font = [UIFont systemFontOfSize:30];
    _lable1.textAlignment = NSTextAlignmentCenter;
    _lable1.textColor = [UIColor whiteColor];
    [_dscView addSubview:_lable1];
    
    _lable2 = [[UILabel alloc] initWithFrame:CGRectMake(0, dscLabelH*3, dscViewW, dscLabelH)];
    _lable2.text = @"信用极好";
    _lable2.textAlignment = NSTextAlignmentCenter;
    _lable2.font = [UIFont systemFontOfSize:14];
    _lable2.textColor = [UIColor whiteColor];
    [_dscView addSubview:_lable2];
    
    _lable3 = [[UILabel alloc] initWithFrame:CGRectMake(0, dscLabelH*4, dscViewW, dscLabelH)];
    _lable3.text = @"高于99%的用户";
    _lable3.textAlignment = NSTextAlignmentCenter;
    _lable3.font = [UIFont systemFontOfSize:10];
    _lable3.textColor = [UIColor whiteColor];
    [_dscView addSubview:_lable3];
}

-(void)setDscViewBounds:(CGRect)dscViewBounds
{
    if (_dscView) {
        [_dscView removeFromSuperview];
    }
    [self addDscView];
}

- (void)drawRect:(CGRect)rect {
    //最外层圆弧
    UIBezierPath *linePath = [UIBezierPath bezierPathWithArcCenter:_zeroP radius:outR startAngle:_startAngle endAngle:_endAngle clockwise:1];
    linePath.lineWidth = 2.5;
    [[UIColor whiteColor] setStroke];
    [linePath stroke];
    //
    UIBezierPath *imgPath = [UIBezierPath bezierPathWithArcCenter:_zeroP radius:_insideR startAngle:_startAngle endAngle:_endAngle clockwise:1];
    imgPath.lineWidth = 15;
    
   
    
    [[UIColor colorWithPatternImage:newImg]setStroke];
    [imgPath stroke];
    
    UIBezierPath *markPath = [UIBezierPath bezierPath];
    for (int i=0; i<_markNumber; i++) {
        CGFloat angle = _startAngle + i*_minAngle;
        CGPoint inP;CGPoint outP;
        if ((i-2)%5==0) {
            inP  = CGPointMake(_zeroP.x + (R0-2)*cos(angle), _zeroP.y + (R0-2)*sin(angle));
            outP = CGPointMake(_zeroP.x + (R1+2)*cos(angle), _zeroP.y + (R1+2)*sin(angle));
        }
        else{
            inP  = CGPointMake(_zeroP.x + R0*cos(angle), _zeroP.y + R0*sin(angle));
            outP = CGPointMake(_zeroP.x + R1*cos(angle), _zeroP.y + R1*sin(angle));
        }
        [markPath moveToPoint:inP];
        [markPath addLineToPoint:outP];
    }
    [[UIColor whiteColor] setStroke];
    [markPath stroke];
}

- (void)refreshViewValue:(NSNumber*)value and:(NSArray *)dscInfos animate:(BOOL)animated{
    _value = [value floatValue];
    _dscInfos = dscInfos;
    _endRulerAngle = _startAngle + _value*_markNumber*_minAngle;
    if (!animated)
    {
        _ruler.center = CGPointMake(_zeroP.x + _rulerR*cos(_endRulerAngle), _zeroP.y + _rulerR*sin(_endRulerAngle));
        _ruler.transform = CGAffineTransformMakeRotation(_endRulerAngle);
        [self refreshDescribeView];
    }
    else if (animated)
    {
        if (!_timer) {
            _timer = [NSTimer timerWithTimeInterval:_interval target:self selector:@selector(timerAct) userInfo:nil repeats:YES];
            [[NSRunLoop mainRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
        }
        [_timer setFireDate:[NSDate date]];
    }
}

- (void)timerAct{
    
    if (_timerRec<=100.0f*_value) {
        CGFloat currentAngle = _startAngle+(_endRulerAngle-_startAngle)*_timerRec/(100.0f*_value);
        _ruler.center = CGPointMake(_zeroP.x + _rulerR*cos(currentAngle), _zeroP.y + _rulerR*sin(currentAngle));
        _ruler.transform = CGAffineTransformMakeRotation(currentAngle);
        _timerRec ++;
    }
    else{
        [self refreshDescribeView];
        [_timer setFireDate:[NSDate distantFuture]];
        _timerRec = 0;
    }
}

-(void)refreshDescribeView
{
    _lable1.text= _dscInfos[0];
    _lable2.text= _dscInfos[1];
    _lable3.text= _dscInfos[2];
}

-(UIImage*) OriginImage:(UIImage *)image scaleToSize:(CGSize)size
{
    UIGraphicsBeginImageContext(size);  //size 为CGSize类型，即你所需要的图片尺寸
    
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return scaledImage;   //返回的就是已经改变的图片
}

@end

@interface ScanRuler ()
{
    CGPoint _zeroP;
}
@end

@implementation ScanRuler

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        _cr = frame.size.height/2-2;
        _zeroP = CGPointMake(frame.size.width-_cr-2, _cr+2);
        _width = frame.size.width;
        _height = frame.size.height;
    }
    return self;
}

- (void)drawRect:(CGRect)rect{
    UIBezierPath *circlePath = [UIBezierPath bezierPathWithArcCenter:_zeroP radius:_cr startAngle:0 endAngle:M_PI*2 clockwise:1];
    [[UIColor orangeColor] setStroke];
    [[UIColor whiteColor] setFill];
    circlePath.lineWidth = 2;
    [circlePath fill];
    [circlePath stroke];
    
    UIBezierPath *rectPath = [UIBezierPath bezierPath];
    [rectPath moveToPoint:CGPointMake(0, _zeroP.y-_cr/6)];
    [rectPath addLineToPoint:CGPointMake(0, _zeroP.y+_cr/6)];
    [rectPath addLineToPoint:CGPointMake(_zeroP.x-_cr*2/4, _zeroP.y+_cr*2/4)];
    [rectPath addLineToPoint:CGPointMake(_zeroP.x, _zeroP.y-_cr*2/4)];
    [[UIColor whiteColor] setFill];
    [rectPath fill];
    [[UIColor whiteColor] setStroke];
    [rectPath stroke];
    
}


@end








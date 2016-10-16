//
//  WealthAcceleratorView.m
//  16_0318财富加速器
//
//  Created by ChuckonYin on 16/3/18.
//  Copyright © 2016年 PingAn. All rights reserved.
//

#import "WealthAcceleratorView.h"
#import "NSTimer+YYAdd.h"

#define WealthAcceleratorViewTextDefaultColor [UIColor colorWithHex:0xb0b7cb alpha:0.64]


const CGFloat WealthAcceleratorViewR3 = 112.0f;
const CGFloat WealthAcceleratorViewR2 = 50.0f;
const CGFloat WealthAcceleratorViewR1 = 25.0f;
const CGFloat WealthAcceleratorViewR0 = 11.0f;
const CGFloat WealthAcceleratorViewPercentNumberFont = 20;
const CGFloat WealthAcceleratorViewWidth3 = 25.0f;
const CGFloat WealthAcceleratorViewBottomHeight = 60.0f;

static inline UIImage* wa_imageShotLayer(CALayer *layer){
    UIGraphicsBeginImageContextWithOptions(layer.bounds.size, layer.opaque, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    [layer renderInContext:context];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

static inline NSString* wa_LevelName(WealthAcceleratorViewLevel level){
    return @[@"较差",@"待提升",@"一般",@"良好",@"优秀"][level];
}

static inline CGFloat wa_timerCurrrent_PI_Angle(CGFloat timerFlag){
    return -M_PI + timerFlag * M_PI;
}

@interface WealthAcceleratorView()
{
    CGFloat _mHeight;
    CGFloat _R3, _R2 , _R1, _R0; //由外到内圆半径
    CGFloat _width3; // 外圈宽度
    CGPoint _zeroP;
}
//DATA
@property (nonatomic, assign) BOOL animated;
@property (nonatomic, assign) CGFloat levelPercent;
@property (nonatomic, copy) NSString *precisePercent;  //精确的百分比
@property (nonatomic, assign) WealthAcceleratorViewLevel level;//5个等级
@property (nonatomic, strong) NSArray *arrowColors;
@property (nonatomic, strong) NSArray *grandientColors;
//UI
@property (nonatomic, strong) NSMutableArray <UILabel *>*levelLabs;
@property (nonatomic, strong) UILabel *leftDetailLab, *rightDetailLab;
@property (nonatomic, strong) UIView *bottomCover;
@property (nonatomic, strong) NSMutableArray <WealthAcceleratorViewWhiteGradientLine *>*whiteGradientLines;
@property (nonatomic, strong) WealthAcceleratorViewArrow *arrow;
//animation
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, assign) CGFloat timerFlag;
@end

@implementation WealthAcceleratorView

- (instancetype)init{
    if (self = [super initWithFrame:CGRectMake(0, 0, kScreenWidth, WealthAcceleratorViewHeight)]) {
//        self.backgroundColor = [UIColor colorWithRed:0.23 green:0.35 blue:0.6 alpha:1];
        self.backgroundColor = kGlobalColor;
        _mHeight = WealthAcceleratorViewHeight;
        _width3 = WealthAcceleratorViewWidth3;
        _R3 = WealthAcceleratorViewR3 * kScreenWidth/375.0f;
        _R2 = WealthAcceleratorViewR2 * kScreenWidth/375.0f;
        _R1 = WealthAcceleratorViewR1 * kScreenWidth/375.0f;
        _R0 = WealthAcceleratorViewR0 * kScreenWidth/375.0f;
        _zeroP = CGPointMake(kScreenWidth/2.0, WealthAcceleratorViewHeight - 60.0);
        [self initSubviews];
    }
    return self;
}

- (void)initSubviews{
    //等级文字
    self.levelLabs = [[NSMutableArray alloc] initWithCapacity:5];
    self.whiteGradientLines = [[NSMutableArray alloc] initWithCapacity:5];
    for (int i=0; i<5; i++) {
        UILabel *levelLab = [[UILabel alloc] initWithFrame:CGRectMake(-100, -100, 14*3, 14)];
        CGFloat angel = -M_PI + (((CGFloat)i)*0.25) * M_PI;
        CGPoint arrowTip = CGPointMake(_zeroP.x+(_R3+40)*cosf(angel), _zeroP.y+(_R3+40)*sinf(angel));
        levelLab.center = arrowTip;
        [self addSubview:levelLab];
        levelLab.textColor = WealthAcceleratorViewTextDefaultColor;
        levelLab.font = [UIFont systemFontOfSize:14];
        levelLab.text = wa_LevelName(i);
        levelLab.textAlignment = NSTextAlignmentCenter;
        [self.levelLabs addObject:levelLab];
        //画5根渐变细线
        WealthAcceleratorViewWhiteGradientLine *whiteGradientLine = [[WealthAcceleratorViewWhiteGradientLine alloc] initWithFrame:CGRectMake(_zeroP.x-_R3-_width3/2-2, _zeroP.y-1.5, (_R3+_width3/2+2)*2, 1.5)];
        whiteGradientLine.transform = CGAffineTransformMakeRotation(M_PI*((CGFloat)i)/4.0);
        [self addSubview:whiteGradientLine];
        [self.whiteGradientLines addObject:whiteGradientLine];
    }
    
    [self addSubview:self.arrow];
    [self.arrow refreshColor:[UIColor clearColor]];
//    [self addSubview:[self centerTowCircle]];
    [self addSubview:[self R1View]];
    [self addSubview:[self R0View]];
    [self addSubview:self.bottomCover];
  
   
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    //画R3
    UIBezierPath *path3 = [UIBezierPath bezierPathWithArcCenter:_zeroP radius:_R3 startAngle:0 endAngle:-M_PI clockwise:NO];
    [[UIColor colorWithRed:0.32 green:0.43 blue:0.65 alpha:0.8] setStroke];
    path3.lineWidth = _width3;
    [path3 stroke];
    //画R2
    UIBezierPath *path2 = [UIBezierPath bezierPathWithArcCenter:_zeroP radius:_R2 startAngle:0 endAngle:-M_PI clockwise:NO];
    [[UIColor colorWithRed:0.32 green:0.43 blue:0.65 alpha:0.8] setFill];
//    [path2 closePath];
    [path2 fill];
    //画渐变色
    CGFloat currentAngel = _level == WealthAcceleratorViewLevelBad ? 0 : wa_timerCurrrent_PI_Angle(_timerFlag);
    UIBezierPath *grandientPath = [UIBezierPath bezierPathWithArcCenter:_zeroP radius:_R2 startAngle:-M_PI endAngle:currentAngel clockwise:YES];
    [grandientPath addLineToPoint:_zeroP];
    [grandientPath closePath];
    [[UIColor colorWithPatternImage:[self getGrandientImage]] setFill];
    [grandientPath fill];
    //画R1
    UIBezierPath *path1 = [UIBezierPath bezierPathWithArcCenter:_zeroP radius:_R1 startAngle:0 endAngle:-M_PI clockwise:NO];
    [[UIColor colorWithRed:0.87 green:0.87 blue:0.87 alpha:1] setFill];
    [path1 fill];
    //画R0
    UIBezierPath *path0 = [UIBezierPath bezierPathWithArcCenter:_zeroP radius:_R0 startAngle:0 endAngle:-M_PI clockwise:NO];
    [[UIColor colorWithRed:0.94 green:0.94 blue:0.94 alpha:1] setFill];
    [path0 fill];
    //文字颜色动态变化
    for (int i=0; i<4; i++) {
        if (i==(int)roundf(_timerFlag/0.25)) {
            _levelLabs[i].textColor = _arrowColors[i];
//            [_arrow refreshColor:_arrowColors[i]];
        }
        else{
            _levelLabs[i].textColor = WealthAcceleratorViewTextDefaultColor;
        }
    }
    
    CAGradientLayer *layer = [CAGradientLayer layer];
//    layer.frame = self.bounds;
//    layer.colors = @[(id)([UIColor redColor].CGColor),(id)([UIColor yellowColor].CGColor),(id)([UIColor whiteColor].CGColor),(id)([UIColor greenColor].CGColor),(id)([UIColor blackColor].CGColor)];
//    layer.locations = @[@0.1,@0.1,@0.1,@0.0,@0.4,@0.5];
//    layer.startPoint = CGPointMake(0.5, 0);
//    layer.endPoint = CGPointMake(0.5, 1);
//    [self.layer addSublayer:layer];
}

#pragma mark - refersh & timer

- (void)refreshWithLevel:(WealthAcceleratorViewLevel )level precisePercent:(NSString *)precisePercent animated:(BOOL)animated{
    _level = level;
    _precisePercent = precisePercent;
    _animated = animated;
    [self.arrow refreshColor:self.arrowColors[_level]];
    if (_animated) {
         [self startAnimation];
    }
    else{
        self.arrow.transform = CGAffineTransformMakeRotation(self.levelPercent*M_PI);
        [self setNeedsDisplay];
        [self refreshUI];
    }
}

- (void)startAnimation{
    _timerFlag = 0.0f;
    __unsafe_unretained WealthAcceleratorView *weakSelf = self;
    if (!_timer) {
        _timer = [NSTimer timerWithTimeInterval:0.0001 block:^(NSTimer *timer) {
            if (weakSelf.timerFlag>weakSelf.levelPercent) {
                weakSelf.timerFlag = weakSelf.levelPercent;
                weakSelf.arrow.transform = CGAffineTransformMakeRotation(weakSelf.timerFlag*M_PI);
                [weakSelf setNeedsDisplay];
                [weakSelf refreshUI];
                [timer setFireDate:[NSDate distantFuture]];
                [timer invalidate];
            }
            else{
                weakSelf.arrow.transform = CGAffineTransformMakeRotation(_timerFlag*M_PI);
                [self setNeedsDisplay];
                _timerFlag += 0.007;
            }
        } repeats:YES];
        [[NSRunLoop mainRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
    }
    [_timer setFireDate:[NSDate distantPast]];
}

- (void)refreshUI{
    for (int i=0; i<5; i++) {
        self.levelLabs[i].textColor = self.level == i ? self.arrowColors[i] : [UIColor colorWithRed:0.56 green:0.62 blue:0.73 alpha:1.00];
        self.whiteGradientLines[i].hidden = i==_level;
    }
    self.leftDetailLab.text = [NSString stringWithFormat:@"财富配置能力：%@", wa_LevelName(_level)];
    NSMutableAttributedString *attriText = [[NSMutableAttributedString alloc] initWithString:@"超越 75% 同龄用户"];
    [attriText addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:WealthAcceleratorViewPercentNumberFont], NSForegroundColorAttributeName:[UIColor whiteColor]} range:NSMakeRange(2, 4)];
    _rightDetailLab.attributedText = attriText;
}

#pragma mark - set & get

- (UIImage *)getGrandientImage{
    CAGradientLayer *layer = [CAGradientLayer layer];
    layer.frame = CGRectMake(_zeroP.x-_R2, _zeroP.y-_R2, _R2*2, _R2);
    switch (self.level) {
        case WealthAcceleratorViewLevelBad:{
            CGFloat components[8]={
                1.0, 0.0, 0.0, 0.6,     //start color(r,g,b,alpha)
                1.0, 0.0, 0.0, 0.2      //end color
            };
            CGColorSpaceRef space = CGColorSpaceCreateDeviceRGB();
            CGGradientRef gradient = CGGradientCreateWithColorComponents(space, components, NULL,2);
            CGColorSpaceRelease(space),space=NULL;//release
            
            CGPoint start = _zeroP;
            CGPoint end = _zeroP;
            CGFloat startRadius = 0.0f;
            CGFloat endRadius = _R2;
            CGContextRef graCtx = UIGraphicsGetCurrentContext();
            CGContextDrawRadialGradient(graCtx, gradient, start, startRadius, end, endRadius, 0);
            CGGradientRelease(gradient),gradient=NULL;//release
            break;
        }
        case WealthAcceleratorViewLevelExcellent: {
            CGFloat components[8]={
                0.13, 0.71, 0.99, 0.6,     //start color(r,g,b,alpha)
                0.13, 0.71, 0.99, 0.1      //end color
            };
            CGColorSpaceRef space = CGColorSpaceCreateDeviceRGB();
            CGGradientRef gradient = CGGradientCreateWithColorComponents(space, components, NULL,2);
            CGColorSpaceRelease(space),space=NULL;//release
            
            CGPoint start = _zeroP;
            CGPoint end = _zeroP;
            CGFloat startRadius = 0.0f;
            CGFloat endRadius = _R2;
            CGContextRef graCtx = UIGraphicsGetCurrentContext();
            CGContextDrawRadialGradient(graCtx, gradient, start, startRadius, end, endRadius, 0);
            CGGradientRelease(gradient),gradient=NULL;//release
            break;
        }
        case WealthAcceleratorViewLevelDeveloping:
        case WealthAcceleratorViewLevelNormal:
        case WealthAcceleratorViewLevelGood: {
            layer.startPoint = CGPointMake(0, 1);
            layer.endPoint = CGPointMake(0.5-cosf(self.levelPercent*M_PI), 1-sinf(self.levelPercent*M_PI));
            layer.colors =self.grandientColors[self.level];
            break;
        }
    }
    [self.layer addSublayer:layer];
    UIImage *img = wa_imageShotLayer(self.layer);
    [layer removeFromSuperlayer];
    return img;
}

- (UIView *)centerTowCircle{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, _zeroP.y)];
    view.clipsToBounds = YES;
    [view addSubview:[self R1View]];
    [view addSubview:[self R0View]];
    return view;
}

- (UIView *)R1View{
    UIView *r1View = [[UIView alloc] initWithFrame:CGRectMake(_zeroP.x-_R1, _zeroP.y-_R1, _R1*2.0, _R1*2.0)];
    r1View.backgroundColor = [UIColor colorWithRed:0.87 green:0.87 blue:0.87 alpha:1.00];
    r1View.layer.cornerRadius = _R1;
    r1View.clipsToBounds = YES;
    return r1View;
}

- (UIView *)R0View{
    UIView *r0View = [[UIView alloc] initWithFrame:CGRectMake(_zeroP.x-_R0, _zeroP.y-_R0, _R0*2.0, _R0*2.0)];
    r0View.backgroundColor = [UIColor whiteColor];
    r0View.layer.cornerRadius = _R0;
    r0View.clipsToBounds = YES;
    return r0View;
}

- (WealthAcceleratorViewArrow *)arrow{
    if (!_arrow) {
        _arrow = [[WealthAcceleratorViewArrow alloc] initWithFrame:CGRectMake(_zeroP.x-_R3-_width3/2.0, _zeroP.y-8, (_R3+_width3/2.0)*2, 16)];
    }
    return _arrow;
}

- (NSArray *)arrowColors{
    if (!_arrowColors) {
        _arrowColors = @[[UIColor colorWithRed:0.93 green:0.27 blue:0.27 alpha:1.00],
                         [UIColor colorWithRed:0.99 green:0.58 blue:0.04 alpha:1.00],
                         [UIColor colorWithRed:1.00 green:0.95 blue:0.24 alpha:1.00],
                         [UIColor colorWithHex:0x57d96c alpha:1],
                         [UIColor colorWithRed:0.13 green:0.71 blue:1.00 alpha:1.00]];
    }
    return _arrowColors;
}

- (NSArray *)grandientColors{
    if (!_grandientColors) {
        _grandientColors = @[@[(id)([UIColor colorWithRed:0.99 green:0.30 blue:0.30 alpha:0.45].CGColor),(id)([UIColor colorWithRed:0.99 green:0.30 blue:0.30 alpha:0.45].CGColor)],
                             @[(id)([UIColor colorWithRed:0.99 green:0.58 blue:0.04 alpha:0.0].CGColor),(id)([UIColor colorWithRed:0.99 green:0.58 blue:0.04 alpha:1.00].CGColor)],
                             @[(id)([UIColor colorWithRed:1.00 green:0.95 blue:0.24 alpha:0.0].CGColor),(id)([UIColor colorWithRed:1.00 green:0.95 blue:0.24 alpha:1.00].CGColor)],
                             @[(id)([UIColor colorWithRed:0.34 green:0.85 blue:0.42 alpha:0.0].CGColor),(id)([UIColor colorWithRed:0.34 green:0.85 blue:0.42 alpha:1.00].CGColor)],
                             @[(id)([UIColor colorWithRed:0.13 green:0.71 blue:1.0 alpha:0.0].CGColor),(id)([UIColor colorWithRed:0.13 green:0.71 blue:1.00 alpha:1.00].CGColor)]];
    }
    return _grandientColors;
}

- (UILabel *)leftDetailLab{
    if (!_leftDetailLab) {
        _leftDetailLab = [[UILabel alloc] initWithFrame:CGRectMake(_R3 + _width3/2.0 - kScreenWidth/2.0, WealthAcceleratorViewBottomHeight-40, kScreenWidth/2-15, 25)];
        _leftDetailLab.textColor = [UIColor colorWithRed:0.62 green:0.67 blue:0.79 alpha:1];
        _leftDetailLab.textAlignment = NSTextAlignmentRight;
        _leftDetailLab.font = [UIFont systemFontOfSize:12];
        _leftDetailLab.text = @"财富配置能力：暂无";
    }
    return _leftDetailLab;
}

- (UILabel *)rightDetailLab{
    if (!_rightDetailLab) {
        _rightDetailLab = [[UILabel alloc] initWithFrame:CGRectMake(_R3+_width3/2.0+15, WealthAcceleratorViewBottomHeight-40, kScreenWidth/2-15, 25)];
        _rightDetailLab.textColor = [UIColor colorWithRed:0.62 green:0.67 blue:0.79 alpha:1];
        _rightDetailLab.textAlignment = NSTextAlignmentLeft;
        _rightDetailLab.font = [UIFont systemFontOfSize:12];
        
        NSMutableAttributedString *attriText = [[NSMutableAttributedString alloc] initWithString:@"超越 0% 同龄用户"];
        [attriText addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:WealthAcceleratorViewPercentNumberFont], NSForegroundColorAttributeName:[UIColor whiteColor]} range:NSMakeRange(2, 4)];
        _rightDetailLab.attributedText = attriText;
        //位置矫正
        CGFloat fontErrorHeight = ([UIFont systemFontOfSize:WealthAcceleratorViewPercentNumberFont].ascender - [UIFont systemFontOfSize:14].ascender)/2;
        _rightDetailLab.frame = CGRectMake(_rightDetailLab.frame.origin.x, _rightDetailLab.frame.origin.y - fontErrorHeight, kScreenWidth/2-15, 25);
        
    }
    return _rightDetailLab;
}

- (UIView *)bottomCover{
    if (!_bottomCover) {
        _bottomCover = [[UIView alloc] initWithFrame:CGRectMake(_zeroP.x-_R3-_width3/2.0, WealthAcceleratorViewHeight - WealthAcceleratorViewBottomHeight, 2.0*_R3 + _width3, WealthAcceleratorViewBottomHeight)];
        _bottomCover.backgroundColor = self.backgroundColor;
        UIView *centerLine = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 130, 1)];
        centerLine.center = CGPointMake(_bottomCover.frame.size.width/2, 0);
        centerLine.backgroundColor = [UIColor whiteColor];
        
        [_bottomCover addSubview:centerLine];
        [_bottomCover addSubview:self.leftDetailLab];
        [_bottomCover addSubview:self.rightDetailLab];
    }
    return _bottomCover;
}

- (CGFloat)levelPercent{
    return ((CGFloat)self.level)/4.0f;
}

- (void)dealloc{
    NSLog(@"WealthAcceleratorView_____dealloc");
}

@end

#pragma mark - WealthAcceleratorViewWhiteGradientLine

@implementation WealthAcceleratorViewWhiteGradientLine
{
    CGFloat _mWidth;
    CGFloat _mHeight;
}
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        _mWidth = frame.size.width;
        _mHeight = frame.size.height;
//        [self initUI];
    }
    return self;
}

- (void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(0, 0)];
    [path addLineToPoint:CGPointMake(0, 1.5)];
    [path addLineToPoint:CGPointMake(WealthAcceleratorViewWidth3+2, 1.25)];
    [path addLineToPoint:CGPointMake(WealthAcceleratorViewWidth3+2, 0.25)];
    [path closePath];
    [[UIColor colorWithPatternImage:[self gradientImage]] setFill];
    [path fill];
}

- (UIImage *)gradientImage{
    CAGradientLayer *layer = [CAGradientLayer layer];
    layer.frame = CGRectMake(0, 0, WealthAcceleratorViewWidth3+2, 10);
    layer.colors = @[(id)([UIColor colorWithRed:1 green:1 blue:1 alpha:1].CGColor),
                     (id)([UIColor colorWithRed:1 green:1 blue:1 alpha:0.1].CGColor)];
    layer.startPoint = CGPointMake(0, 0);
    layer.endPoint = CGPointMake(1, 0);
    [self.layer addSublayer:layer];
    UIImage *img = wa_imageShotLayer(self.layer);
    [layer removeFromSuperlayer];
    return img;
}

@end

#pragma mark - WealthAcceleratorViewArrow

@implementation WealthAcceleratorViewArrow

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)refreshColor:(UIColor *)color{
    _color = color;
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(0, self.bounds.size.height/2.0)];
    [path addLineToPoint:CGPointMake(self.bounds.size.width/2.0, 0)];
    [path addLineToPoint:CGPointMake(self.bounds.size.width/2.0, self.bounds.size.height)];
    [path closePath];
    [_color setFill];
    [path fill];
}

@end



@implementation UIColor(YZT)

+ (UIColor *)colorWithHex:(NSInteger)hex alpha:(CGFloat)alpha
{
    return [UIColor colorWithRed:((hex & 0XFF0000) >> 16) / 255.0
                           green:((hex & 0X00FF00) >> 8)  / 255.0
                            blue:(hex & 0X0000FF)         / 255.0
                           alpha:alpha];
}


@end











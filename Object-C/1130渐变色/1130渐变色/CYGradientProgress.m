//
//  CYGradientProgress.m
//  1130渐变色
//
//  Created by ChuckonYin on 15/12/1.
//  Copyright © 2015年 PingAn. All rights reserved.
//

#import "CYGradientProgress.h"

#define point(x,y) CGPointMake(x,y)

@interface CYGradientProgress()
{
    CGFloat mWidth;
    CGFloat mHeight;
    CGFloat width;
    NSTimer *_timer;
    NSInteger _timerRec;
}

@property (nonatomic, strong) CAShapeLayer *shapeLayer;

@end

@implementation CYGradientProgress

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        mWidth = frame.size.width;
        mHeight = frame.size.height;
        width = mWidth/2;
        [self circleProgressConstruct];
    }
    return self;
}

-(void)circleProgressConstruct
{
    self.shapeLayer = [CAShapeLayer layer];

    self.shapeLayer.frame = CGRectMake(0, 0, mWidth, mHeight);
//    self.shapeLayer.backgroundColor = [UIColor lightGrayColor].CGColor;
    [self.layer addSublayer:self.shapeLayer];

    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:point(width, width) radius:width-5 startAngle:0 endAngle:2*M_PI clockwise:1];
    self.shapeLayer.path = path.CGPath;

    self.shapeLayer.strokeColor = [UIColor colorWithPatternImage:[self getImgScreenShot]].CGColor;
    self.shapeLayer.lineWidth = 5;
    self.shapeLayer.fillColor = [UIColor whiteColor].CGColor;

    [self addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startTimer)]];
    self.shapeLayer.strokeStart = 0.0;
    self.shapeLayer.strokeEnd = 0.0;

}

-(void)startTimer{
    if (!_timer) {
        _timer = [NSTimer timerWithTimeInterval:0.1 target:self selector:@selector(timerProgress) userInfo:nil repeats:YES];
        [[NSRunLoop mainRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
        _timerRec = 200;
    }
}

-(void)timerProgress{
    if (self.shapeLayer.strokeStart==0 && self.shapeLayer.strokeEnd<1.0) {
        self.shapeLayer.strokeEnd += 0.1;
    }
    else if (self.shapeLayer.strokeEnd>=1.0){
        self.shapeLayer.strokeStart += 0.1;
    }
    if (self.shapeLayer.strokeEnd==0) {
        self.shapeLayer.strokeStart = 0;
    }
    //此处同时移动起始和终止点在移动的过程中出现渲染bug。故先移动终止点至一个小于起始点的非法点，就不会画图。再移动起始点。
    if (self.shapeLayer.strokeStart==self.shapeLayer.strokeEnd) {
        self.shapeLayer.strokeEnd = 0;
    }
}



- (void)drawRect:(CGRect)rect {
    
//    BOOL isScreenShot = YES;
//    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(width, width) radius:width-5 startAngle:0 endAngle:2*M_PI clockwise:1];
//    path.lineWidth = 10;
//    if (isScreenShot)
//    {
//        //屏幕截图
//        [[UIColor colorWithPatternImage:[self getImgScreenShot]] setStroke];
//    }
//    else
//    {
//        //画板截图
//        [[UIColor colorWithPatternImage:[self getImgGraphicsDraw]] setStroke];
//    }
//    [path stroke];
}

-(UIImage*)getImgScreenShot
{
    NSArray *colors = @[@[(id)[UIColor redColor].CGColor,(id)[UIColor greenColor].CGColor],
                        @[(id)[UIColor greenColor].CGColor,(id)[UIColor brownColor].CGColor],
                        @[(id)[UIColor brownColor].CGColor,(id)[UIColor blueColor].CGColor],
                        @[(id)[UIColor blueColor].CGColor,(id)[UIColor redColor].CGColor]];
    
    CAGradientLayer *grdLayer0 = [CAGradientLayer layer];
    grdLayer0.frame = CGRectMake(0, 0, width, width);
    grdLayer0.colors = colors[0];
    grdLayer0.startPoint = CGPointMake(0, 1);
    grdLayer0.endPoint = CGPointMake(1, 0);
    [self.layer addSublayer:grdLayer0];
    
    CAGradientLayer *grdLayer1 = [CAGradientLayer layer];
    grdLayer1.frame = CGRectMake(width, 0, width, width);
    grdLayer1.colors = colors[1];
    grdLayer1.startPoint = CGPointMake(0, 0);
    grdLayer1.endPoint = CGPointMake(1, 1);
    [self.layer addSublayer:grdLayer1];
    
    CAGradientLayer *grdLayer2 = [CAGradientLayer layer];
    grdLayer2.frame = CGRectMake(width, width, width, width);
    grdLayer2.colors = colors[2];
    grdLayer2.startPoint = CGPointMake(1, 0);
    grdLayer2.endPoint = CGPointMake(0, 1);
    [self.layer addSublayer:grdLayer2];
    
    CAGradientLayer *grdLayer3 = [CAGradientLayer layer];
    grdLayer3.frame = CGRectMake(0, width, width, width);
    grdLayer3.colors = colors[3];
    grdLayer3.startPoint = CGPointMake(1, 1);
    grdLayer3.endPoint = CGPointMake(0, 0);
    [self.layer addSublayer:grdLayer3];
    
    UIGraphicsBeginImageContext(self.bounds.size);
    [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    [grdLayer0 removeFromSuperlayer];
    [grdLayer1 removeFromSuperlayer];
    [grdLayer2 removeFromSuperlayer];
    [grdLayer3 removeFromSuperlayer];
    
    return img;
}

-(UIImage*)getImgGraphicsDraw
{
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(mWidth, mHeight) , YES, 1);
     CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    //注意ctx的获取若在BeginImageContext之前会在该画布上优先画图，而不是截图。
  
    CGContextSaveGState(ctx);
    
    NSArray *colors = @[@[(id)[UIColor redColor].CGColor,(id)[UIColor greenColor].CGColor],
                        @[(id)[UIColor greenColor].CGColor,(id)[UIColor brownColor].CGColor],
                        @[(id)[UIColor brownColor].CGColor,(id)[UIColor blueColor].CGColor],
                        @[(id)[UIColor blueColor].CGColor,(id)[UIColor redColor].CGColor]];
    
    CGColorSpaceRef colorSpace = CGColorGetColorSpace((CGColorRef)[[colors lastObject] lastObject]);
    CGGradientRef grd0 = CGGradientCreateWithColors(colorSpace, (CFArrayRef)colors[0], NULL);
    CGContextDrawRadialGradient(ctx, grd0, CGPointMake(0, width), width*0.32, point(width, 0), width*0.32, kCGGradientDrawsAfterEndLocation|kCGGradientDrawsBeforeStartLocation);
    
    CGGradientRef grd1 = CGGradientCreateWithColors(colorSpace, (CFArrayRef)colors[1], NULL);
    CGContextDrawRadialGradient(ctx, grd1, CGPointMake(width, 0), width*0.32, point(width*2, width), width*0.32, kCGGradientDrawsBeforeStartLocation|kCGGradientDrawsAfterEndLocation);
    
    CGGradientRef grd2 = CGGradientCreateWithColors(colorSpace, (CFArrayRef)colors[2], NULL);
    CGContextDrawRadialGradient(ctx, grd2, CGPointMake(width*2, width), width*0.32, point(width, width*2), width*0.32, kCGGradientDrawsBeforeStartLocation|kCGGradientDrawsAfterEndLocation);
    
    CGGradientRef grd3 = CGGradientCreateWithColors(colorSpace, (CFArrayRef)colors[3], NULL);
    CGContextDrawRadialGradient(ctx, grd3, CGPointMake(width, width*2), width*0.32, point(0, width), width*0.32, kCGGradientDrawsBeforeStartLocation|kCGGradientDrawsAfterEndLocation);
    
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    CGGradientRelease(grd0);
    CGGradientRelease(grd1);
    CGGradientRelease(grd2);
    CGGradientRelease(grd3);
    CGColorSpaceRelease(colorSpace);
    CGContextRestoreGState(ctx);
    
    return img;
}

@end

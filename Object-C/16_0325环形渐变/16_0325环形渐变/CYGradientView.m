//
//  CYGradientView.m
//  16_0325环形渐变
//
//  Created by ChuckonYin on 16/3/25.
//  Copyright © 2016年 PingAn. All rights reserved.
//

#import "CYGradientView.h"

@implementation CYGradientView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    
    NSArray *colors = @[[UIColor redColor],
                        [UIColor yellowColor]];
    self.layer.allowsEdgeAntialiasing = YES;
    UIImage *img = [CYGradientView drawGradientRadial:colors frame:self.bounds startPoint:CGPointMake(200, 200) endPoint:CGPointMake(200, 200) startRadius:20 endRadius:80];
    
    
    UIImageView *imv = [[UIImageView alloc] initWithFrame:self.bounds];
    imv.image = img;
    [self addSubview:imv];
}

+ (UIImage *)drawGradientRadialLine:(NSArray*)colors Frame:(CGRect)frame startP:(CGPoint)startP endP:(CGPoint)endP ByGradientType:(CYGradientType)gradientType
{
    NSMutableArray *ar = [NSMutableArray array];
    for(UIColor *c in colors) {
        [ar addObject:(id)c.CGColor];
    }
    UIGraphicsBeginImageContextWithOptions(frame.size, YES, 1);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    CGColorSpaceRef colorSpace = CGColorGetColorSpace([[colors lastObject] CGColor]);
    CGGradientRef gradient = CGGradientCreateWithColors(colorSpace, (CFArrayRef)ar, NULL);
    CGContextDrawLinearGradient(context, gradient, startP, endP, kCGGradientDrawsBeforeStartLocation | kCGGradientDrawsAfterEndLocation);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    CGGradientRelease(gradient);
    CGContextRestoreGState(context);
//    CGColorSpaceRelease(colorSpace);
    UIGraphicsEndImageContext();
    return image;
}

+ (UIImage *)drawGradientRadial:(NSArray*)colors frame:(CGRect)frame startPoint:(CGPoint)startP endPoint:(CGPoint)endP startRadius:(CGFloat)startR endRadius:(CGFloat)endR{
    NSMutableArray *ar = [NSMutableArray array];
    for(UIColor *c in colors) {
        [ar addObject:(id)c.CGColor];
    }
    UIGraphicsBeginImageContextWithOptions(frame.size, YES, 1);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    CGColorSpaceRef colorSpace = CGColorGetColorSpace([[colors lastObject] CGColor]);
    CGGradientRef gradient = CGGradientCreateWithColors(colorSpace, (CFArrayRef)ar, NULL);
    CGContextDrawRadialGradient(context, gradient, startP, startR, endP, endR, kCGGradientDrawsBeforeStartLocation | kCGGradientDrawsAfterEndLocation);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    CGGradientRelease(gradient);
    CGContextRestoreGState(context);
//    CGColorSpaceRelease(colorSpace);
    UIGraphicsEndImageContext();
    return image;
}

@end







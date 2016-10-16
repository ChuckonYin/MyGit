//
//  CYAnimationView.m
//  1029 Core Animation-1
//
//  Created by ChuckonYin on 15/10/29.
//  Copyright © 2015年 PingAn. All rights reserved.
//

#import "CYAnimationView.h"
#import <QuartzCore/QuartzCore.h>

@implementation CYAnimationView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}


-(void)drawRect:(CGRect)rect
{
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(0, 0)];
    [path addLineToPoint:CGPointMake(100, 100)];
    [path stroke];
}








@end

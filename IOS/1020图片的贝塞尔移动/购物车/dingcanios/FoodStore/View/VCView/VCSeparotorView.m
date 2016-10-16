//
//  VCSeparotorView.m
//  FoodStore
//
//  Created by liuguopan on 14/12/31.
//  Copyright (c) 2014年 viewcreator3d. All rights reserved.
//

#import "VCSeparotorView.h"

@implementation VCSeparotorView


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    
    self.layer.cornerRadius = 1.0f;
    CGFloat width = rect.size.width;
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    if (self.onlyOneLine) {
        CGContextMoveToPoint(ctx, 0, 28.0f);
        CGContextAddLineToPoint(ctx, width, 28.0f);
    } else {
        CGContextMoveToPoint(ctx, 0, 45.0f);
        CGContextAddLineToPoint(ctx, width, 45.0f);
        
        CGFloat width_4 = width / 4;
        for (int i = 1; i <= 3; i++) {
            CGContextMoveToPoint(ctx, width_4 * i, 50.0f);
            CGContextAddLineToPoint(ctx, width_4 * i, 100.0f);
        }
    }
    
    [[UIColor colorWithRed:0.92f green:0.92f blue:0.92f alpha:1.00f] setStroke];
    CGContextStrokePath(ctx);
}


@end

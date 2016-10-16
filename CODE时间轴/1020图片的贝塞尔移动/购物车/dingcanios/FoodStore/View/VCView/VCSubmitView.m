//
//  VCSubmitView.m
//  FoodStore
//
//  Created by liuguopan on 15/1/5.
//  Copyright (c) 2015年 viewcreator3d. All rights reserved.
//

#import "VCSubmitView.h"

@implementation VCSubmitView

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    
    return;
    self.layer.cornerRadius = 1.0f;
    
    CGFloat width = rect.size.width;
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    if (self.isTop) {
        CGContextMoveToPoint(ctx, 0, 30.0f);
        CGContextAddLineToPoint(ctx, width, 30.0f);
        
        CGContextMoveToPoint(ctx, 0, 30.0f + 30.0f);
        CGContextAddLineToPoint(ctx, width, 30.0f + 30.0f);
        [[UIColor colorWithRed:0.92f green:0.92f blue:0.92f alpha:1.00f] setStroke];
        CGContextStrokePath(ctx);
        
        
        CGContextMoveToPoint(ctx, width - 30.0f, 30.0f + 30.0f + 12.0f);
        CGContextAddLineToPoint(ctx, width - 30.0f + 6.0f, 30.0f + 30.0f + 12.0f + 6.0f);
        CGContextAddLineToPoint(ctx, width - 30.0f + 12.0f, 30.0f + 30.0f + 12.0f);
        [[UIColor colorWithRed:1.00f green:0.23f blue:0.00f alpha:1.00f] setStroke];
        
        CGContextStrokePath(ctx);
    } else {
        CGContextMoveToPoint(ctx, 0, 30.0f);
        CGContextAddLineToPoint(ctx, width, 30.0f);
        
        CGContextMoveToPoint(ctx, 0, 30.0f + 36.0f);
        CGContextAddLineToPoint(ctx, width, 30.0f + 36.0f);
        
        CGContextMoveToPoint(ctx, 0, 30.0f + 36.0f + 36.0f);
        CGContextAddLineToPoint(ctx, width, 30.0f + 36.0f + 36.0f);
        [[UIColor colorWithRed:0.92f green:0.92f blue:0.92f alpha:1.00f] setStroke];
        
        CGContextStrokePath(ctx);
    }
    
}

@end

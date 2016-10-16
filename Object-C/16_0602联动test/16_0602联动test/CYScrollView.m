//
//  CYScrollView.m
//  16_0602联动test
//
//  Created by apple on 16/6/2.
//  Copyright © 2016年 pinAn.com. All rights reserved.
//

#import "CYScrollView.h"

@interface CYScrollView()

@property (nonatomic, assign) CGPoint lastP;

@end

@implementation CYScrollView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self addGestureRecognizer:[[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGestureRecognizer:)]];
    }
    return self;
}

- (void)panGestureRecognizer:(UIPanGestureRecognizer *)pan{
    CGPoint p = [pan locationInView:self.superview];
    NSLog(@"%f", (p.y-_lastP.y));
    self.bounds = CGRectMake(0, self.bounds.origin.y+(-p.y+_lastP.y), self.frame.size.width, self.frame.size.height);
    _lastP = p;
}


@end

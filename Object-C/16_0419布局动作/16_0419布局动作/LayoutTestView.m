//
//  UILayoutView.m
//  16_0419布局动作
//
//  Created by ChuckonYin on 16/4/19.
//  Copyright © 2016年 pinAn.com. All rights reserved.
//

#import "LayoutTestView.h"

@implementation LayoutTestView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self addSubview:[[UIView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)]];
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
     NSLog(@"%s", __func__);
}

- (void)layoutSubviews{
    NSLog(@"%s", __func__);
}



@end

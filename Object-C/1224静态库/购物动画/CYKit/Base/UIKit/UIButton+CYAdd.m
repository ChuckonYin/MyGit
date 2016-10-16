//
//  UIButton+CYAdd.m
//  CYKitDemo
//
//  Created by ChuckonYin on 15/12/3.
//  Copyright © 2015年 PingAn. All rights reserved.
//

#import "UIButton+CYAdd.h"

@implementation UIButton (CYAdd)

- (void)setNornalTitle:(NSString*)title titleColor:(UIColor*)color image:(UIImage*)img target:(id)target sel:(SEL)sel{
    [self setTitle:title forState:UIControlStateNormal];
    [self setTitleColor:color forState:UIControlStateNormal];
    [self setImage:img forState:UIControlStateNormal];
    [self addTarget:target action:sel forControlEvents:UIControlEventTouchUpInside];
}

@end

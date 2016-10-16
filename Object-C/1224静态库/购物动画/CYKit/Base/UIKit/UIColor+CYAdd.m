//
//  UIColor+CYAdd.m
//  CYKitDemo
//
//  Created by ChuckonYin on 15/12/3.
//  Copyright © 2015年 PingAn. All rights reserved.
//

#import "UIColor+CYAdd.h"



@implementation UIColor (CYAdd)

+ (UIColor *)colorWithHex:(NSInteger)hex
{
    return [UIColor colorWithHex:hex
                           alpha:1.0];
}

+ (UIColor *)colorWithHex:(NSInteger)hex alpha:(CGFloat)alpha
{
    return [UIColor colorWithRed:((hex & 0XFF0000) >> 16) / 255.0
                           green:((hex & 0X00FF00) >> 8)  / 255.0
                            blue:(hex & 0X0000FF)         / 255.0
                           alpha:alpha];
}


@end

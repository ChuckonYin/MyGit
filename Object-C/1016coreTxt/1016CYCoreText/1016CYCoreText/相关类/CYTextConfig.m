//
//  CYTextConfig.m
//  1016CYCoreText
//
//  Created by ChuckonYin on 15/10/18.
//  Copyright © 2015年 PingAn. All rights reserved.
//

#import "CYTextConfig.h"

@implementation CYTextConfig


-(instancetype)init
{
    if (self = [super init]) {
        _width = 200;
        _lineSpace = 10;
        _textColor = [UIColor redColor];
        _textFont = 16;
    }
    return self;
}

@end

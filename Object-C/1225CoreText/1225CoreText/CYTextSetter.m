//
//  CYTextSetter.m
//  1225CoreText
//
//  Created by ChuckonYin on 15/12/25.
//  Copyright © 2015年 PingAn. All rights reserved.
//

#import "CYTextSetter.h"

@implementation CYTextSetter

- (instancetype)init
{
    if (self = [super init]) {
        _color = [UIColor redColor];
        _fontSize = 14;
        _width = 300;
        _lineSpace = 5;
    }
    return self;
}


@end

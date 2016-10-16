//
//  CalendarHeader.m
//  16_0421日历
//
//  Created by ChuckonYin on 16/4/24.
//  Copyright © 2016年 pinAn.com. All rights reserved.
//

#import "CalendarHeader.h"

@implementation CalendarHeader

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor brownColor];
    }
    return self;
}

- (instancetype)init{
    if (self = [super init]) {
       self.backgroundColor = [UIColor brownColor];
    }
    return self;
}

@end

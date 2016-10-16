//
//  CalendarCell.m
//  16_0421日历
//
//  Created by ChuckonYin on 16/4/21.
//  Copyright © 2016年 pinAn.com. All rights reserved.
//

#import "CalendarCell.h"

@implementation CalendarCell

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor redColor];
    }
    return self;
}

- (void)setModel:(CalendarModel *)model{
    self.backgroundColor = model.color;
}

@end

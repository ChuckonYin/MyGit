//
//  CYView.m
//  1229控件设计
//
//  Created by ChuckonYin on 15/12/29.
//  Copyright © 2015年 PingAn. All rights reserved.
//

#import "CYView.h"

@implementation CYView
//代码初始化
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    UILabel *l = [[UILabel alloc] init];
    [self addSubview:l];
    return self;
}
//xib  storybord 以xml形式初始化
-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    return self;
}
- (void)layoutSubviews
{
    
}

@end

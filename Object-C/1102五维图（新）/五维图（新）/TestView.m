//
//  TestView.m
//  五维图（新）
//
//  Created by ChuckonYin on 15/11/2.
//  Copyright © 2015年 PingAn. All rights reserved.
//

#import "TestView.h"

@implementation TestView

-(instancetype)init
{
    if (self = [super init]) {
        
    }
    return self;
}
- (void)drawRect:(CGRect)rect {
   
}

-(void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    [self setNeedsDisplay];
}

@end

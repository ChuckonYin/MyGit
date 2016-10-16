//
//  CYPopWindow.m
//  16_0405Window
//
//  Created by ChuckonYin on 16/4/5.
//  Copyright © 2016年 PingAn. All rights reserved.
//

#import "CYPopWindow.h"

@implementation CYPopWindow

+ (id)share{
    static CYPopWindow *sharedObj  = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        sharedObj = [[self alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    });
    return sharedObj;
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.rootViewController = [UIViewController new];
        self.backgroundColor = [UIColor blackColor];
        self.alpha = 0.4;
    }
    return self;
}

- (void)show{
    [self makeKeyAndVisible];
}

- (void)dismiss{
    self.hidden = YES;
    [[[[UIApplication sharedApplication] delegate] window] makeKeyWindow];
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
    return [super hitTest:point withEvent:event];
}

@end

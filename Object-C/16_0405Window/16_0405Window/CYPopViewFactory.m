//
//  CYPopViewFactory.m
//  16_0405Window
//
//  Created by ChuckonYin on 16/4/5.
//  Copyright © 2016年 PingAn. All rights reserved.
//

#import "CYPopViewFactory.h"
#import "CYPopWindow.h"

@implementation CYPopViewFactory

+ (CYPopView *)showPopView{
    CYPopView *popView = [[CYPopView alloc] initWithFrame:CGRectMake(0, [[UIScreen mainScreen] bounds].size.height, [[UIScreen mainScreen] bounds].size.width, 200)];
    CYPopWindow *window = [CYPopWindow share];
    [window show];
    [window addSubview:popView];
    
    [UIView animateWithDuration:0.5 animations:^{
        popView.transform = CGAffineTransformMakeTranslation(0, -CGRectGetHeight(popView.frame));
    }];
    
    return popView;
}

@end

//
//  CYKeyBoardManager.m
//  0104keyboard
//
//  Created by ChuckonYin on 16/1/4.
//  Copyright © 2016年 PingAn. All rights reserved.
//

#import "CYKeyBoardManager.h"

@implementation CYKeyBoardManager

+ (instancetype)share
{
    static CYKeyBoardManager* sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[CYKeyBoardManager alloc] init];
    });
    
    return sharedInstance;
}

- (instancetype)init
{
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getWindow) name:UIKeyboardWillShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getWindow) name:UIKeyboardWillChangeFrameNotification object:nil];
    
    return self;
}

- (void)getWindow
{
    NSArray *appWindows = [UIApplication sharedApplication].windows;
    NSLog(@"%@", appWindows);
//    for (UIWindow *widow in appWindows) {
//        <#statements#>
//    }
    
}


@end

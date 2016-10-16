//
//  AppDelegate.m
//  16_05_12登陆输入框优化
//
//  Created by ChuckonYin on 16/5/12.
//  Copyright © 2016年 pinAn.com. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window.rootViewController = [[UINavigationController alloc] initWithRootViewController:[ViewController new]];
    self.window.backgroundColor = [UIColor whiteColor];
    
    return YES;
}

@end

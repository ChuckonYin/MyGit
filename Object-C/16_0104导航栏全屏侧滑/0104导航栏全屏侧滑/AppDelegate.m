//
//  AppDelegate.m
//  0104导航栏全屏侧滑
//
//  Created by ChuckonYin on 16/1/4.
//  Copyright © 2016年 PingAn. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window.rootViewController = [[UINavigationController alloc] initWithRootViewController:[ViewController new]];
    return YES;
}


@end

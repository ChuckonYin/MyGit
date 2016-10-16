//
//  AppDelegate.m
//  1201界面流畅性优化
//
//  Created by ChuckonYin on 15/12/1.
//  Copyright © 2015年 PingAn. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
   
    UINavigationController *nav = [[UINavigationController alloc] initWithNavigationBarClass:[UINavigationBar class] toolbarClass:[UIToolbar class]];
    [nav pushViewController:[ViewController new] animated:YES];
    self.window.backgroundColor = [UIColor whiteColor];
    
    self.window.rootViewController = nav;
    
    return YES;
}

@end

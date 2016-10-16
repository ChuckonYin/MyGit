//
//  AppDelegate.m
//  1024ARC循环引用
//
//  Created by ChuckonYin on 15/10/24.
//  Copyright © 2015年 PingAn. All rights reserved.
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


- (void)applicationDidEnterBackground:(UIApplication *)application
{
//    NSLog(@"进入后台");
//    
//    [[UIApplication sharedApplication] beginBackgroundTaskWithExpirationHandler:^{
//         NSLog(@"关闭后台");
//        esleep(3);
//    }];
}





@end












//
//  AppDelegate.m
//  1029 Core Animation-1
//
//  Created by ChuckonYin on 15/10/29.
//  Copyright © 2015年 PingAn. All rights reserved.
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

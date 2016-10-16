//
//  AppDelegate.m
//  2016_0224YZTRefresh
//
//  Created by ChuckonYin on 16/2/24.
//  Copyright © 2016年 PingAn. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window.rootViewController = [[UINavigationController alloc] initWithRootViewController:[[ViewController alloc] init]];
    
    return YES;
}

@end

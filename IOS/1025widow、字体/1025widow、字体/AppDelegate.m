//
//  AppDelegate.m
//  1025widow、字体
//
//  Created by ChuckonYin on 15/10/25.
//  Copyright © 2015年 PingAn. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window.rootViewController = [[ViewController alloc] init];
    
    [_window makeKeyAndVisible];
    
    return YES;
}

@end

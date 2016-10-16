//
//  AppDelegate.m
//  16_0601tableview tree
//
//  Created by apple on 16/6/1.
//  Copyright © 2016年 pinAn.com. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window.rootViewController = [[UINavigationController alloc] initWithRootViewController:[[UIViewController alloc] init]];
    
    return YES;
}

@end

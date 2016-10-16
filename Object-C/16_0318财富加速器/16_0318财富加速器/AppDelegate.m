//
//  AppDelegate.m
//  16_0318财富加速器
//
//  Created by ChuckonYin on 16/3/18.
//  Copyright © 2016年 PingAn. All rights reserved.
//

#import "AppDelegate.h"
#import "InvestPreferenceViewController2.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window.rootViewController = [[UINavigationController alloc] initWithRootViewController:[[InvestPreferenceViewController2 alloc] init]];
    self.window.backgroundColor = [UIColor whiteColor];
    return YES;
}
@end

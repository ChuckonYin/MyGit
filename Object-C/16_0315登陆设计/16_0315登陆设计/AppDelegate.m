//
//  AppDelegate.m
//  16_0315登陆设计
//
//  Created by ChuckonYin on 16/3/15.
//  Copyright © 2016年 PingAn. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import "BaseViewController.h"

@interface AppDelegate ()

@property (nonatomic, strong) UITabBarController *tabCtrl;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginSucess) name:kLoginSuccessNotification object:nil];
    
    [self initTabBarViewController];
   
    return YES;
}

- (void)loginSucess{
    NSLog(@"收到登陆成功通知");
    [self initTabBarViewController];
}

- (void)initTabBarViewController{
    self.tabCtrl = [[UITabBarController alloc] init];
    self.window.rootViewController = self.tabCtrl;
    
    NSArray <UINavigationController*> *array = @[[[UINavigationController alloc] initWithRootViewController:[ViewController new]],
                                                 [[UINavigationController alloc] initWithRootViewController:[ViewController new]],
                                                 [[UINavigationController alloc] initWithRootViewController:[ViewController new]],
                                                 [[UINavigationController alloc] initWithRootViewController:[ViewController new]]];
    self.tabCtrl.viewControllers = array;
    
    array[0].viewControllers[0].title = @"财富";
    array[1].viewControllers[0].title = @"金融";
    array[2].viewControllers[0].title = @"旗舰店";
    array[3].viewControllers[0].title = @"广告";
    
    array[0].viewControllers[0].tabBarItem.title = @"财富";
    array[1].viewControllers[0].tabBarItem.title = @"金融";
    array[2].viewControllers[0].tabBarItem.title = @"旗舰店";
    array[3].viewControllers[0].tabBarItem.title = @"广告";
}



@end

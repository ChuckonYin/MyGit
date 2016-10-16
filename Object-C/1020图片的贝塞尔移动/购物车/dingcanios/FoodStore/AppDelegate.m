//
//  AppDelegate.m
//  FoodStore
//
//  Created by liuguopan on 14-12-8.
//  Copyright (c) 2014年 viewcreator3d. All rights reserved.
//

#import "AppDelegate.h"
#import "Public.h"

#import "LeftMenuViewController.h"

//#import "UserCenterViewController.h"
//#import "OrderFoodViewController.h"
//#import "MyOrdersViewController.h"
//#import "MyFavoritesViewController.h"
//#import "SettingViewController.h"

//#import "BaseViewController.h"
//#import "BaseTabbarController.h"

//#import "MMDrawerController.h"

#import "JSONKit.h"
#import <AudioToolbox/AudioToolbox.h>

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    
    [Public sharedPublic];  //  实例化公共类
    
    LeftMenuViewController *left = [LeftMenuViewController shared];
    IIViewDeckController *vc = [[IIViewDeckController alloc] initWithCenterViewController:left.navArr[1] leftViewController:left];
    vc.centerhiddenInteractivity = IIViewDeckCenterHiddenNotUserInteractiveWithTapToClose;
    vc.leftSize = 60;
    self.window.rootViewController = vc;
    
    if (IOS_VERSION >= 7.0) {   //  iOS7或iOS7以上版本
        
    } else {                    //  iOS7以下版本
        
    }
    
    [application setStatusBarStyle:UIStatusBarStyleLightContent];
    
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];

    //push
    [BPush setupChannel:launchOptions];
    [BPush setDelegate:self];
    [BPush bindChannel];
    
    if (IOS_VERSION >= 8.0) {
//        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes: (UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeSound) categories:nil];
//        [application registerUserNotificationSettings:settings];
//        [application registerForRemoteNotifications];
        
    } else {
        [application registerForRemoteNotificationTypes:
         UIRemoteNotificationTypeBadge |
         UIRemoteNotificationTypeAlert |
         UIRemoteNotificationTypeSound];
    }

    return YES;
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    [BPush registerDeviceToken: deviceToken];
}
- (void)onMethod:(NSString*)method response:(NSDictionary*)data
{
    NSLog(@"data:%@", [data description]);
    if ([BPushRequestMethod_Bind isEqualToString:method]) {
        if (![data[@"error_code"] intValue]) {
//            
        }
        
    }
}
- (void)application:(UIApplication*)application didFailToRegisterForRemoteNotificationsWithError:(NSError*)error
{
    
//    LOG_NAME(@"Failed to get token, error:", error);
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    
//    code
    NSLog(@"userInfo: %@", [userInfo JSONString]);
    
    
    AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
    AudioServicesPlaySystemSound(1007);
    
    
    
    
    [BPush handleNotification:userInfo]; // 可选
    
    
    
}
 
//- (BaseTabbarController *)getTabbarController
//{
//    //  个人中心
//    UserCenterViewController *userCenterVC = [[UserCenterViewController alloc] init];
//    BaseNavigationController *userCenterNav = [[BaseNavigationController alloc] initWithRootViewController:userCenterVC];
//    //  我要订餐
//    OrderFoodViewController *orderFoodVC = [[OrderFoodViewController alloc] init];
//    BaseNavigationController *orderFoodNav = [[BaseNavigationController alloc] initWithRootViewController:orderFoodVC];
//    //  我的订餐
//    MyOrdersViewController *myOrdersVC = [[MyOrdersViewController alloc] init];
//    BaseNavigationController *myOrdersNav = [[BaseNavigationController alloc] initWithRootViewController:myOrdersVC];
//    //  我的收藏
//    MyFavoritesViewController *myFavoritesVC = [[MyFavoritesViewController alloc] init];
//    BaseNavigationController *myFavoritesNav = [[BaseNavigationController alloc] initWithRootViewController:myFavoritesVC];
//    //  用户设置
//    SettingViewController *settingVC = [[SettingViewController alloc] init];
//    BaseNavigationController *settingNav = [[BaseNavigationController alloc] initWithRootViewController:settingVC];
//    
//    BaseTabbarController *tabbarController = [[BaseTabbarController alloc] init];
//    NSArray *viewControllers = [[NSArray alloc] initWithObjects:userCenterNav,
//                                                                orderFoodNav,
//                                                                myOrdersNav,
//                                                                myFavoritesNav,
//                                                                settingNav,
//                                                                nil];
//    tabbarController.viewControllers = viewControllers;
//    tabbarController.tabBar.hidden = YES;
//    
//    return tabbarController;
//}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end

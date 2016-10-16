//
//  AppDelegate.m
//  1129remoteNotification
//
//  Created by ChuckonYin on 15/11/29.
//  Copyright © 2015年 PingAn. All rights reserved.

/*

 */

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [[UIApplication sharedApplication] registerForRemoteNotificationTypes:
     (UIRemoteNotificationTypeAlert|
      UIRemoteNotificationTypeBadge|
      UIRemoteNotificationTypeSound)];
    
    ///应用程序不处在后台，并且是通过推送打开应用的时候
    if (launchOptions) {
        ///获取到推送相关的信息
        NSDictionary *userInfo = [launchOptions objectForKey:UIApplicationLaunchOptionsRemoteNotificationKey];
    }
    
    return YES;
}

///Token值成功获取的时候走的是这个方法（Token值不能带空格）
-(void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    
    NSLog(@"%@",deviceToken);
    
}

///Token值获取失败的时候走的是这个方法
-(void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error
{
    NSLog(@"%@",error);
}

///应用程序处在打开状态，且服务器有推送消息过来时，以及通过推送打开应用程序，走的是这个方法
-(void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    for (id key in userInfo) {
        NSLog(@"%@:%@",key, [userInfo objectForKey:key]);
    }
    ///Icon推送数量设为0
    //    application.applicationIconBadgeNumber=0;
}



@end








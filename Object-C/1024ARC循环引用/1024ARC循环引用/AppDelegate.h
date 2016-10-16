//
//  AppDelegate.h
//  1024ARC循环引用
//
//  Created by ChuckonYin on 15/10/24.
//  Copyright © 2015年 PingAn. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (nonatomic, assign) UIBackgroundTaskIdentifier backgroundTaskID;

@end


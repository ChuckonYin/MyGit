//
//  ViewController.m
//  1127网络高级编程
//
//  Created by ChuckonYin on 15/11/27.
//  Copyright © 2015年 PingAn. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    /**
     *  本地通知
     */
    UILocalNotification *localNoti = [[UILocalNotification alloc] init];
    
    localNoti.alertBody      = @"fsdf";
    localNoti.alertTitle     = @"rftguybhinjkm";
    localNoti.repeatCalendar = [NSCalendar currentCalendar];
    localNoti.repeatInterval = NSCalendarUnitDay;
    localNoti.timeZone = [NSTimeZone defaultTimeZone];
    localNoti.hasAction = YES;
    
    [localNoti setFireDate:[NSDate date]];
    
    [[UIApplication sharedApplication] scheduleLocalNotification:localNoti];
    
    [[UIApplication sharedApplication] presentLocalNotificationNow:localNoti];
    
    
    
}



@end

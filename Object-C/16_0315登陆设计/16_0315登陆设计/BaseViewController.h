//
//  BaseViewController.h
//  16_0315登陆设计
//
//  Created by ChuckonYin on 16/3/15.
//  Copyright © 2016年 PingAn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

#define kScreenWidth [[UIScreen mainScreen] bounds].size.width
#define kScreenheight [[UIScreen mainScreen] bounds].size.height

extern NSString * const kLoginSuccessNotification;

#define arc4RandomColor [UIColor colorWithRed:((CGFloat)(arc4random()%10))/10.0 green:((CGFloat)(arc4random()%10))/10.0 blue:((CGFloat)(arc4random()%10))/10.0 alpha:1];

@interface BaseViewController : UIViewController

- (void)leftBarItemAction;

- (void)rightBarItemAction;

@end

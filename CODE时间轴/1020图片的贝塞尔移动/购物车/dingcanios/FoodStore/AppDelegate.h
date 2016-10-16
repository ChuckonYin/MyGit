//
//  AppDelegate.h
//  FoodStore
//
//  Created by liuguopan on 14-12-8.
//  Copyright (c) 2014年 viewcreator3d. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IIViewDeckController.h"
#import "BPush.h"

@class BaseTabbarController;
@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) BaseTabbarController *menuTabbarController;

@end

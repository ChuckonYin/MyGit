//
//  BaseViewController.h
//  FoodStore
//
//  Created by liuguopan on 14-12-8.
//  Copyright (c) 2014年 viewcreator3d. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseNavigationController.h"
#import "GCDServer.h"
#import "kInterfaceURL.h"
#import "Public.h"
#import "SVProgressHUD.h"
#import "JSON.h"
#import "UIImageView+WebCache.h"

@interface BaseViewController : UIViewController

- (void)setBarTintColor:(UIColor *)color;

- (void)setSliderItem;
- (void)sliderAbled:(BOOL)yesOrNo;

- (void)setBackItem:(SEL)sel;
- (void)backPop;
- (void)backDismiss;

- (void)resetTitleView:(NSString *)title;
- (void)setTitleButton:(NSString *)title
                   sel:(SEL)sel;

- (void)setRightSearchItem:(SEL)sel;

- (void)setLeftItem:(NSString *)title
                sel:(SEL)sel;
- (void)setRightItem:(NSString *)title
                 sel:(SEL)sel;


- (void)bPushBind:(BOOL)yesOrNo;


@end

//
//  LeftMenuViewController.h
//  FoodStore
//
//  Created by liuguopan on 14/12/19.
//  Copyright (c) 2014年 viewcreator3d. All rights reserved.
//

/// 菜单栏

#import "BaseViewController.h"

@interface LeftMenuViewController : BaseViewController
@property (nonatomic,strong) NSArray * navArr;
+ (LeftMenuViewController *)shared;
@end

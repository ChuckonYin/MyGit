//
//  LocationViewController.h
//  FoodStore
//
//  Created by liuguopan on 14/12/25.
//  Copyright (c) 2014年 viewcreator3d. All rights reserved.
//

/// 定位

#import "BaseViewController.h"

@protocol LocationVCDelegate <NSObject>

- (void)changeLocation:(NSString *)title;

@end


@interface LocationViewController : BaseViewController

@property (nonatomic,weak) __weak id<LocationVCDelegate> delegate;

@end

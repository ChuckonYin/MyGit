//
//  CartViewController.h
//  FoodStore
//
//  Created by liuguopan on 14/12/25.
//  Copyright (c) 2014年 viewcreator3d. All rights reserved.
//

/// 购物车

#import "BaseViewController.h"
//#import "Model.h"

//@class CartViewController;
@protocol CartViewControllerDelegate <NSObject>

- (void)reloadView;

@end

@interface CartViewController : BaseViewController
@property (nonatomic,assign)BOOL isTiao;
@property (nonatomic, strong) CartInfo *cartInfo;
//@property (nonatomic, weak) __weak id <CartViewControllerDelegate> cartDelegate;

@end

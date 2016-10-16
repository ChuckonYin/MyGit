//
//  AddAddressViewController.h
//  FoodStore
//
//  Created by liuguopan on 14/12/25.
//  Copyright (c) 2014年 viewcreator3d. All rights reserved.
//

/// 新增地址

#import "BaseViewController.h"

@protocol AddAddressDelegate <NSObject>

- (void)addAddressWithName:(NSString *)name
                   address:(NSString *)address
                       tel:(NSString *)tel;

@end


@interface AddAddressViewController : BaseViewController

@property (nonatomic,weak) __weak id<AddAddressDelegate> delegate;

- (void)dataWithInfo:(AddressInfo *)info;

@end

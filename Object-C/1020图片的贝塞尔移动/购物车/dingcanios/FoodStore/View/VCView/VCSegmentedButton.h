//
//  VCSegmentedButton.h
//  FoodStore
//
//  Created by liuguopan on 14/12/29.
//  Copyright (c) 2014年 viewcreator3d. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VCSegmentedButton : UIControl

/**
 *  @brief      当前选中的是哪个Button
 *  @return     当两次选的为同一个Button，返回-1，否则返回0，1，2
 */
@property (nonatomic, assign) NSInteger currentSelectedIndex;

- (void)setTitle:(NSString *)title index:(NSInteger)index;
- (void)cancelSelect;

@end

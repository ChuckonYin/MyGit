//
//  VCFixLabel.h
//  FoodStore
//
//  Created by liuguopan on 14/12/30.
//  Copyright (c) 2014年 viewcreator3d. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VCFixLabel : UILabel

/**
 *  前缀
 */
@property (nonatomic, strong) NSString *prefix;

/**
 *  后缀
 */
@property (nonatomic, strong) NSString *suffix;

/**
 *  不包含前缀和后缀的字符串
 */
@property (nonatomic, strong, readonly) NSString *nativeText;

@end

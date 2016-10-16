//
//  UIImageGradientUtils.h
//  SoSoCard
//
//  Created by pan.zaofeng on 15/4/8.
//  Copyright (c) 2015年 songwentao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface UIImageGradientUtils : NSObject
typedef enum  {
    Gradient_topToBottom = 0,//从上到小
    Gradient_leftToRight = 1,//从左到右
    Gradient_upleftTolowRight = 2,//左上到右下
    Gradient_uprightTolowLeft = 3,//右上到左下
}GradientType;

+ (UIImage*) buttonImageFromColors:(NSArray*)colors Frame:(CGRect)frame ByGradientType:(GradientType)gradientType;

@end

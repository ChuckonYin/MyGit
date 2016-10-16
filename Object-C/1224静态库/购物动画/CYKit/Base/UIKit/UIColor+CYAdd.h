//
//  UIColor+CYAdd.h
//  CYKitDemo
//
//  Created by ChuckonYin on 15/12/3.
//  Copyright © 2015年 PingAn. All rights reserved.
//

#import <UIKit/UIKit.h>

#define UIColor_Hex(hex) [UIColor colorWithHex:hex]

#define UIBlackColor [UIColor blackColor]  // 0.0 white
#define UIDarkGrayColor   [UIColor darkGrayColor]   // 0.667 white
#define UILightGrayColor  [UIColor lightGrayColor]  // 0.333 white
#define UIWhiteColor      [UIColor whiteColor]      // 1.0 white
#define UIGrayColor       [UIColor grayColor] // 0.5 white
#define UIRedColor        [UIColor redColor]  // 1.0, 0.0, 0.0 RGB
#define UIGreenColor      [UIColor greenColor]   // 0.0, 1.0, 0.0 RGB
#define UIBlueColor       [UIColor blueColor]    // 0.0, 0.0, 1.0 RGB
#define UICyanColor       [UIColor cyanColor]   // 0.0, 1.0, 1.0 RGB
#define UIYellowColor     [UIColor yellowColor]  // 1.0, 1.0, 0.0 RGB
#define UIMagentaColor    [UIColor magentaColor]   // 1.0, 0.0, 1.0 RGB
#define UIOrangeColor     [UIColor orangeColor]  // 1.0, 0.5, 0.0 RGB
#define UIPurpleColor     [UIColor purpleColor]  // 0.5, 0.0, 0.5 RGB
#define UIBrownColor      [UIColor brownColor]  // 0.6, 0.4, 0.2 RGB
#define UIClearColor      [UIColor clearColor]   // 0.0 white, 0.0 alpha

@interface UIColor (CYAdd)

+ (UIColor *)colorWithHex:(NSInteger)hex;

+ (UIColor *)colorWithHex:(NSInteger)hex alpha:(CGFloat)alpha;

@end

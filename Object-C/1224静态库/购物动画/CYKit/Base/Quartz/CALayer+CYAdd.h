//
//  CALayer+ImageShot.h
//  CYKitDemo
//
//  Created by ChuckonYin on 15/12/1.
//  Copyright © 2015年 PingAn. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import <UIKit/UIKit.h>

@interface CALayer (CYAdd)

//it's only a identifier like tag
@property (nonatomic, copy) NSString *identifier;

//clip an image from a layer
- (UIImage*)imageShotAllLayer;


@end

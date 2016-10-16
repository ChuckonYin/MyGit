//
//  CALayer+ImageShot.m
//  CYKitDemo
//
//  Created by ChuckonYin on 15/12/1.
//  Copyright © 2015年 PingAn. All rights reserved.
//

#import "CALayer+CYAdd.h"
#import <objc/runtime.h>

@implementation CALayer (CYAdd)

-(NSString *)identifier{
    return objc_getAssociatedObject(self, @selector(identifier));
}
-(void)setIdentifier:(NSString *)identifier{
    objc_setAssociatedObject(self, @selector(identifier), identifier, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (UIImage *)imageShotAllLayer{
    
    UIGraphicsBeginImageContextWithOptions(self.bounds.size, self.opaque, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    [self renderInContext:context];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

@end

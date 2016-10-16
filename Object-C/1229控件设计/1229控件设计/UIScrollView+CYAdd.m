//
//  UIScrollView+CYAdd.m
//  CYKitDemo
//
//  Created by ChuckonYin on 15/12/3.
//  Copyright © 2015年 PingAn. All rights reserved.
//

#import "UIScrollView+CYAdd.h"
#import <objc/runtime.h>

@implementation UIScrollView (CYAdd)


#pragma mark - response chain

-(BOOL)touchPassing
{
    return [objc_getAssociatedObject(self, "touchPassing") boolValue];
}
- (void)setTouchPassing:(BOOL)touchPassing
{
//    [self setAssociateValue:@(touchPassing) withKey:@selector(touchPassing)];
    objc_setAssociatedObject(self, "touchPassing", @(touchPassing), OBJC_ASSOCIATION_ASSIGN);
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
      NSLog(@"%i",self.touchPassing);
    if (self.touchPassing) {
        [super touchesBegan:touches withEvent:event];
        [self.nextResponder touchesBegan:touches withEvent:event];
    }
}
- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
      NSLog(@"%i",self.touchPassing);
    if (self.touchPassing) {
        [super touchesEnded:touches withEvent:event];
        [self.nextResponder touchesEnded:touches withEvent:event];
    }
}
-(void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    if (self.touchPassing) {
        [super touchesCancelled:touches withEvent:event];
        [self.nextResponder touchesCancelled:touches withEvent:event];
    }
}
-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    if (self.touchPassing) {
        [self touchesMoved:touches withEvent:event];
        [self.nextResponder touchesMoved:touches withEvent:event];
    }
}






@end

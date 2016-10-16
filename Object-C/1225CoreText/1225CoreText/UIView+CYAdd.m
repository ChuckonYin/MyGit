//
//  UIView+CYAdd.m
//  CYKitDemo
//
//  Created by ChuckonYin on 15/12/2.
//  Copyright © 2015年 PingAn. All rights reserved.
//

#import "UIView+CYAdd.h"
#import <objc/runtime.h>

@implementation UIView (CYAdd)

-(NSString *)identifier{
    return objc_getAssociatedObject(self, @selector(identifier));
}
-(void)setViewIdentifer:(NSString *)identifier{
    objc_setAssociatedObject(self, @selector(identifier), identifier, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

#pragma easyMethod

-(void)setPFrame:(CGRect)pFrame
{
    self.frame = CGRectMake(pFrame.origin.x/100*kScreenWidth, pFrame.origin.y/100*kScreenHeight, pFrame.size.width/100*kScreenWidth, pFrame.size.height/100*kScreenHeight);
}
-(CGRect)pFrame
{
    return CGRectMake(self.x/100*kScreenWidth, self.y/100*kScreenHeight, self.width/100*kScreenWidth, self.height/100*kScreenHeight);
}
- (void)removeAllSubviews
{
//    self.layer.clipCornerRadius
    while (self.subviews.count) {
        [self.subviews.lastObject removeFromSuperview];
    }
}
- (void)removeAllSubviewsWithoutTag:(NSInteger)tag{
    while (self.subviews.count) {
        if (self.subviews.lastObject.tag != tag) {
            [self.subviews.lastObject removeFromSuperview];
        }
    }
}
- (void)removeAllSubviewsWithoutIdentifier:(NSString*)identifier{
    while (self.subviews.count) {
        if (![self.subviews.lastObject.identifier isEqualToString:identifier]) {
            [self.subviews.lastObject removeFromSuperview];
        }
    }
}
-(void)setImage:(UIImage *)image
{
    self.layer.contents = (id)(image.CGImage);
}
-(UIImage *)image{
    UIImage *img = [UIImage imageWithCGImage:(__bridge CGImageRef _Nonnull)(self.layer.contents)];
    if (img && [img isKindOfClass:[UIImage class]]) {
        return img;
    }
    return nil;
}
-(CGFloat)clipCornerRadius{
    return self.layer.cornerRadius;
}
-(void)setClipCornerRadius:(CGFloat)clipCornerRadius
{
    self.clipsToBounds = YES;
    self.layer.cornerRadius = clipCornerRadius;
}


#pragma mark - layout
- (CGFloat)x {
    return self.frame.origin.x;
}
- (void)setX:(CGFloat)x {
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}
- (CGFloat)y {
    return self.frame.origin.y;
}
- (void)setY:(CGFloat)y {
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}
- (CGFloat)right {
    return self.frame.origin.x + self.frame.size.width;
}
- (void)setRight:(CGFloat)right {
    CGRect frame = self.frame;
    frame.origin.x = right - frame.size.width;
    self.frame = frame;
}
- (CGFloat)bottom {
    return self.frame.origin.y + self.frame.size.height;
}
- (void)setBottom:(CGFloat)bottom {
    CGRect frame = self.frame;
    frame.origin.y = bottom - frame.size.height;
    self.frame = frame;
}
- (CGFloat)width {
    return self.frame.size.width;
}
- (void)setWidth:(CGFloat)width {
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}
- (CGFloat)height {
    return self.frame.size.height;
}
- (void)setHeight:(CGFloat)height {
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}
- (CGFloat)centerX {
    return self.center.x;
}
- (void)setCenterX:(CGFloat)centerX {
    self.center = CGPointMake(centerX, self.center.y);
}
- (CGFloat)centerY {
    return self.center.y;
}
- (void)setCenterY:(CGFloat)centerY {
    self.center = CGPointMake(self.center.x, centerY);
}
- (CGPoint)origin {
    return self.frame.origin;
}
- (void)setOrigin:(CGPoint)origin {
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
}
- (CGSize)size {
    return self.frame.size;
}
- (void)setSize:(CGSize)size {
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}


@end

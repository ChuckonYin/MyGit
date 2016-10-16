//
//  UILabel+CYAdd.m
//  CYKitDemo
//
//  Created by ChuckonYin on 15/12/3.
//  Copyright © 2015年 PingAn. All rights reserved.
//

#import "UILabel+CYAdd.h"
#import <objc/runtime.h>

@implementation UILabel (CYAdd)

- (UILabel* (^)(CGRect))frame_
{
    if (!objc_getAssociatedObject(self, @selector(frame_))) {
        objc_setAssociatedObject(self, @selector(frame_), (UILabel*)^(CGRect frame){
            self.frame = frame;
            return self;
        }, OBJC_ASSOCIATION_COPY_NONATOMIC);
    }
    return objc_getAssociatedObject(self, @selector(frame_));
}

-(UILabel *(^)(NSString *))text_
{
//    if (!objc_getAssociatedObject(self, @selector(text_))) {
//        objc_setAssociatedObject(self, @selector(text_), (UILabel*)^(NSString *text){
//            self.text = text;
//            return self;
//        }, OBJC_ASSOCIATION_COPY_NONATOMIC);
//    }
//    return objc_getAssociatedObject(self, @selector(text_));
    
    id c = (UILabel*)^(NSString *text){
        self.text = text;
        return self;
    };
    return c;
}

-(UILabel *(^)(UIFont *))font_
{
    if (!objc_getAssociatedObject(self, @selector(font_))) {
        objc_setAssociatedObject(self, @selector(font_), (UILabel*)^(UIFont *font){
            self.font = font;
            return self;
        }, OBJC_ASSOCIATION_COPY_NONATOMIC);
    }
    return objc_getAssociatedObject(self, @selector(font_));
}

- (UILabel *(^)(UIColor *))bgColor_
{
    if (!objc_getAssociatedObject(self, @selector(bgColor_))) {
        objc_setAssociatedObject(self, @selector(bgColor_), (UILabel*)^(UIColor *color){
            self.backgroundColor = color;
            return self;
        }, OBJC_ASSOCIATION_COPY_NONATOMIC);
    }
    return objc_getAssociatedObject(self, @selector(bgColor_));
}
-(UILabel *(^)(UIColor *))textColor_
{
    if (!objc_getAssociatedObject(self, @selector(textColor_))) {
        objc_setAssociatedObject(self, @selector(textColor_), (UILabel*)^(UIColor *color){
            self.textColor = color;
            return self;
        }, OBJC_ASSOCIATION_COPY_NONATOMIC);
    }
    return objc_getAssociatedObject(self, @selector(textColor_));
}
-(UILabel *(^)(NSTextAlignment))textAlig_
{
    if (!objc_getAssociatedObject(self, @selector(textAlig_))) {
        objc_setAssociatedObject(self, @selector(textAlig_), (UILabel*)^(NSTextAlignment alig){
            self.textAlignment = alig;
            return self;
        }, OBJC_ASSOCIATION_COPY_NONATOMIC);
    }
    return objc_getAssociatedObject(self, @selector(textAlig_));
}


-(void)setText:(id)text textColor:(UIColor *)textColor fontSize:(CGFloat)size textAlig:(NSTextAlignment)alig bgColor:(UIColor *)bgColor
{
    if (text && [text isKindOfClass:[NSString class]]) {
        self.text = text;
    }
    else if (text && [text isKindOfClass:[NSAttributedString class]]){
        self.attributedText = text;
    }
    self.textColor_(textColor).font_(chineseFont(size)).textAlig_(alig).bgColor_(bgColor);
}




@end











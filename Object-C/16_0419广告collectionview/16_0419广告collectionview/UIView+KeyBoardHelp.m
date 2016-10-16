//
//  UIView+KeyBoardHelp.m
//  16_0419广告collectionview
//
//  Created by ChuckonYin on 16/4/20.
//  Copyright © 2016年 pinAn.com. All rights reserved.
//

#import "UIView+KeyBoardHelp.h"
#import <objc/runtime.h>

@interface UIView()

@property (nonatomic, weak) id cy_firstResponser;

@end

@implementation UIView (KeyBoardHelp)

- (void)setAutoMovingRelyOnKeyBoard:(BOOL)autoMovingRelyOnKeyBoard{
    if (autoMovingRelyOnKeyBoard==YES) {
        [self initSetting];
    }
    objc_setAssociatedObject(self, @selector(autoMovingRelyOnKeyBoard), @(autoMovingRelyOnKeyBoard), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)autoMovingRelyOnKeyBoard{
    return objc_getAssociatedObject(self, @selector(autoMovingRelyOnKeyBoard));
}

- (void)setCy_firstResponser:(id)cy_firstResponser{
    objc_setAssociatedObject(self, @selector(cy_firstResponser), cy_firstResponser, OBJC_ASSOCIATION_ASSIGN);
}

- (id)cy_firstResponser{
    return objc_getAssociatedObject(self, @selector(cy_firstResponser));
}

- (void)setAutoPopFromScreenBottomRelyOnKeyBoard:(BOOL)autoPopFromScreenBottomRelyOnKeyBoard{
    if (autoPopFromScreenBottomRelyOnKeyBoard == YES) {
        [self setAutoMovingRelyOnKeyBoard:YES];
    }
    objc_setAssociatedObject(self, @selector(autoPopFromScreenBottomRelyOnKeyBoard), @(autoPopFromScreenBottomRelyOnKeyBoard), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)autoPopFromScreenBottomRelyOnKeyBoard{
    return [objc_getAssociatedObject(self, @selector(autoPopFromScreenBottomRelyOnKeyBoard)) integerValue];
}

- (void)findFirstResponser:(UIView *)view{
    for (UIView *v in view.subviews) {
        if ([v isKindOfClass:[UITextField class]] || [v isKindOfClass:[UITextView class]]) {
            self.cy_firstResponser = v;
        }
        else{
            [self findFirstResponser:v];
        }
    }
}

- (void)initSetting{
    //查找输入框
    if ([self isKindOfClass:[UITextField class]] || [self isKindOfClass:[UITextView class]]) {
        self.cy_firstResponser = self;
    }
    else{
        [self findFirstResponser:self];
    }
    //配置通知
    if (self.cy_firstResponser) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(cy_willChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
    }
}

- (void)cy_willChangeFrame:(NSNotification *)noti{
    if (!self.cy_firstResponser || ![self.cy_firstResponser isFirstResponder]) return;
    NSLog(@"cy_willChangeFrame====%@", noti.userInfo);
    NSInteger animationCurve = [noti.userInfo[UIKeyboardAnimationCurveUserInfoKey] integerValue];
    NSTimeInterval interval = [noti.userInfo[UIKeyboardAnimationDurationUserInfoKey] floatValue];
    CGRect rect = [noti.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat translation = 0;
    if (rect.origin.y>=[[UIScreen mainScreen] bounds].size.height) {
        //键盘超出屏幕外，收回
        translation = 0;
    }
    else{
        //键盘在屏幕上，调整偏移量
        translation = -rect.size.height;
        if (self.autoPopFromScreenBottomRelyOnKeyBoard) {
            translation = -rect.size.height - self.frame.size.height;
        }
    }
    [UIView animateWithDuration:interval delay:0 options:animationCurve animations:^{
        self.transform = CGAffineTransformMakeTranslation(0, translation);
    } completion:^(BOOL finished) {
        
    }];
}

//- (void)setAutoPopFromScreenBottomRelyOnKeyBoard:(BOOL)autoPopFromScreenBottomRelyOnKeyBoard{
//    self.autoPopFromScreenBottomRelyOnKeyBoard = autoPopFromScreenBottomRelyOnKeyBoard;
//  
//}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

//UIKeyboardAnimationCurveUserInfoKey = 7;
//UIKeyboardAnimationDurationUserInfoKey = "0.25";
//UIKeyboardBoundsUserInfoKey = "NSRect: {{0, 0}, {414, 271}}";
//UIKeyboardCenterBeginUserInfoKey = "NSPoint: {207, 871.5}";
//UIKeyboardCenterEndUserInfoKey = "NSPoint: {207, 600.5}";
//UIKeyboardFrameBeginUserInfoKey = "NSRect: {{0, 736}, {414, 271}}";
//UIKeyboardFrameEndUserInfoKey = "NSRect: {{0, 465}, {414, 271}}";
//UIKeyboardIsLocalUserInfoKey = 1;

@end

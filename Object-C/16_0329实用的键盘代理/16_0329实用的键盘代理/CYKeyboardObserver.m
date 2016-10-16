//
//  CYKeyboardObserver.m
//  16_0329实用的键盘代理
//
//  Created by ChuckonYin on 16/3/29.
//  Copyright © 2016年 PingAn. All rights reserved.
//

#import "CYKeyboardObserver.h"

@interface CYKeyboardObserver()

@property (nonatomic, strong) UIView *header;

@property (nonatomic, assign) CGFloat keyboardHeight;

@property (nonatomic, assign) CGFloat keyboardDuration;

@property (nonatomic, assign) NSInteger keyboardCurve;

@property (nonatomic, assign) BOOL autoAdjust;

@property (nonatomic, weak) UIView *textField;

@end

@implementation CYKeyboardObserver

- (instancetype)init{
    if (self = [super init]){
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidHide) name:UIKeyboardDidHideNotification object:nil];
    }
    return self;
}


- (void)setObserveredView:(UIView *)textField andKeybordHeader:(UIView *)header delegate:(id<CYKeyboardObserverDelegate>)delegate autoAdjust:(BOOL)autoAdjust{
    self.header = header;
    _autoAdjust = autoAdjust;
    _delegate = delegate;
    _textField = textField;
    if (_autoAdjust) {
        header.frame = CGRectMake(0, [[UIScreen mainScreen] bounds].size.height, [[UIScreen mainScreen] bounds].size.width, header.frame.size.height);
    }
}


- (void)keyboardWillShow:(NSNotification *)noti{
    if (![_textField isFirstResponder]) return;
    NSDictionary *userInfo = noti.userInfo;
    NSValue *value = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    _keyboardHeight = value.CGRectValue.size.height; // 得到键盘弹出后的键盘视图所在y坐标
    self.keyboardCurve = [userInfo[UIKeyboardAnimationCurveUserInfoKey] integerValue];//动画类型
    self.keyboardDuration = [userInfo[UIKeyboardAnimationDurationUserInfoKey] floatValue];
    
    [UIView animateWithDuration:self.keyboardDuration animations:^{
        [UIView setAnimationCurve:self.keyboardCurve];
        if (_autoAdjust) {
           self.header.transform = CGAffineTransformMakeTranslation(0, -self.keyboardHeight- CGRectGetHeight(self.header.frame));
        }
        else{
           self.header.transform = CGAffineTransformMakeTranslation(0, -self.keyboardHeight); 
        }
    }];
    if (_delegate && [_delegate respondsToSelector:@selector(cy_keyboardObserverWillShow:keyBoardHeight:keyboradAnimationCurve:)]){
        [_delegate cy_keyboardObserverWillShow:self.keyboardDuration keyBoardHeight:self.keyboardHeight keyboradAnimationCurve:self.keyboardCurve];
    }
}

- (void)keyboardWillHide:(NSNotification *)noti{
    if (![_textField isFirstResponder]) return;
    [UIView animateWithDuration:self.keyboardDuration animations:^{
        [UIView setAnimationCurve:self.keyboardCurve];
        self.header.transform = CGAffineTransformMakeTranslation(0, 0);
    }];
    if(_delegate && [_delegate respondsToSelector:@selector(cy_keyboardObserverWillHide:keyBoardHeight:keyboradAnimationCurve:)]){
        [_delegate cy_keyboardObserverWillHide:self.keyboardDuration keyBoardHeight:self.keyboardHeight keyboradAnimationCurve:self.keyboardCurve];
    }
}

- (void)keyboardDidHide{
    if (_delegate && [_delegate respondsToSelector:@selector(cy_keyboardObserverDidHide)]){
        [_delegate cy_keyboardObserverDidHide];
    }
}

- (void)resignFirstResponser{
    [self keyboardWillHide:nil];
    [UIView animateWithDuration:self.keyboardDuration animations:^{
        [UIView setAnimationCurve:self.keyboardCurve];
        self.header.transform = CGAffineTransformMakeTranslation(0, 0);
    }];
}

@end







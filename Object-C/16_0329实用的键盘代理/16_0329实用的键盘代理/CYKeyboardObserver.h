//
//  CYKeyboardObserver.h
//  16_0329实用的键盘代理
//
//  Created by ChuckonYin on 16/3/29.
//  Copyright © 2016年 PingAn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol CYKeyboardObserverDelegate <NSObject>

- (void)cy_keyboardObserverWillShow:(CGFloat)duration keyBoardHeight:(CGFloat)height keyboradAnimationCurve:(UIViewAnimationCurve)curve;

- (void)cy_keyboardObserverWillHide:(CGFloat)duration keyBoardHeight:(CGFloat)height keyboradAnimationCurve:(UIViewAnimationCurve)curve;

- (void)cy_keyboardObserverDidHide;

@end

@interface CYKeyboardObserver : NSObject

@property (nonatomic, weak) id<CYKeyboardObserverDelegate> delegate;

/**
 *  创建键盘头视图
 *  @param textField  绑定观察者
 *  @param header     自定义键盘头视图，可与textField相同
 *  @param delegate   获取键盘对象、事件
 *  @param autoAdjust 头视图是否从底部弹出
 */
- (void)setObserveredView:(UIView *)textField andKeybordHeader:(UIView *)header delegate:(id<CYKeyboardObserverDelegate>)delegate autoAdjust:(BOOL)autoAdjust;

- (void)resignFirstResponser;

@end

//
//  ViewController.m
//  16_0329实用的键盘代理
//
//  Created by ChuckonYin on 16/3/29.
//  Copyright © 2016年 PingAn. All rights reserved.
//

#import "ViewController.h"
#import "CYKeyboardObserver.h"

@interface ViewController ()<CYKeyboardObserverDelegate>

@property (nonatomic, strong) UITextField *textField1;

@property (nonatomic, strong) CYKeyboardObserver *observer1;

@property (nonatomic, strong) UITextField *textField2;

@property (nonatomic, strong) CYKeyboardObserver *observer2;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.textField1];
    UILabel *view = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, 50)];
    view.text = @"有一种爱叫不离不弃";
    view.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:view];
    view.backgroundColor= [UIColor redColor];
    [self.observer1 setObserveredView:self.textField1 andKeybordHeader:view delegate:self autoAdjust:YES];
    
    [self.view addSubview:self.textField2];
    [self.observer2 setObserveredView:self.textField2 andKeybordHeader:self.textField2 delegate:self autoAdjust:NO];
    
    [UIView animateWithDuration:8 delay:0 usingSpringWithDamping:0.1 initialSpringVelocity:5 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        _textField1.transform = CGAffineTransformMakeTranslation(0, 20);
    } completion:^(BOOL finished) {
        
    }];
}


- (UITextField *)textField1{
    if (!_textField1) {
        _textField1 = [[UITextField alloc] initWithFrame:CGRectMake(30, 100, 150, 30)];
//        _textField1.backgroundColor = [UIColor redColor];
        _textField1.placeholder = @"键盘推出个头视图";
    }
    return _textField1;
}

- (UITextField *)textField2{
    if (!_textField2) {
        _textField2 = [[UITextField alloc] initWithFrame:CGRectMake(200, [[UIScreen mainScreen] bounds].size.height-30, 150, 30)];
//        _textField2.backgroundColor = [UIColor yellowColor];
        _textField2.placeholder = @"输入框是头视图";
    }
    return _textField2;
}

- (CYKeyboardObserver *)observer1{
    if (!_observer1) {
        _observer1 = [[CYKeyboardObserver alloc] init];
    }
    return _observer1;
}

- (CYKeyboardObserver *)observer2{
    if (!_observer2) {
        _observer2 = [[CYKeyboardObserver alloc] init];
    }
    return _observer2;
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.textField1 resignFirstResponder];
    [self.textField2 resignFirstResponder];
}

- (void)cy_keyboardObserverWillShow:(CGFloat)duration keyBoardHeight:(CGFloat)height keyboradAnimationCurve:(UIViewAnimationCurve)curve{
    if (![self.textField2 isFirstResponder]) {
        [self.observer2 resignFirstResponser];
    }
}

- (void)cy_keyboardObserverWillHide:(CGFloat)duration keyBoardHeight:(CGFloat)height keyboradAnimationCurve:(UIViewAnimationCurve)curve{
    
}



@end

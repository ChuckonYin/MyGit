//
//  ViewController.m
//  16_0526YZTNumberPad
//
//  Created by ChuckonYin on 16/5/26.
//  Copyright © 2016年 pinAn.com. All rights reserved.
//

#import "ViewController.h"
#import "YZTNumberPad.h"

@interface ViewController ()

@property (nonatomic, strong) UITextField *textField1;

@property (nonatomic, strong) UITextField *textField2;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.textField1];
    
    [self.view addSubview:self.textField2];
}

- (UITextField *)textField1{
    if (!_textField1) {
        _textField1 = [[UITextField alloc] initWithFrame:CGRectMake(0, 200, kScreenWidth, 44)];
        _textField1.borderStyle = UITextBorderStyleLine;
        _textField1.inputView = [[YZTNumberPad alloc] initWithTextField:_textField1];
    }
    return _textField1;
}

- (UITextField *)textField2{
    if (!_textField2) {
        _textField2 = [[UITextField alloc] initWithFrame:CGRectMake(0, 300, kScreenWidth, 44)];
        _textField2.borderStyle = UITextBorderStyleLine;
        _textField2.inputView = [[YZTNumberPad alloc] initWithTextField:_textField2];
    }
    return _textField2;
}


@end

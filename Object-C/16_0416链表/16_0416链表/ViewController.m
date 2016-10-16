//
//  ViewController.m
//  16_0416链表
//
//  Created by ChuckonYin on 16/4/16.
//  Copyright © 2016年 pinAn.com. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic, strong) UIScrollView *scroll;

@property (nonatomic, strong) UITextField *textField;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.scroll];
    
    [self.scroll addSubview:self.textField];
    
}

- (UIScrollView *)scroll{
    if (!_scroll) {
        _scroll = [[UIScrollView alloc] initWithFrame:self.view.bounds];
        _scroll.contentSize = CGSizeMake(0, 1000);
        _scroll.keyboardDismissMode = UIScrollViewKeyboardDismissModeInteractive;
    }
    return _scroll;
}

- (UITextField *)textField{
    if (!_textField) {
        _textField = [[UITextField alloc] initWithFrame:CGRectMake(30, 100, 300, 30)];
        _textField.borderStyle = UITextBorderStyleLine;
    }
    return _textField;
}






@end

//
//  ViewController.m
//  CYLimitTextField
//
//  Created by ChuckonYin on 16/4/12.
//  Copyright © 2016年 pinAn.com. All rights reserved.
//

#import "ViewController.h"
#import "CYLimitTextField.h"
#import "FirstViewController.h"
@interface ViewController ()<UITextFieldDelegate>

@property (nonatomic, strong) CYLimitTextField *textField;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    _textField = [[CYLimitTextField alloc] initWithFrame:CGRectMake(50, 150, 270, 30) limit:@"### ###" preferDirection:YES];
    _textField.borderStyle = UITextBorderStyleLine;
    _textField.delegate = self;
    [self.view addSubview:_textField];
    
    
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    [self push];
    return YES;
}

- (void)push{
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    _textField.transform = CGAffineTransformMakeRotation(-0.05);
    [UIView animateWithDuration:1 delay:0 usingSpringWithDamping:0.001 initialSpringVelocity:20000 options:UIViewAnimationOptionCurveEaseIn animations:^{
        _textField.transform = CGAffineTransformMakeRotation(0);
    } completion:^(BOOL finished) {
        
    }];
    
}




@end

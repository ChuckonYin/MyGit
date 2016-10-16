//
//  ViewController.m
//  16_0405keyboardBug
//
//  Created by ChuckonYin on 16/4/5.
//  Copyright © 2016年 PingAn. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic, strong) UITextField *field;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.field];
    self.field.delegate = self;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(act:) name:UIKeyboardWillHideNotification object:nil];
}

- (UITextField *)field{
    if (!_field) {
        _field = [[UITextField alloc] initWithFrame:CGRectMake(0, 100, 300, 30)];
        _field.borderStyle = UITextBorderStyleLine;
    }
    return _field;
}

- (void)act:(NSNotification *)noti{
    NSLog(@"%@", noti.userInfo);
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.field resignFirstResponder];
}


@end

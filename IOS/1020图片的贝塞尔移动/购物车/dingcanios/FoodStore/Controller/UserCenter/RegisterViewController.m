//
//  RegisterViewController.m
//  FoodStore
//
//  Created by ZhangShouC on 12/26/14.
//  Copyright (c) 2014 liuguopan. All rights reserved.
//

#import "RegisterViewController.h"

@interface RegisterViewController ()<UITextFieldDelegate>
{
    UITextField * _tel;
    UITextField * _address;
    UITextField * _again;
}
@end

@implementation RegisterViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [self setNav];
    [self initViews];
}
- (void)initViews
{
    _tel = [[UITextField alloc] initWithFrame:CGRectMake(10, 80, 300, 40)];
    _tel.placeholder = @"输入用户名";
    _tel.delegate = self;
    _tel.backgroundColor = [UIColor whiteColor];
    _tel.borderStyle = UITextBorderStyleRoundedRect;
    _tel.secureTextEntry = NO;
    _tel.returnKeyType = UIReturnKeyDone;
    _tel.clearButtonMode = UITextFieldViewModeWhileEditing;
    [self.view addSubview:_tel];
    
    _address = [[UITextField alloc] initWithFrame:CGRectMake(10, 123, 300, 40)];
    _address.placeholder = @"输入密码(至少8位)";
    _address.delegate = self;
    _address.backgroundColor = [UIColor whiteColor];
    _address.borderStyle = UITextBorderStyleRoundedRect;
    _address.secureTextEntry = YES;
    _address.returnKeyType = UIReturnKeyDone;
    _address.clearButtonMode = UITextFieldViewModeWhileEditing;
    [self.view addSubview:_address];
    
    _again = [[UITextField alloc] initWithFrame:CGRectMake(10, 166, 300, 40)];
    _again.placeholder = @"再次输入密码";
    _again.delegate = self;
    _again.backgroundColor = [UIColor whiteColor];
    _again.borderStyle = UITextBorderStyleRoundedRect;
    _again.secureTextEntry = YES;
    _again.returnKeyType = UIReturnKeyDone;
    _again.clearButtonMode = UITextFieldViewModeWhileEditing;
    [self.view addSubview:_again];
    
    UILabel * loginLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 225, 300, 50)];
    loginLabel.text = @"注册";
    loginLabel.textColor = [UIColor whiteColor];
    loginLabel.backgroundColor = [UIColor colorWithRed:0.80f green:0.26f blue:0.23f alpha:1.00f];
    loginLabel.textAlignment = NSTextAlignmentCenter;
    loginLabel.font = [UIFont systemFontOfSize:20];
    [self.view addSubview:loginLabel];
    loginLabel.userInteractionEnabled = YES;
    UITapGestureRecognizer * loginTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(login)];
    [loginLabel addGestureRecognizer:loginTap];
    
    
}
- (void)login
{
    [_tel resignFirstResponder];
    [_address resignFirstResponder];
    [_again resignFirstResponder];
    if (!_tel.text.length) {
        [SVProgressHUD showErrorWithStatus:@"用户名不能为空"];
        return;
    }
    if (_address.text.length < 8) {
        [SVProgressHUD showErrorWithStatus:@"密码不能少于8位"];
        return;
    }
    if (![_again.text isEqualToString:_address.text]) {
        [SVProgressHUD showErrorWithStatus:@"请再次输入密码"];
        _again.text = @"";
        return;
    }

    [self download];
    
}
- (void)download
{
    NSString * path = [NSString stringWithFormat:@"%@/username/%@/password/%@/repassword/%@/session_id/%@",DIANCAN_REGISTER,_tel.text,_address.text,_again.text,[Public getMac]];
    [GCDServer serverWithUrl:path complete:^(NSData * data) {
        NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        if ([dict[@"status"] isEqualToNumber:@1]) {
            [SVProgressHUD showSuccessWithStatus:dict[@"msg"]];
            [self backPop];
        } else {
            [SVProgressHUD showErrorWithStatus:dict[@"msg"]];
        }
    }];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
- (void)setNav
{
    [self resetTitleView:@"注册"];
    [self setBackItem:@selector(backPop)];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

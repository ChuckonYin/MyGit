//
//  LoginViewController.m
//  FoodStore
//
//  Created by ZhangShouC on 12/26/14.
//  Copyright (c) 2014 liuguopan. All rights reserved.
//

#import "LoginViewController.h"
#import "RegisterViewController.h"

@interface LoginViewController ()<UITextFieldDelegate,UIAlertViewDelegate>
{
    UITextField * _name;
    UITextField * _address;
    NSString * _path;
    int index;
}
@end

@implementation LoginViewController

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
    [self initView];
}
+ (void)remberLogin
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    if ((NSNull *)[userDefaults objectForKey:@"username"] == [NSNull null]) {
        return;
    }
    NSString * name = [userDefaults objectForKey:@"username"];
    NSString * pass = [userDefaults objectForKey:@"password"];
    NSString * urlpath = [NSString stringWithFormat:@"%@/username/%@/password/%@/session_id/%@",DIANCAN_LOGIN,name,pass,[Public getMac]];
    [GCDServer serverWithUrl:urlpath complete:^(NSData * data) {
        NSMutableArray * arr = [JSON getUser:data];
        if (arr.count == 1) {
            [Public sharedPublic].userInfo = arr[0];
        }
    }];

    
    
    
    
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    if ((NSNull *)[userDefaults objectForKey:@"username"] != [NSNull null]) {
        _name.text = [userDefaults objectForKey:@"username"];
        _address.text = [userDefaults objectForKey:@"password"];
    } else {
        _name.text = @"a";
        _address.text = @"aaaaaaaa";
    }
    
}
- (void)initView
{
    _name = [[UITextField alloc] initWithFrame:CGRectMake(10, 80, 300, 40)];
    _name.placeholder = @"帐号";
    _name.delegate = self;
    _name.backgroundColor = [UIColor whiteColor];
    _name.borderStyle = UITextBorderStyleRoundedRect;
    _name.secureTextEntry = NO;
    [_name becomeFirstResponder];
    _name.returnKeyType = UIReturnKeyDone;
    _name.clearButtonMode = UITextFieldViewModeWhileEditing;
    _name.allowsEditingTextAttributes = YES;
    [self.view addSubview:_name];
    
    _address = [[UITextField alloc] initWithFrame:CGRectMake(10, 123, 300, 40)];
    _address.placeholder = @"密码";
    _address.delegate = self;
    _address.backgroundColor = [UIColor whiteColor];
    _address.borderStyle = UITextBorderStyleRoundedRect;
    _address.secureTextEntry = YES;
    _address.returnKeyType = UIReturnKeyDone;
    _address.clearButtonMode = UITextFieldViewModeWhileEditing;
    [self.view addSubview:_address];

    UILabel * loginLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 180, 300, 50)];
    loginLabel.text = @"登陆";
    loginLabel.textColor = [UIColor whiteColor];
    loginLabel.backgroundColor = [UIColor colorWithRed:0.80f green:0.26f blue:0.23f alpha:1.00f];
    loginLabel.textAlignment = NSTextAlignmentCenter;
    loginLabel.font = [UIFont systemFontOfSize:20];
    [self.view addSubview:loginLabel];
    loginLabel.userInteractionEnabled = YES;
    UITapGestureRecognizer * loginTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(loginLoad)];
    [loginLabel addGestureRecognizer:loginTap];
    
    UILabel * missLabel = [[UILabel alloc] initWithFrame:CGRectMake(240, 235, 70, 30)];
    missLabel.text = @"忘记密码?";
    missLabel.textColor = [UIColor blackColor];
    missLabel.textAlignment = NSTextAlignmentCenter;
    missLabel.font = [UIFont systemFontOfSize:14];
    [self.view addSubview:missLabel];
    missLabel.userInteractionEnabled = YES;
    UITapGestureRecognizer * missTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(missAddress)];
    [missLabel addGestureRecognizer:missTap];
    
    
    
}
- (void)missAddress
{
    UIAlertView * edit = [[UIAlertView alloc] initWithTitle:@"密码找回" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    edit.tag = 10;
    edit.alertViewStyle = UIAlertViewStyleLoginAndPasswordInput;
    UITextField * username = [edit textFieldAtIndex:0];
    username.placeholder = @"username";
    
    UITextField * email = [edit textFieldAtIndex:1];
    email.secureTextEntry = NO;
    email.placeholder = @"email";
    
    [edit show];
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 10 && buttonIndex == 1) {
        UITextField * username = [alertView textFieldAtIndex:0];
        UITextField * email = [alertView textFieldAtIndex:1];
        if (username.text && email.text) {
            index = 1;
            _path = [NSString stringWithFormat:@"%@/username/%@/email/%@",DIANCAN_SEEK,username.text,email.text];
            [GCDServer serverWithUrl:_path complete:^(NSData *data) {
                
                NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
//                if ([dict[@"status"] isEqualToNumber:@1]) {
                NSLog(@"%@",dict[@"msg"]);
                
            }];
        }
    }
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (void)loginLoad
{
    [_name resignFirstResponder];
    [_address resignFirstResponder];
    
    index = 0;
    if (!_name.text.length) {
        [SVProgressHUD showErrorWithStatus:@"用户名不能为空"];
        return;
    }
    if (_address.text.length < 8) {
        [SVProgressHUD showErrorWithStatus:@"密码不能少于8位"];
        return;
    }
    
    _path = [NSString stringWithFormat:@"%@/username/%@/password/%@/session_id/%@",DIANCAN_LOGIN,_name.text,_address.text,[Public getMac]];
    
    [SVProgressHUD show];

    [GCDServer serverWithUrl:_path complete:^(NSData * data) {
        
        NSMutableArray * arr = [JSON getUser:data];
        if (arr.count == 1) {
            [Public sharedPublic].userInfo = arr[0];
            [SVProgressHUD showSuccessWithStatus:@"登录成功"];
            [self backDismiss];
            
            NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
            [userDefaults setObject:_name.text forKey:@"username"];
            [userDefaults setObject:_address.text forKey:@"password"];
            [userDefaults synchronize];
            
        } else {
            [SVProgressHUD showErrorWithStatus:@"登录失败"];
        }
  /*
        NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            
        if ([dict[@"status"] isEqualToNumber:@1]) {
            [SVProgressHUD showSuccessWithStatus:@"登录成功"];
            
            NSDictionary * dic = dict[@"info"];
            UserInfo * info = [Public sharedPublic].userInfo;
            info.userID = dic[@"userid"];
            
            // 临时使用
//            info.userID = @"1";
            
            info.userName = dic[@"username"];
            info.userPassword = dic[@"password"];
            info.userSex = dic[@"sex"];
            if ([dic[@"phone"] isKindOfClass:[NSString class]]) {
                info.userTel = dic[@"phone"];
            } else {
                info.userTel = @"";
            }
            if ([dic[@"email"] isKindOfClass:[NSString class]]) {
                info.userEmail = dic[@"email"];
            } else {
                info.userEmail = @"";
            }
            if ([dic[@"nickname"] isKindOfClass:[NSString class]]) {
                info.userNickName = dic[@"nickname"];
            } else {
                info.userNickName = @"";
            }
            if ([dic[@"user_money"] isKindOfClass:[NSString class]]) {
                info.userMoney = dic[@"frozen_money"];
            } else {
                info.userMoney = @"0";
            }
            [Public sharedPublic].userInfo = info;
            
            [self backDismiss];

        } else {
            [SVProgressHUD showErrorWithStatus:@"登录失败"];
        }
    */
    }];
    
}

- (void)setNav
{
    [self resetTitleView:@"登陆"];
    [self setRightItem:@"注册" sel:@selector(regist)];
    [self setLeftItem:@"取消" sel:@selector(backDismiss)];
}
- (void)regist
{
    [self.navigationController pushViewController:[[RegisterViewController alloc] init] animated:YES];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

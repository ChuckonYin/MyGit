//
//  ChangePasswordViewController.m
//  FoodStore
//
//  Created by liuguopan on 14/12/24.
//  Copyright (c) 2014年 viewcreator3d. All rights reserved.
//

#import "ChangePasswordViewController.h"

@interface ChangePasswordViewController () <UITextFieldDelegate>
{
    UITextField * _old;
    UITextField * _new;
    UITextField * _again;
    NSString * path;
}
@end

@implementation ChangePasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setNav];
    [self initView];
}
- (void)initView
{
    _old = [[UITextField alloc] initWithFrame:CGRectMake(10, 80, 300, 40)];
    _old.placeholder = @"旧密码";
    _old.delegate = self;
    _old.backgroundColor = [UIColor whiteColor];
    _old.borderStyle = UITextBorderStyleRoundedRect;
    [_old becomeFirstResponder];
    _old.secureTextEntry = YES;
    _old.clearButtonMode = UITextFieldViewModeWhileEditing;
    [self.view addSubview:_old];
    
    _new = [[UITextField alloc] initWithFrame:CGRectMake(10, 130, 300, 40)];
    _new.placeholder = @"新密码";
    _new.delegate = self;
    _new.backgroundColor = [UIColor whiteColor];
    _new.borderStyle = UITextBorderStyleRoundedRect;
    _new.secureTextEntry = YES;
    _new.clearButtonMode = UITextFieldViewModeWhileEditing;
    [self.view addSubview:_new];
    
    _again = [[UITextField alloc] initWithFrame:CGRectMake(10, 170, 300, 40)];
    _again.placeholder = @"确认密码";
    _again.delegate = self;
    _again.backgroundColor = [UIColor whiteColor];
    _again.borderStyle = UITextBorderStyleRoundedRect;
    _again.secureTextEntry = YES;
    _again.clearButtonMode = UITextFieldViewModeWhileEditing;
    [self.view addSubview:_again];
    
    UILabel * loginLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 225, 300, 50)];
    loginLabel.text = @"确认修改";
    loginLabel.textColor = [UIColor whiteColor];
    loginLabel.backgroundColor = [UIColor colorWithRed:0.80f green:0.26f blue:0.23f alpha:1.00f];;
    loginLabel.textAlignment = NSTextAlignmentCenter;
    loginLabel.font = [UIFont systemFontOfSize:20];
    [self.view addSubview:loginLabel];
    loginLabel.userInteractionEnabled = YES;
    UITapGestureRecognizer * loginTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(changeClick)];
    [loginLabel addGestureRecognizer:loginTap];
}
- (void)changeClick
{
    [_old resignFirstResponder];
    [_new resignFirstResponder];
    [_again resignFirstResponder];
    
    if (_old.text.length && _new.text.length && _again.text.length && [_new.text isEqualToString:_again.text]) {
        [self download];
    }
    
}
- (void)download
{
    [SVProgressHUD show];
    UserInfo * info = [Public sharedPublic].userInfo;
    path = [NSString stringWithFormat:@"%@/userid/%@/beforepassword/%@/newpassword/%@/repassword/%@",DIANCAN_CHANGGE,info.userID,_old.text,_new.text,_again.text];
    [GCDServer serverWithUrl:path complete:^(NSData * data) {
        NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
         LOG(dict[@"msg"]);
        if ([dict[@"status"] isEqualToNumber:@1]) {
            info.userPassword = _new.text;
            [Public sharedPublic].userInfo = info;
            [SVProgressHUD dismiss];
            [self backPop];
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
    [self resetTitleView:@"修改密码"];
    [self setBackItem:@selector(backPop)];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

//
//  UserEditViewController.m
//  FoodStore
//
//  Created by ZhangShouC on 12/29/14.
//  Copyright (c) 2014 liuguopan. All rights reserved.
//

#import "UserEditViewController.h"

@interface UserEditViewController () <UITextFieldDelegate>
{
    UITextField * _old;
    UITextField * _new;
    UITextField * _email;
    
    UIButton * man;
    UIButton * woman;
    NSInteger index;
    NSString * path;
}

@end

@implementation UserEditViewController

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
    [self initData];
}
- (void)initData
{
    UserInfo * info = [Public sharedPublic].userInfo;
    _old.text = info.userNickName;
    _new.text = info.userTel;
    _email.text = info.userEmail;
    if (index != [self indexWithSex:info.userSex]) {
        index = [self indexWithSex:info.userSex];
        [self changeWithIndex];
    }
    
}
- (NSInteger)indexWithSex:(NSString *)sex
{
    if ([sex isEqualToString:@"女"]) {
        return 1;
    }
    return 0;
}
- (void)initView
{
    UILabel * name = [[UILabel alloc] initWithFrame:CGRectMake(20, 80, 50, 40)];
    name.text = @"称呼";
    name.textAlignment = NSTextAlignmentCenter;
    name.font  = [UIFont systemFontOfSize:20];
    [self.view addSubview:name];
    
    _old = [[UITextField alloc] initWithFrame:CGRectMake(80, 80, 200, 40)];
    _old.delegate = self;
//    _old.text = @"Jack";
    _old.font = [UIFont systemFontOfSize:16];
    _old.backgroundColor = [UIColor whiteColor];
    _old.borderStyle = UITextBorderStyleRoundedRect;
    _old.secureTextEntry = NO;
    _old.returnKeyType = UIReturnKeyDone;
    _old.clearButtonMode = UITextFieldViewModeWhileEditing;
    [self.view addSubview:_old];

//    
    UILabel * tel = [[UILabel alloc] initWithFrame:CGRectMake(20, 160, 50, 40)];
    tel.text = @"电话";
    tel.textAlignment = NSTextAlignmentCenter;
    tel.font  = [UIFont systemFontOfSize:20];
    [self.view addSubview:tel];
    
    _new = [[UITextField alloc] initWithFrame:CGRectMake(80, 160, 200, 40)];
    _new.delegate = self;
//    _new.text = @"12345678901";
    _new.font = [UIFont systemFontOfSize:16];
    _new.backgroundColor = [UIColor whiteColor];
    _new.borderStyle = UITextBorderStyleRoundedRect;
    _new.secureTextEntry = NO;
    _new.returnKeyType = UIReturnKeyDone;
    _new.clearButtonMode = UITextFieldViewModeWhileEditing;
    [self.view addSubview:_new];
//
    UILabel * email = [[UILabel alloc] initWithFrame:CGRectMake(20, 210, 50, 40)];
    email.text = @"邮箱";
    email.textAlignment = NSTextAlignmentCenter;
    email.font  = [UIFont systemFontOfSize:20];
    [self.view addSubview:email];
    
    _email = [[UITextField alloc] initWithFrame:CGRectMake(80, 210, 200, 40)];
    _email.delegate = self;
    //    _new.text = @"12345678901";
    _email.placeholder = @"用于密码找回";
    _email.font = [UIFont systemFontOfSize:16];
    _email.backgroundColor = [UIColor whiteColor];
    _email.borderStyle = UITextBorderStyleRoundedRect;
    _email.secureTextEntry = NO;
    _email.returnKeyType = UIReturnKeyDone;
    _email.clearButtonMode = UITextFieldViewModeWhileEditing;
    [self.view addSubview:_email];
    
//    
    man = [UIButton buttonWithType:UIButtonTypeCustom];
    man.frame = CGRectMake(100, 130, 20, 20);
    man.tag = 10;
    [man setTitle:@"◉" forState:UIControlStateNormal];
    [man setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [man addTarget:self action:@selector(manClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:man];
    
    woman = [UIButton buttonWithType:UIButtonTypeCustom];
    woman.frame = CGRectMake(190, 130, 20, 20);
    woman.tag = 11;
    [woman setTitle:@"◎" forState:UIControlStateNormal];
    [woman setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [woman addTarget:self action:@selector(manClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:woman];
    
    UILabel * lab1 = [[UILabel alloc] initWithFrame:CGRectMake(120, 130, 40, 20)];
    lab1.text = @"先生";
    lab1.textAlignment = NSTextAlignmentCenter;
    lab1.font  = [UIFont systemFontOfSize:18];
    [self.view addSubview:lab1];
    
    UILabel * lab2 = [[UILabel alloc] initWithFrame:CGRectMake(210, 130, 40, 20)];
    lab2.text = @"女士";
    lab2.textAlignment = NSTextAlignmentCenter;
    lab2.font  = [UIFont systemFontOfSize:18];
    [self.view addSubview:lab2];
    
    

}
- (void)manClick:(UIButton *)button
{
    index = button.tag - 10;
    [self changeWithIndex];
}
- (void)changeWithIndex
{
    if (!index) {
        [man setTitle:@"◉" forState:UIControlStateNormal];
        [woman setTitle:@"◎" forState:UIControlStateNormal];
    } else if (index == 1) {
        [woman setTitle:@"◉" forState:UIControlStateNormal];
        [man setTitle:@"◎" forState:UIControlStateNormal];
    }
}
- (void)changeClick
{
    [_old resignFirstResponder];
    [_new resignFirstResponder];
    [_email resignFirstResponder];
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
- (void)setNav
{
    [self resetTitleView:@"个人信息编辑"];
    [self setBackItem:@selector(backPop)];
    [self setRightItem:@"保存" sel:@selector(saveClick)];
}
- (void)saveClick
{
    UserInfo * info = [Public sharedPublic].userInfo;
    if ([_old.text isEqualToString:info.userNickName] && [_new.text isEqualToString:info.userTel] && [_email.text isEqualToString:info.userEmail] && [info.userSex isEqualToString:(index?@"女":@"男")]) {
        return;
    }
    path = [NSString stringWithFormat:@"%@/userid/%@/nickname/%@/phone/%@/email/%@/sex/%@",DIANCAN_USERSAVE,info.userID,_old.text,_new.text,_email.text,(index?@"女":@"男")];
    [GCDServer serverWithUrl:path complete:^(NSData * data) {
        NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        if ([dict[@"status"] isEqualToNumber:@1]) {
            [SVProgressHUD showSuccessWithStatus:dict[@"msg"]];
            
            UserInfo * info = [Public sharedPublic].userInfo;
            info.userNickName = _old.text;
            info.userTel = _new.text;
            info.userEmail = _email.text;
            info.userSex = index? @"女":@"男";
            [Public sharedPublic].userInfo = info;
        }
        
    }];
    
    
    
    
//    NSLog(@"\nname:%@\nsex:%d\ntel:%@",_old.text,index,_new.text);
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

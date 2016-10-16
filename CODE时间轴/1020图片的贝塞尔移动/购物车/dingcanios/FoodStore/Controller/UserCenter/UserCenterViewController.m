//
//  UserCenterViewController.m
//  FoodStore
//
//  Created by liuguopan on 14/12/19.
//  Copyright (c) 2014年 viewcreator3d. All rights reserved.
//

#import "UserCenterViewController.h"
#import "LoginViewController.h"
#import "UserEditViewController.h"
#import "AddressEditViewController.h"
#import "ChangePasswordViewController.h"
#import "MyCouponViewController.h"
#import "MyWalletViewController.h"

@interface UserCenterViewController ()
{
    UIImageView * _userImg;
    UILabel * _userName;
    UILabel * _userTel;
//    UILabel * _userSex;
}
@end

@implementation UserCenterViewController

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self sliderAbled:YES];
}
- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [self sliderAbled:NO];
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self initData];
    
    static int loginCount = 0;
    if ([Public sharedPublic].userInfo.userID == nil) {
        if (loginCount == 0) {
            [self login];
            loginCount ++;
        }
    }
    
    
   
}
- (void)initData
{
    UserInfo * info = [Public sharedPublic].userInfo;
    if ([Public sharedPublic].userInfo.userID != nil) {
        _userName.text = [NSString stringWithFormat:@"%@  %@",info.userNickName.length?info.userNickName:info.userName,info.userSex];
        _userTel.text = info.userTel;
    } else {
        _userName.text = @"登陆/注册";
        _userTel.text = @"";
//        [self login];
    }
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setNav];
    [self initView];

}
- (void)initView
{
    self.view.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1];
    
    UIImageView * head = [[UIImageView alloc] initWithFrame:CGRectMake(10, 65, 300, 60)];
    head.tag = 10;
    head.userInteractionEnabled = YES;
    head.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:head];
    
    _userImg = [[UIImageView alloc] initWithFrame:CGRectMake(15, 15, 30, 30)];
    _userImg.image = [UIImage imageNamed:@"menu_center"];
    [head addSubview:_userImg];
    
    _userName = [[UILabel alloc] initWithFrame:CGRectMake(60, 0, 120, 60)];
    _userName.text = @"登陆/注册";
    _userName.font = [UIFont boldSystemFontOfSize:18];
    [head addSubview:_userName];
    
//    _userSex = [[UILabel alloc] initWithFrame:CGRectMake(145, 0, 40, 60)];
//    _userSex.text = @"先生";
//    _userSex.backgroundColor = [UIColor orangeColor];
//    [head addSubview:_userSex];
    
    _userTel = [[UILabel alloc] initWithFrame:CGRectMake(185, 0, 110, 60)];
//    _userTel.text = @"18626347892";
    _userTel.font = [UIFont systemFontOfSize:15];
    [head addSubview:_userTel];
    
    UITapGestureRecognizer * headT = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapClick:)];
    [head addGestureRecognizer:headT];
    
//    NSArray * arr = @[@"地址管理",@"修改密码",@"我的钱包",@"我的优惠"];
    NSArray * arr = @[@"地址管理",@"修改密码",@"我的钱包",@"我的优惠"];
    for (int i = 0; i < arr.count; i++) {
        UIImageView * img = [[UIImageView alloc] initWithFrame:CGRectMake(10, 140+55*i, 300, 40)];
        img.backgroundColor = [UIColor whiteColor];
        img.userInteractionEnabled = YES;
        img.tag = i+11;
        [self.view addSubview:img];
        
        UILabel * title = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 100, 40)];
        title.text = arr[i];
        title.font = [UIFont systemFontOfSize:16];
        [img addSubview:title];
        
        UILabel * right = [[UILabel alloc] initWithFrame:CGRectMake(270, 0, 30, 40)];
        right.text = @">";
        right.font = [UIFont systemFontOfSize:20];
        right.textAlignment = NSTextAlignmentCenter;
        [img addSubview:right];
        
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapClick:)];
        [img addGestureRecognizer:tap];
    }
}
- (void)tapClick:(UITapGestureRecognizer *)tap
{
    if ([Public sharedPublic].userInfo.userID == nil) {
        [self login];
        return;
    }
    
    NSInteger index = [tap view].tag;
    if (10 == index) {
        UserEditViewController * ueVC = [[UserEditViewController alloc] init];
        [self.navigationController pushViewController:ueVC animated:YES];
    } else if (11 == index){
        [self.navigationController pushViewController:[[AddressEditViewController alloc] init] animated:YES];
    } else if (12 == index){
        [self.navigationController pushViewController:[[ChangePasswordViewController alloc] init] animated:YES];
    } else if (13 == index){
        [self.navigationController pushViewController:[[MyWalletViewController alloc] init] animated:YES];
    } else if (14 == index){
        [self.navigationController pushViewController:[[MyCouponViewController alloc] init] animated:YES];
    }
}

- (void)setNav
{
    [self setSliderItem];
    [self resetTitleView:@"个人中心"];
}
- (void)login
{
    [self presentViewController:[[BaseNavigationController alloc] initWithRootViewController:[[LoginViewController alloc] init]] animated:YES completion:nil];
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

//
//  MyWalletViewController.m
//  FoodStore
//
//  Created by liuguopan on 14/12/24.
//  Copyright (c) 2014年 viewcreator3d. All rights reserved.
//

#import "MyWalletViewController.h"

@interface MyWalletViewController ()
{
    UILabel * _money;
}
@end

@implementation MyWalletViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setNav];
    [self initView];
    [self initData];
}
- (void)initData
{
    UserInfo * info = [Public sharedPublic].userInfo;
   
    
    //_money.text = [NSString stringWithFormat:@"%@",info.userMoney];
   
    
}
- (void)initView
{
    UIView * view1 = [[UIView alloc] initWithFrame:CGRectMake(40, 90, 240, 240)];
    view1.backgroundColor = [UIColor yellowColor];
    view1.layer.cornerRadius = 120;
    [self.view addSubview:view1];
    
    UIView * view2 = [[UIView alloc] initWithFrame:CGRectMake(50, 50, 140, 140)];
    view2.backgroundColor = [UIColor whiteColor];
    view2.layer.cornerRadius = 70;
    [view1 addSubview:view2];

    
    UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(80, 80, 80, 30)];
    label.text = @"余额";
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:30];
    [view1 addSubview:label];
    
    _money = [[UILabel alloc] initWithFrame:CGRectMake(60, 115, 120, 40)];
    _money.text = @"$ 400.00";
    _money.textAlignment = NSTextAlignmentCenter;
    _money.font = [UIFont systemFontOfSize:25];
    [view1 addSubview:_money];
    
    UILabel * loginLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 380, 300, 40)];
    loginLabel.text = @"充值";
    loginLabel.textColor = [UIColor whiteColor];
    loginLabel.backgroundColor = [UIColor colorWithRed:0.80f green:0.26f blue:0.23f alpha:1.00f];
    loginLabel.textAlignment = NSTextAlignmentCenter;
    loginLabel.font = [UIFont systemFontOfSize:20];
    [self.view addSubview:loginLabel];
    loginLabel.userInteractionEnabled = YES;
    UITapGestureRecognizer * loginTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(addMoney)];
    [loginLabel addGestureRecognizer:loginTap];
    
    
}
- (void)addMoney
{
    LOG_METHOD;
}
- (void)setNav
{
    [self resetTitleView:@"我的钱包"];
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

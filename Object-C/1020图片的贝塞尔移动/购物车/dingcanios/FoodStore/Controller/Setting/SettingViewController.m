//
//  SettingViewController.m
//  FoodStore
//
//  Created by liuguopan on 14/12/19.
//  Copyright (c) 2014年 viewcreator3d. All rights reserved.
//

#import "SettingViewController.h"
#import "CustomViewController.h"
#import "LoginViewController.h"
@interface SettingViewController () <UIAlertViewDelegate>
{
    UILabel * _title1;
    UILabel * _title2;
    UISwitch * switch1;
    UISwitch * switch2;
}
@end

@implementation SettingViewController

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
    switch1.on = [CustomViewController sharedCustom].isOpen;
    _title1.text = [self titleWithBites];
//    switch2.on = YES;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1];
    [self setNav];
    [self initView];
}

- (void)initView
{
    [self setImg1];
    [self setImg2];
    [self setImg3];
    [self setLabel];
    [self setImg4];
    [self setButton];
}
- (void)dismissLogin
{
    LOG(@"退出");
    [Public sharedPublic].userInfo = nil;
    [Public sharedPublic].userInfo = [[UserInfo alloc] init];
    
    [self login];
    
}
- (void)login
{
    [self presentViewController:[[BaseNavigationController alloc] initWithRootViewController:[[LoginViewController alloc] init]] animated:YES completion:nil];
}
- (void)tap1
{
    if ([Public sharedPublic].dataBites == 0) {
//        return;
    }
    [Public sharedPublic].dataBites = 0;
    [SVProgressHUD showSuccessWithStatus:@"清除图片缓存"];
    _title1.text = @"0.0MB";
}
- (void)tap2
{
//    _title2.text = @"高清";
    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"非WIFI下图片质量" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"普通 (节省流量)",@"高清 (最佳效果)", nil];
    [alert show];
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        _title2.text = @"普通";
    } else if (buttonIndex == 2) {
        _title2.text = @"高清";
    }

}
- (void)swth3:(UISwitch *)s
{
    [CustomViewController sharedCustom].isOpen = s.isOn;
}
- (void)swth4:(UISwitch *)s
{
    [CustomViewController sharedCustom].isOn = s.isOn;
    [self bPushBind:s.isOn];
}

- (void)setImg1
{
    UIImageView * img = [[UIImageView alloc] initWithFrame:CGRectMake(10, 70, 300, 40)];
    img.backgroundColor = [UIColor whiteColor];
    img.userInteractionEnabled = YES;
    [self.view addSubview:img];
    
    UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, 150, 30)];
    label.text = @"清除图片缓存";
    [img addSubview:label];
    
    _title1 = [[UILabel alloc] initWithFrame:CGRectMake(190, 5, 100, 30)];
//    _title1.text = [self titleWithBites];
    _title1.textAlignment = NSTextAlignmentRight;
    [img addSubview:_title1];
    
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap1)];
    [img addGestureRecognizer:tap];
    
}
- (NSString *)titleWithBites
{
    long long bites = [Public sharedPublic].dataBites;
    NSLog(@"%lld",bites);
//    if (bites >= 1024*1024/100) {
//        return [NSString stringWithFormat:@"%.2fMB",(bites/1024.0)/1024.0];
//    } else if ( bites >= 1024/10) {
//        return [NSString stringWithFormat:@"%.1fKB",(bites/1024.0)];
//    }
    return [NSString stringWithFormat:@"%.2fMB",(bites/1024.0)/1024.0];
}
- (void)setImg2
{
    UIImageView * img = [[UIImageView alloc] initWithFrame:CGRectMake(10, 111, 300, 40)];
    img.backgroundColor = [UIColor whiteColor];
    img.userInteractionEnabled = YES;
    [self.view addSubview:img];
    
    UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, 150, 30)];
    label.text = @"非WIFI下图片质量";
    [img addSubview:label];
    
    _title2 = [[UILabel alloc] initWithFrame:CGRectMake(190, 5, 100, 30)];
    _title2.text = @"普通";
    _title2.textAlignment = NSTextAlignmentRight;
    [img addSubview:_title2];
    
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap2)];
    [img addGestureRecognizer:tap];
}

- (void)setImg3
{
    UIImageView * img = [[UIImageView alloc] initWithFrame:CGRectMake(10, 160, 300, 40)];
    img.backgroundColor = [UIColor whiteColor];
    img.userInteractionEnabled = YES;
    [self.view addSubview:img];
    
    UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, 150, 30)];
    label.text = @"自动定位";
    [img addSubview:label];
    
    switch1 = [[UISwitch alloc] initWithFrame:CGRectMake(240, 5, 51, 30)];
    switch1.on = [CustomViewController sharedCustom].isOpen;
    [switch1 addTarget:self action:@selector(swth3:) forControlEvents:UIControlEventValueChanged];
    [img addSubview:switch1];
}
- (void)setLabel
{
    UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(15, 205, 280, 30)];
    label.text = @"关闭自动定位后，每次打开应用默认使用上一次位置";
    label.textColor = [UIColor blackColor];
    label.font = [UIFont systemFontOfSize:12];
    [self.view addSubview:label];
}
- (void)setImg4
{
    UIImageView * img = [[UIImageView alloc] initWithFrame:CGRectMake(10, 240, 300, 40)];
    img.backgroundColor = [UIColor whiteColor];
    img.userInteractionEnabled = YES;
    [self.view addSubview:img];
    
    UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, 150, 30)];
    label.text = @"推送通知";
    [img addSubview:label];
    
    switch2 = [[UISwitch alloc] initWithFrame:CGRectMake(240, 5, 51, 30)];
    switch2.on = [CustomViewController sharedCustom].isOn;
    [switch2 addTarget:self action:@selector(swth4:) forControlEvents:UIControlEventValueChanged];
    [img addSubview:switch2];
}
- (void)setButton
{
    UILabel * loginLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 300, 300, 40)];
    loginLabel.text = @"退出登陆";
    loginLabel.textColor = [UIColor whiteColor];
    loginLabel.backgroundColor = [UIColor colorWithRed:0.80f green:0.26f blue:0.23f alpha:1.00f];
    loginLabel.textAlignment = NSTextAlignmentCenter;
    loginLabel.font = [UIFont systemFontOfSize:20];
    [self.view addSubview:loginLabel];
    loginLabel.userInteractionEnabled = YES;
    
    UITapGestureRecognizer * loginTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissLogin)];
    [loginLabel addGestureRecognizer:loginTap];
}

- (void)setNav
{
    [self setSliderItem];
    [self resetTitleView:@"设置"];
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

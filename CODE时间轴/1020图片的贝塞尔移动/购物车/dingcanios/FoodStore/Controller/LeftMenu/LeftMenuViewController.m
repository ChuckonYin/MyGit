//
//  LeftMenuViewController.m
//  FoodStore
//
//  Created by liuguopan on 14/12/19.
//  Copyright (c) 2014年 viewcreator3d. All rights reserved.
//

#import "LeftMenuViewController.h"
#import "AppDelegate.h"
#import "UserCenterViewController.h"
#import "OrderFoodViewController.h"
#import "MyOrdersViewController.h"
#import "MyFavoritesViewController.h"
#import "AboutUsViewController.h"
#import "SettingViewController.h"
#import "CartViewController.h"
@interface LeftMenuViewController ()
<UITableViewDataSource,UITableViewDelegate>
{
    UITableView * _tableView;
}
@end

@implementation LeftMenuViewController

//- (void)viewWillAppear:(BOOL)animated
//{
//    UITableViewCell * cell = [_tableView cellForRowAtIndexPath:0];
//    cell.textLabel.text = @"111";
//
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

//    self.view.backgroundColor = [UIColor colorWithRed:0.18f green:0.19f blue:0.21f alpha:1.00f];
    self.view.backgroundColor = [UIColor colorWithWhite:0.17 alpha:1];
    [self initView];
    
}
- (void)initView
{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 40, SELF_VIEW_WIDTH-60, SELF_VIEW_HEIGHT-40) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = [UIColor clearColor];
    if (IOS_VERSION>=7.0) {
        [_tableView setSeparatorInset:UIEdgeInsetsZero];
    }
    _tableView.tableFooterView = [[UIView alloc] init];
    [self.view addSubview:_tableView];
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 6;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * cellId = @"cell";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    NSArray * arr = @[@"个人中心",@"我要订餐",@"我的订单",@"我的收藏",@"关于我们",@"设置"];
    NSArray * imgArr = @[@"menu_center",@"menu_order",@"menu_myorder",@"menu_fav",@"menu_aboutus",@"menu_setting",@"menu_center"];
    cell.backgroundColor = [UIColor clearColor];
    cell.textLabel.text = arr[indexPath.row];
    cell.textLabel.font = [UIFont boldSystemFontOfSize:20];
    cell.textLabel.textColor = [UIColor lightTextColor];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    cell.imageView.image = [UIImage imageNamed:imgArr[indexPath.row]];
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.viewDeckController closeLeftViewAnimated:YES duration:0.2 completion:^(IIViewDeckController *controller, BOOL success) {
        self.viewDeckController.centerController = _navArr[indexPath.row];
    }];
//    UITableViewCell * cell = [tableView cellForRowAtIndexPath:indexPath];
//    if (indexPath.row == 0) {
//        cell.textLabel.text = @"111";
//    }
}

+ (LeftMenuViewController *)shared
{
    static LeftMenuViewController * lMVC;
    if (lMVC == nil) {
        lMVC = [[LeftMenuViewController alloc] init];
        
        [lMVC initArr];
    }
    return lMVC;
}
- (void)initArr
{
    BaseNavigationController * user = [[BaseNavigationController alloc] initWithRootViewController:[[UserCenterViewController alloc] init]];
    BaseNavigationController * order = [[BaseNavigationController alloc] initWithRootViewController:[[OrderFoodViewController alloc] init]];
    BaseNavigationController * myOrder = [[BaseNavigationController alloc] initWithRootViewController:[[MyOrdersViewController alloc] init]];
    BaseNavigationController * myFav = [[BaseNavigationController alloc] initWithRootViewController:[[MyFavoritesViewController alloc] init]];
    BaseNavigationController * about = [[BaseNavigationController alloc] initWithRootViewController:[[AboutUsViewController alloc] init]];
    BaseNavigationController * set = [[BaseNavigationController alloc] initWithRootViewController:[[SettingViewController alloc] init]];
    //BaseNavigationController *cart =[[BaseNavigationController alloc]initWithRootViewController:[[CartViewController alloc] init]];
    _navArr = @[user,order,myOrder,myFav,about,set];
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

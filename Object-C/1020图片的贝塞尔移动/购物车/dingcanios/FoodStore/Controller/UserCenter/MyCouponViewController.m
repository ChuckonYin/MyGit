//
//  MyCouponViewController.m
//  FoodStore
//
//  Created by liuguopan on 14/12/24.
//  Copyright (c) 2014年 viewcreator3d. All rights reserved.
//

#import "MyCouponViewController.h"

@interface MyCouponViewController () <UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate>
{
    UIScrollView * _scrollView;
    NSMutableArray * _dataArr;
    UITableView * _tableView;
}
@end

@implementation MyCouponViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setNav];
    [self initData];
    [self initView];
}
- (void)initData
{
    _dataArr = [[NSMutableArray alloc] initWithCapacity:0];
    for (int i = 0; i < 2; i++) {
        [_dataArr addObject:@"coupon"];
    }
    
}
- (void)initView
{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 320, SELF_VIEW_HEIGHT) style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.showsHorizontalScrollIndicator = NO;
    _tableView.showsVerticalScrollIndicator = NO;
    [_tableView setSeparatorColor:[UIColor clearColor]];
    [self.view addSubview:_tableView];
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 150;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * cellId = @"cell";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    cell.backgroundView = [self backView:_dataArr[indexPath.row]];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    return cell;
}
- (UIView *)backView:(NSString *)imgName
{
    UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 150)];
    UIImageView * img = [[UIImageView alloc] initWithFrame:CGRectMake(0, 5, 320, 150)];
    img.image = [UIImage imageNamed:imgName];
    [view addSubview:img];
    
    return view;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"立即使用" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定",nil];
    alert.tag = indexPath.row;
    [alert show];
    
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        [_dataArr removeObjectAtIndex:alertView.tag];
        [_tableView reloadData];
    }
}

- (void)setNav
{
    [self resetTitleView:@"我的优惠"];
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

//
//  RestaurSearchViewController.m
//  FoodStore
//
//  Created by liuguopan on 14/12/25.
//  Copyright (c) 2014年 viewcreator3d. All rights reserved.
//

#import "RestaurSearchViewController.h"
#import "FoodListViewController.h"
#import "RestaurCell.h"
#import "LoginViewController.h"

@interface RestaurSearchViewController () <UISearchBarDelegate,UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate>
{
    UITableView * _tableView;
    NSMutableArray * _dataArr;
    UISearchBar * search;
    NSString * path;
}
@end

@implementation RestaurSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setNav];
    [self initData];
    [self initView];
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    static int count = 0;
    if (count) {
        [self downloadData];
    } else {
        count = 1;
    }
}
- (void)initData
{
    _dataArr = [[NSMutableArray alloc] initWithCapacity:0];
}
- (void)initView
{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 320, SELF_VIEW_HEIGHT-0) style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.showsHorizontalScrollIndicator = NO;
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.backgroundColor = [UIColor clearColor];
    if (IOS_VERSION>=7.0) {
        [_tableView setSeparatorInset:UIEdgeInsetsZero];
    }
    _tableView.tableFooterView = [[UIView alloc] init];
    [self.view addSubview:_tableView];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 90;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArr.count;
//    return 5;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * cellId = @"cell";
    RestaurCell * cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[RestaurCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell.favoriteButton addTarget:self
                                action:@selector(favClick:)
                      forControlEvents:UIControlEventTouchUpInside];
    }

    RestaurInfo * info = _dataArr[indexPath.row];
    
    cell.favoriteButton.indexPath = indexPath;
    cell.favoriteButton.site_id = info.restaurID;
    cell.favoriteButton.selected = info.isFavorite;
    
    cell.restaurNameLabel.text = info.restaurName;
    cell.stars = info.stars;
    cell.reviewsLabel.text = [NSString stringWithFormat:@"(%@)",info.reviews];
    cell.sellCopiesLable.text = [NSString stringWithFormat:@"月售%@份",info.monthlySales];
    cell.percapitaExpenseLabel.text = [NSString stringWithFormat:@"人均：%@",info.percapita];
    cell.freightLabel.text = [NSString stringWithFormat:@"运费：%@",info.freight];
    cell.freightTimeLabel.text = [NSString stringWithFormat:@"%@",info.freightTime];
    cell.cuisineLabel.text = [NSString stringWithFormat:@"菜系：%@",info.cuisine];
    cell.couponTipsLabel.text = [NSString stringWithFormat:@"优惠/提醒:%@",info.couponTips];
    [GCDServer setImageWithUrl:info.restaurIcon view:cell.iconImageView];
    
    return cell;
}
- (void)favClick:(VCButton *)btn
{
    
    if ([Public sharedPublic].userInfo.userID == nil) {
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"登陆后可收藏餐厅" message:nil delegate:self cancelButtonTitle:@"以后再说" otherButtonTitles:@"登陆注册", nil];
        [alert show];
        return;
    }
    path = [NSString stringWithFormat:@"%@/%@/store_id/%@/user_id/%@",DIANCAN_VIEW1,(btn.selected ? @"del_collect_store" : @"collect_store"),btn.site_id,[Public sharedPublic].userInfo.userID];
    [GCDServer serverWithUrl:path complete:^(NSData * data) {
        NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        if ([dict[@"status"] isEqualToNumber:@1]) {
            [SVProgressHUD showSuccessWithStatus:dict[@"msg"]];
            btn.selected = !btn.selected;
        } else {
            [SVProgressHUD showErrorWithStatus:dict[@"msg"]];
        }
    }];
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        [self presentViewController:[[BaseNavigationController alloc] initWithRootViewController:[[LoginViewController alloc] init]] animated:YES completion:nil];
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    FoodListViewController *flVC = [[FoodListViewController alloc] init];
    [self.navigationController pushViewController:flVC animated:YES];
}
- (void)setNav
{
    [self setBackItem:@selector(backPop)];
//    [self setRightItem:@"取消" sel:@selector(backDismiss)];
    [self setSearch];
}
- (void)setSearch
{
    search = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, 200, 30)];
    search.placeholder = @"请输入餐厅名称";
    search.delegate = self;
    search.searchBarStyle = UISearchBarStyleProminent;
    self.navigationItem.titleView = search;
}
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [searchBar resignFirstResponder];
    [self downloadData];
    
}
- (void)backSearch
{
    [self downloadData];
}
- (void)downloadData
{
    if (search.text.length == 0) {
        return;
    }
    path = [NSString stringWithFormat:@"%@/store_name/%@",DIANCAN_STOREDATA,search.text];
    if ([Public sharedPublic].userInfo.userID) {
        path = [NSString stringWithFormat:@"%@/store_name/%@/user_id/%@",DIANCAN_STOREDATA,search.text,[Public sharedPublic].userInfo.userID];
    }
    [GCDServer serverWithUrl:path complete:^(NSData * data) {
        
        _dataArr = [JSON getRestaurs:data];
        [_tableView reloadData];
        
    }];
    
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

//
//  MyOrdersViewController.m
//  FoodStore
//
//  Created by liuguopan on 14/12/19.
//  Copyright (c) 2014年 viewcreator3d. All rights reserved.
//

#import "MyOrdersViewController.h"
#import "CommentViewController.h"
#import "MyOrderCell.h"
#import "OrderCenterViewController.h"
@interface MyOrdersViewController () <UITableViewDataSource,UITableViewDelegate,MyOrderCellDelegate>
{
    UITableView * _tableView;
    NSInteger _select;
//    NSMutableArray * _undoneArr;
//    NSMutableArray * _doneArr;
//    NSMutableArray * _failArr;
}
@property (nonatomic,strong) NSMutableArray * dataArr;
@property (nonatomic,strong) NSString * urlPath;
@end

@implementation MyOrdersViewController

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self sliderAbled:YES];
}
- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [SVProgressHUD dismiss];
    [self sliderAbled:NO];
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    static int count = 0;
    if (count) {
        [self reloadArr];
    } else {
        count = 1;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setNav];
    [self initData];
    [self initView];
    [self reloadArr];
}
- (void)initData
{
//    _undoneArr = [[NSMutableArray alloc] initWithCapacity:0];
//    _doneArr = [[NSMutableArray alloc] initWithCapacity:0];
//    _failArr = [[NSMutableArray alloc] initWithCapacity:0];
    _dataArr = [NSMutableArray arrayWithCapacity:0];
}
- (void)reloadArr
{
    NSString * userid;
    if ([Public sharedPublic].userInfo.userID) {
        userid = [Public sharedPublic].userInfo.userID;
        
    } else {
        [SVProgressHUD showErrorWithStatus:@"请先登陆"];
        return;
    }
    [SVProgressHUD show]; 
    _urlPath = [NSString stringWithFormat:@"%@/userid/%@/status/%ld",DIANCAN_ORDER,userid,(long)_select+1];
    [GCDServer serverWithUrl:_urlPath complete:^(NSData * data) {
        NSArray * array = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        [_dataArr removeAllObjects];
        if (array == nil) {
            [SVProgressHUD dismiss];
            [_tableView reloadData];
            return;
        }
        for (NSDictionary *dict in array) {
            OrderMainInfo *info = [[OrderMainInfo alloc] init];
            info.order_id = dict[@"order_id"];
            info.add_time = dict[@"add_time"];
            info.order_sn = dict[@"order_sn"];
            info.totalPrice = dict[@"order_amount"];
            info.restaurID = dict[@"store_id"];
            [_dataArr addObject:info];
        }
        
        for (NSInteger i=0; i<_dataArr.count; i++) {
//            OrderInfo *info = (OrderInfo *)_dataArr[i];
//            if (info.order_id != nil) {
//                [self downloadDataWithOrderidWith:info.order_id];
//            }
            [self downloadDataWithOrderidWith:i];
        }
        
    }];
    
    
}

- (void)downloadDataWithOrderidWith:(int)index
{
    OrderMainInfo * mainInfo = _dataArr[index];
    NSString *url = [NSString stringWithFormat:@"%@/storedata/store_id/%@", DIANCAN_VIEW, mainInfo.restaurID];
    [GCDServer serverWithUrl:url complete:^(NSData * data) {
        NSArray * arr = [JSON getRestaurs:data];
        if (arr.count == 1) {
            RestaurInfo * info = arr[0];
            mainInfo.restaurName = info.restaurName;
            mainInfo.restaurTel = info.tel;
            [_dataArr replaceObjectAtIndex:index withObject:mainInfo];
        }
        [SVProgressHUD dismiss];
        [_tableView reloadData];
    }];
}

- (void)initView
{
    self.view.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1];
    [self setHead];
    [self setTable];
}
- (void)setTable
{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 105, 320, SELF_VIEW_HEIGHT-105) style:UITableViewStylePlain];
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
    return 150;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//    if (_select == 0) {
////         return _undoneArr.count;
//        return 3;
//    } else if (_select == 1) {
////        return _doneArr.count;
//        return 4;
//    } else if (_select == 2) {
////        return _failArr.count;
//        return 1;
//    }
    
    return _dataArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * cellId = @"cell";
    MyOrderCell * cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[MyOrderCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    OrderMainInfo *info = _dataArr[indexPath.row];
    NSArray * actArr = @[@"立即支付",@"",@"去评价",@"已失效"];
    NSArray * staArr = @[@"待付款",@"",@"已完成",@"已失效"];
    [cell.action setTitle:actArr[_select] forState:UIControlStateNormal];
    cell.state.text = staArr[_select];
    cell.price.text = info.totalPrice;
    cell.number.text = info.order_sn;
    cell.time.text = info.add_time;
    cell.name.text = info.restaurName;
    cell.delegate = self;
    if (_select == 3) {
        cell.action.hidden = YES;
    } else {
        cell.action.hidden = NO;
    }
    cell.indexPath = indexPath;
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    OrderCenterViewController * center = [[OrderCenterViewController alloc] init];
    center.isLast = YES;
    center.orderState = _select;
//    center.mainInfo = _dataArr[indexPath.row];
    OrderMainInfo * info = _dataArr[indexPath.row];
    center.order_id = info.order_id;
    [self.navigationController pushViewController:center animated:YES];
}
- (void)actionClick:(NSIndexPath *)indexPath
{
    if (_select == 2) {
        CommentViewController * comment = [[CommentViewController alloc] init];
        OrderMainInfo *info = _dataArr[indexPath.row];
        comment.info = info;
        [self.navigationController pushViewController:comment animated:YES];
    }
}
- (void)setHead
{
    NSArray * title = @[@"未完成",@"已完成",@"已失效"];
    for (int i = 0; i < 3; i++) {
        UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(107*i, 64, 106, 40);
        [button setTitle:title[i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:18];
        if (i==0) {
            button.tag = 10+i;// 10
        } else {
            button.tag = 11+i;// 12 13
        }
        [button addTarget:self action:@selector(selectClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:button];
        
        if (!i) {
            button.backgroundColor = [UIColor clearColor];
        } else {
            button.backgroundColor = [UIColor whiteColor];
        }
    }
}
- (void)selectClick:(UIButton *)button
{
    if (_select == button.tag - 10) {
        return;
    }
    _select = button.tag - 10;
    for (int i = 0; i < 3; i++) {
        UIButton * btn;
        if (i==0) {
            btn = (UIButton *)[self.view viewWithTag:10+i];
        } else {
            btn = (UIButton *)[self.view viewWithTag:11+i];
        }
        
        if (btn.tag == _select +10) {
            btn.backgroundColor = [UIColor clearColor];
        } else {
            btn.backgroundColor = [UIColor whiteColor];
        }
    }
    
    [self reloadArr];
}

- (void)setNav
{
    [self setSliderItem];
    [self resetTitleView:@"订单中心"];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

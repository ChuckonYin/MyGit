//
//  OrderCenterViewController.m
//  FoodStore
//
//  Created by liuguopan on 14/12/25.
//  Copyright (c) 2014年 viewcreator3d. All rights reserved.
//

#import "OrderCenterViewController.h"
#import "OrderCenterFirstCell.h"
#import "OrderCenterSecondCell.h"
#import "OrderCenterThirdCell.h"
#import "OrderCenterFourthCell.h"

@interface OrderCenterViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic,strong) UITableView * tableView;
@property (nonatomic, strong) CartInfo *cartInfo;

@end

@implementation OrderCenterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = [UIColor colorWithRed:0.93f green:0.93f blue:0.93f alpha:1.00f];
    [self initPublic];
    [self setNav];
    [self downloadData];
    [self createTableView];
}

- (void)downloadData
{
    [self downMain];
    [self downCart];
}
- (void)downMain
{
    NSString * path = [NSString stringWithFormat:@"%@/get_order/order_id/%@",DIANCAN_VIEW2,_order_id];
    [GCDServer serverWithUrl:path complete:^(NSData * data) {
        NSArray * arr = [JSON getMainOrder:data];
        
        NSLog(@"11111%@",arr[0]);
        if (arr.count == 1) {
            self.mainInfo = arr[0];
            
            
            [self.tableView reloadData];
            [self downRest];
        }
    }];
}
- (void)downRest
{
    NSString *url = [NSString stringWithFormat:@"%@/storedata/store_id/%@", DIANCAN_VIEW, self.mainInfo.restaurID];
    [GCDServer serverWithUrl:url complete:^(NSData * data) {
        NSArray * arr = [JSON getRestaurs:data];
        NSLog(@"000%@",arr);
        if (arr.count == 1) {
            RestaurInfo * restInfo = arr[0];
            self.mainInfo.restaurTel = restInfo.tel;
            
            self.mainInfo.restaurName = restInfo.restaurName;
        }
        [_tableView reloadData];
    }];
}
- (void)downCart
{
    self.cartInfo = [[CartInfo alloc] init];
    NSString *url = [NSString stringWithFormat:@"%@/order_goods/order_id/%@",DIANCAN_VIEW1,_order_id];
    [GCDServer serverWithUrl:url complete:^(NSData *data) {
        self.cartInfo.foodsArray = [JSON getOrder:data];
        [self.tableView reloadData];
    }];

}
- (void)initPublic
{
    [Public sharedPublic].restInfo = nil;
    [Public sharedPublic].addressInfo = nil;
    [Public sharedPublic].cartInfo = nil;
}
- (void)setNav
{
    [self resetTitleView:@"我的订单"];
    [self setBackItem:@selector(backPop)];
}
- (void)backPop
{
    if (self.isLast) {
        [super backPop];
    } else {
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
}

#pragma mark -
#pragma mark - tableView
- (void)createTableView
{
    CGRect frame = CGRectMake(5.0f,
                              SELF_VIEW_ORIGIN_Y,
                              SELF_VIEW_WIDTH - 10.0f,
                              SELF_VIEW_HEIGHT - SELF_VIEW_ORIGIN_Y);
    UITableView *orderTableView = [[UITableView alloc] initWithFrame:frame style:UITableViewStylePlain];
    orderTableView.contentInset = UIEdgeInsetsMake(8.0f, 0, 8.0f, 0);
    if (IOS_VERSION >= 7.0) {
        [orderTableView setSeparatorInset:UIEdgeInsetsZero];
    }
    orderTableView.backgroundColor = [UIColor colorWithRed:0.93f green:0.93f blue:0.93f alpha:1.00f];
    orderTableView.showsVerticalScrollIndicator = NO;
    orderTableView.dataSource = self;
    orderTableView.delegate = self;
    [self.view addSubview:orderTableView];
    
    UIView *emptyView = [[UIView alloc] init];
    [orderTableView setTableFooterView:emptyView];
    
    self.tableView = orderTableView;
}

#pragma mark - tableViewDataSource tableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 1) {
        return self.cartInfo.foodsArray.count;
    }
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (0 == indexPath.section) {
        return 45.0f;
    } else if (1 == indexPath.section) {
        return 30.0f;
    } else if (2 == indexPath.section) {
        return 170.0f;
    } else {
        return 160.0f;
    }
}

#pragma mark - cellForRow
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (0 == indexPath.section) {
        static NSString *cellName = @"OrderCenterFirstCell";
        OrderCenterFirstCell *cell = [tableView dequeueReusableCellWithIdentifier:cellName];
        if (nil == cell) {
            cell = [[[NSBundle mainBundle] loadNibNamed:cellName owner:self options:nil] lastObject];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.OrderIdLabel.numberOfLines = 2;
            cell.OrderIdLabel.textAlignment = NSTextAlignmentCenter;
        }
        NSArray * staArr = @[@"待付款",@"",@"已完成",@"已失效"];
        cell.StateLabel.text = staArr[_orderState];
        cell.OrderIdLabel.text = _mainInfo.order_sn;
        
        return cell;
    } else if (1 == indexPath.section) {
        static NSString *cellName = @"OrderCenterSecondCell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellName];
        if (nil == cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        cell.backgroundView = [self viewWithIndexPath:indexPath.row];
        
        return cell;
    } else if (2 == indexPath.section) {
        static NSString *cellName = @"OrderCenterThirdCell";
        OrderCenterThirdCell *cell = [tableView dequeueReusableCellWithIdentifier:cellName];
        if (nil == cell) {
            cell = [[[NSBundle mainBundle] loadNibNamed:cellName owner:self options:nil] lastObject];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        cell.TimeLabel.text = _mainInfo.add_time;
        cell.RestNameLabel.text = self.mainInfo.restaurName;
        cell.RestTelLabel.text = self.mainInfo.restaurTel;
        
        if (_mainInfo.driverTel) {
            cell.OrderTelLabel.text = _mainInfo.driverTel;
        } else {
            cell.OrderTelLabel.text = @"无";
        }
        
        cell.AddrLabel.text = _mainInfo.address;
        cell.TelLabel.text = _mainInfo.tel;
        
        return cell;
    } else {
        static NSString *cellName = @"OrderCenterFourthCell";
        OrderCenterFourthCell *cell = [tableView dequeueReusableCellWithIdentifier:cellName];
        if (nil == cell) {
            cell = [[[NSBundle mainBundle] loadNibNamed:cellName owner:self options:nil] lastObject];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        cell.timeLabel.text = _mainInfo.delivery_time;
        if (_mainInfo.num.integerValue != 0) {
            cell.numLabel.text = [NSString stringWithFormat:@"%d",_mainInfo.num.intValue];
        } else {
            cell.numLabel.text = @"1";
        }
        if (_mainInfo.addInfor) {
            cell.inforLabel.text = _mainInfo.addInfor;
        } else {
            cell.inforLabel.text = @"无";
        }
        
        cell.priceLabel.text = [NSString stringWithFormat:@"￥%.2f",self.mainInfo.totalPrice.floatValue];
        [cell.button addTarget:self action:@selector(zhifuClick) forControlEvents:UIControlEventTouchUpInside];
        
        return cell;
    }
}
- (UIView *)viewWithIndexPath:(NSInteger)index
{
    UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 300, 30)];
    CartFoodInfo * info = self.cartInfo.foodsArray[index];
    
    UILabel * name = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 150, 30)];
    name.font = [UIFont systemFontOfSize:14];
    name.text = [NSString stringWithFormat:@"%@/份",info.foodName];
    [view addSubview:name];
    
    UILabel * num = [[UILabel alloc] initWithFrame:CGRectMake(200, 0, 30, 30)];
    num.font = [UIFont systemFontOfSize:14];
    num.text = info.quantity;
//    num.backgroundColor = [UIColor blueColor];
    num.textAlignment = NSTextAlignmentCenter;
    [view addSubview:num];
    
    UILabel * price = [[UILabel alloc] initWithFrame:CGRectMake(230, 0, 70, 30)];
    price.font = [UIFont systemFontOfSize:14];
    price.text = [NSString stringWithFormat:@"￥%@",info.price];
//    price.backgroundColor = [UIColor orangeColor];
    price.textAlignment = NSTextAlignmentRight;
    [view addSubview:price];
    
    return view;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
   
}
- (void)zhifuClick
{
    
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

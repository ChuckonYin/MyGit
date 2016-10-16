//
//  SubmitViewController.m
//  FoodStore
//
//  Created by liuguopan on 14/12/25.
//  Copyright (c) 2014年 viewcreator3d. All rights reserved.
//

#import "SubmitViewController.h"
#import "SubmitFirstCell.h"
#import "SubmitSecondCell.h"
#import "SubmitThirdCell.h"
#import "SubmitFourthCell.h"
#import "OrderCenterViewController.h"
#import "VCButton.h"
#import "LoginViewController.h"

#define kBottomAreaHeight   70.0f
#define kDatePickerHeight   160.0f

@interface SubmitViewController ()
<UITableViewDataSource,
 UITableViewDelegate,
 UITextFieldDelegate,UIAlertViewDelegate>
{
    NSInteger payIndex;
    NSInteger peisongIndex;
    NSString * extension;
    NSInteger number;
}
@property (nonatomic, strong) UIView *bgDatePickerView;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIDatePicker *datePicker;
@property (nonatomic,strong) CartInfo * cartInfo;
@property (nonatomic,strong) RestaurInfo * restInfo;
@property (nonatomic,strong) NSMutableArray * payArr;
@property (nonatomic,strong) NSMutableArray * peisongArr;
@property (nonatomic,strong) NSMutableArray * cartArr;

@end

@implementation SubmitViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor colorWithRed:0.93f green:0.93f blue:0.93f alpha:1.00f];
    [self downloadData];
    [self setNav];
    [self createSubmitButton];
    [self createTableView];
    [self createDataPicker];

}
- (void)downloadData
{
    payIndex = 0;
    peisongIndex = 0;
    self.cartInfo = [Public sharedPublic].cartInfo;
    self.restInfo = [Public sharedPublic].restInfo;
    self.cartArr = [[NSMutableArray alloc] initWithCapacity:0];
    for (CartFoodInfo * info in self.cartInfo.foodsArray) {
        [self.cartArr addObject:info.carID];
    }
//    self.cartInfo = [[CartInfo alloc] init];
//    NSString *url;
//    if ([Public sharedPublic].userInfo.userID) {
//        url = [NSString stringWithFormat:@"%@/user_id/%@/session_id/%@",DIANCAN_CAR,[Public sharedPublic].userInfo.userID,[Public getMac]];
//    } else {
//        url = [NSString stringWithFormat:@"%@/user_id/0/session_id/%@",DIANCAN_CAR,[Public getMac]];
//    }
//    [GCDServer serverWithUrl:url complete:^(NSData *data) {
//        NSMutableArray * arr = [JSON getFoodsInShoppingCart:data];
//        self.cartInfo.foodsArray = arr;
//        if (!arr.count) {
//            return;
//        }
//        CartFoodInfo * info0 = arr[0];
//        self.cartInfo.userID = info0.userID;
//        self.cartInfo.restaurID = info0.restaurID;
//        for (CartFoodInfo * cfInfo in arr) {
//            self.cartInfo.totalCopies += cfInfo.quantity.intValue;
//            self.cartInfo.totalPrice += cfInfo.quantity.intValue * cfInfo.price.floatValue;
//        }
//        [self.tableView reloadData];
//        if (self.cartInfo.restaurID) {
//            [self downloadPeisong];
            [self downloadZhifu];
//        }
//    } error:^(NSError *error) {
//        
//    }];

}
- (void)downloadPeisong
{
    NSString * path = [NSString stringWithFormat:@"%@/store_shippings/store_id/%@",DIANCAN_VIEW2,self.cartInfo.restaurID];
    [GCDServer serverWithUrl:path complete:^(NSData * data) {
        self.peisongArr = [JSON getPeisong:data];
        [self.tableView reloadData];
    }];
}


- (void)downloadZhifu
{
    NSString * path = [NSString stringWithFormat:@"%@/store_pays/store_id/%@/type/2",DIANCAN_VIEW2,self.cartInfo.restaurID];
    [GCDServer serverWithUrl:path complete:^(NSData * data) {
        self.payArr = [JSON getPays:data];
        [self.tableView reloadData];
    }];
}
- (void)setNav
{
    [self resetTitleView:@"提交订单"];
    [self setBackItem:@selector(backPop)];
}

- (void)createSubmitButton
{
    UIView *bgView = [[UIView alloc] init];
    bgView.frame = CGRectMake(0, SELF_VIEW_HEIGHT - kBottomAreaHeight, SELF_VIEW_WIDTH, kBottomAreaHeight);
    bgView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:bgView];
    
    UIButton *submitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    submitBtn.frame = CGRectMake(5.0f, 20.0f, SELF_VIEW_WIDTH - 10.0f, 32.0f);
    submitBtn.layer.cornerRadius = 2.0f;
    submitBtn.backgroundColor = [UIColor colorWithRed:0.80f green:0.26f blue:0.23f alpha:1.00f];
    [submitBtn setTitle:@"提交订单" forState:UIControlStateNormal];
    [submitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    submitBtn.titleLabel.font = [UIFont boldSystemFontOfSize:15.0f];
    [submitBtn addTarget:self action:@selector(submitBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [bgView addSubview:submitBtn];
}



#pragma mark DatePicker

- (void)createDataPicker
{
    UIView *bgDatePickerView = [self createBgDatePickerView];
    
    UIDatePicker *datePicker = [[UIDatePicker alloc] init];
    datePicker.frame = CGRectMake(0,
                                  VIEW_HEIGHT(bgDatePickerView) - kDatePickerHeight,
                                  VIEW_WIDTH(bgDatePickerView),
                                  kDatePickerHeight);
    datePicker.backgroundColor = [UIColor whiteColor];
    datePicker.datePickerMode = UIDatePickerModeTime;
    datePicker.minimumDate = [NSDate date];
    [bgDatePickerView addSubview:datePicker];
    self.datePicker = datePicker;
    
    [self createConfirmButton:bgDatePickerView];
    
    bgDatePickerView.hidden = YES;
    self.bgDatePickerView = bgDatePickerView;
}

- (UIView *)createBgDatePickerView
{
    UIWindow *keyWindow = [[UIApplication sharedApplication] keyWindow];
    UIView *bgDatePickerView = [[UIView alloc] init];
    bgDatePickerView.frame = keyWindow.bounds;
    bgDatePickerView.backgroundColor = [UIColor colorWithWhite:0.0f alpha:0.4f];
    [keyWindow addSubview:bgDatePickerView];
    return bgDatePickerView;
}

- (void)createConfirmButton:(UIView *)bgDatePickerView
{
    UIToolbar *toolBar = [[UIToolbar alloc] init];
    toolBar.frame = CGRectMake(0,
                               VIEW_HEIGHT(bgDatePickerView) - kDatePickerHeight - 30.0f,
                               VIEW_WIDTH(bgDatePickerView),
                               30.0f);
    toolBar.tintColor = [UIColor orangeColor];
    toolBar.backgroundColor = [UIColor redColor];
    toolBar.barTintColor = [UIColor yellowColor];
    
    UIBarButtonItem *confirmBbi = [[UIBarButtonItem alloc] initWithTitle:@"确认 " style:UIBarButtonItemStyleDone target:self action:@selector(confirmBtnClick)];
    UIBarButtonItem *fixBbi = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:NULL];
    toolBar.items = @[fixBbi, confirmBbi];
    [bgDatePickerView addSubview:toolBar];
}

#pragma mark -
#pragma mark - tableView
- (void)createTableView
{
    CGRect frame = CGRectMake(0,
                              SELF_VIEW_ORIGIN_Y,
                              SELF_VIEW_WIDTH,
                              SELF_VIEW_HEIGHT - SELF_VIEW_ORIGIN_Y - kBottomAreaHeight);
    UITableView *orderTableView = [[UITableView alloc] initWithFrame:frame style:UITableViewStylePlain];
    orderTableView.contentInset = UIEdgeInsetsMake(4.0f, 0, 4.0f, 0);
    orderTableView.backgroundColor = [UIColor colorWithRed:0.93f green:0.93f blue:0.93f alpha:1.00f];
    orderTableView.showsVerticalScrollIndicator = NO;
    orderTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    orderTableView.dataSource = self;
    orderTableView.delegate = self;
    [self.view addSubview:orderTableView];
    if (IOS_VERSION >= 7.0f) {
        [orderTableView setSeparatorInset:UIEdgeInsetsZero];
    }
    UIView *emptyView = [[UIView alloc] init];
    [orderTableView setTableFooterView:emptyView];
    
    self.tableView = orderTableView;
}

#pragma mark - tableViewDataSource tableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 2) {
//        return self.peisongArr.count+1;
//    } else if (section == 4) {
        return self.payArr.count +1;
    }
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    if (0 == indexPath.section) {
//        return 98.0f;
//    } else if (1 == indexPath.section) {
//        return 51.0f;
//    } else if (2 == indexPath.section) {
//        return 180.0f;
//    } else {
//        return 30;
//    }
    
    if (0 == indexPath.section) {
        return 51.0f;
    } else if (1 == indexPath.section) {
        return 180.0f;
    } else {
        return 30;
    }
}

#pragma mark - cellForRow
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (10 == indexPath.section) {
        static NSString *cellName = @"SubmitFirstCell";
        SubmitFirstCell *cell = [tableView dequeueReusableCellWithIdentifier:cellName];
        if (nil == cell) {
            cell = [[SubmitFirstCell alloc] initWithStyle:UITableViewCellStyleDefault
                                          reuseIdentifier:cellName];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.priceLabel.text = @"";
        }
        cell.priceLabel.text = [NSString stringWithFormat:@"￥%.2f",self.cartInfo.totalPrice];
        cell.freightLabel.text = [NSString stringWithFormat:@"￥%.2f",self.restInfo.freight.floatValue];
        cell.tipLabel.text = [NSString stringWithFormat:@"￥%.2f",self.restInfo.xiaofei.floatValue];

        return cell;
    } else if (0 == indexPath.section) {
        static NSString *cellName = @"SubmitSecondCell";
        SubmitSecondCell *cell = [tableView dequeueReusableCellWithIdentifier:cellName];
        if (nil == cell) {
            cell = [[SubmitSecondCell alloc] initWithStyle:UITableViewCellStyleDefault
                                           reuseIdentifier:cellName];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
//        cell.totalLabel.text = [NSString stringWithFormat:@"$%.2f",self.cartInfo.totalPrice+self.restInfo.freight.floatValue+self.restInfo.xiaofei.floatValue];
        cell.totalLabel.text = [NSString stringWithFormat:@"￥%.2f",self.cartInfo.totalPrice];
        return cell;
    } else if (1 == indexPath.section) {
        static NSString *cellName = @"SubmitThirdCell";
        SubmitThirdCell *cell = [tableView dequeueReusableCellWithIdentifier:cellName];
        if (nil == cell) {
            cell = [[SubmitThirdCell alloc] initWithStyle:UITableViewCellStyleDefault
                                          reuseIdentifier:cellName];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            cell.nowButton.tag = TAG_MIN;
            cell.pickTimeButton.tag = TAG_MIN + 1;
            
            [cell.nowButton addTarget:self
                               action:@selector(choiceTimeBtnClick:)
                     forControlEvents:UIControlEventTouchUpInside];
            [cell.pickTimeButton addTarget:self
                                    action:@selector(choiceTimeBtnClick:)
                          forControlEvents:UIControlEventTouchUpInside];
            cell.dinersNuberTextField.delegate = self;
            cell.infoField.delegate = self;
            
        }
        cell.dinersNuberTextField.tag = 1000;
        cell.infoField.tag = 1001;
        cell.nowButton.indexPath = indexPath;
        cell.pickTimeButton.indexPath = indexPath;
        cell.timeLabel.text = [self getDate:self.datePicker.date];
        return cell;
    } else {
        static NSString *cellName = @"SubmitFourthCell";
        UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellName];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
            cell.textLabel.font = [UIFont systemFontOfSize:14];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        
        if (indexPath.row == 0) {
            cell.textLabel.text = @"请选择支付方式";
            cell.accessoryType = UITableViewCellAccessoryNone;
        } else {
            PayInfo * info = self.payArr[indexPath.row-1];
            cell.textLabel.text = info.payment_name;
            if (indexPath.row == payIndex) {
                cell.accessoryType = UITableViewCellAccessoryCheckmark;
            }
        }
//        SubmitFourthCell *cell = [tableView dequeueReusableCellWithIdentifier:cellName];
//        if (nil == cell) {
//            cell = [[SubmitFourthCell alloc] initWithStyle:UITableViewCellStyleDefault
//                                           reuseIdentifier:cellName];
//            cell.selectionStyle = UITableViewCellSelectionStyleNone;
//        }
        
        
        return cell;
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 2) {
        if (indexPath.row) {
            payIndex = indexPath.row;
            UITableViewCell * cell = [tableView cellForRowAtIndexPath:indexPath];
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
        }
    }
}
#pragma mark -
#pragma mark - 事件处理

#pragma mark - 提交订单
- (void)submitBtnClick
{
    if ([Public sharedPublic].userInfo.userID == nil) {
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"登陆后提交订单" message:nil delegate:self cancelButtonTitle:@"以后再说" otherButtonTitles:@"登陆注册", nil];
        [alert show];
        return;
    }
    if (!payIndex) {
        [SVProgressHUD showErrorWithStatus:@"请先选择支付方式"];
        return;
    }
    NSString * cartid = self.cartArr[0];
    if (self.cartArr.count > 1) {
        for (int i = 1; i < self.cartArr.count; i++) {
            cartid = [NSString stringWithFormat:@"%@,%@",cartid,self.cartArr[i]];
        }
    }
    PayInfo * info = self.payArr[payIndex-1];
    NSString * path = [NSString stringWithFormat:@"%@/add_order/cart_id/%@/payment_id/%@/shipping_id/1/address_id/%@/delivery_time/%@/number/%ld",DIANCAN_VIEW2,cartid,info.payment_id,[Public sharedPublic].addressInfo.addressID,[self getDate:self.datePicker.date],number];
    if (extension && extension.length) {
        path = [NSString stringWithFormat:@"%@/extension/%@",path,extension];
    }
  
    [GCDServer serverWithUrl:path complete:^(NSData * data) {
        OrderCenterViewController *ocVC = [[OrderCenterViewController alloc] init];
        ocVC.order_id = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        
        ocVC.number =[NSString stringWithFormat:@"%li",(long)number];
        ocVC.liuYan =extension;
        
        [self.navigationController pushViewController:ocVC animated:YES];
    }];
    
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        [self presentViewController:[[BaseNavigationController alloc] initWithRootViewController:[[LoginViewController alloc] init]] animated:YES completion:nil];
    }
}

#pragma mark 选取时间

- (void)choiceTimeBtnClick:(VCButton *)btn
{
    btn.selected = YES;
    UIButton *antherBtn = (UIButton *)[btn.superview viewWithTag:2 * TAG_MIN + 1 - btn.tag];
    if ([antherBtn isKindOfClass:[UIButton class]]) {
        antherBtn.selected = NO;
    }
    
    if (TAG_MIN + 1 == btn.tag) {
        self.bgDatePickerView.hidden = NO;
    } else {
        self.datePicker.date = [NSDate date];
    }
}

- (void)confirmBtnClick
{
    self.bgDatePickerView.hidden = YES;
    [self.tableView reloadData];
//    [self getDate:self.datePicker.date];
//    NSLog(@"current %@",[self getDate:self.datePicker.date]);
}
- (NSString *)getDate:(NSDate *)date
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"HH:mm"];
    return [dateFormatter stringFromDate:date];
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    LOG(@"The Return key pressed!");
    [textField resignFirstResponder];
    self.tableView.frame = CGRectMake(0,SELF_VIEW_ORIGIN_Y,SELF_VIEW_WIDTH,SELF_VIEW_HEIGHT - SELF_VIEW_ORIGIN_Y - kBottomAreaHeight);
    if (textField.tag == 1001) {
        extension = textField.text;
    } else {
        number = textField.text.integerValue == 0 ? 1 : textField.text.integerValue;
    }
    return YES;
}


#pragma mark -

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

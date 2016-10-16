//
//  MyCartViewController.m
//  FoodStore
//
//  Created by liuguopan on 15/6/17.
//  Copyright (c) 2015年 liuguopan. All rights reserved.
//

#import "MyCartViewController.h"
#import "CartCell.h"
#import "AddressViewController.h"
#define kBottomAreaHeight   75.0f
@interface MyCartViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UILabel *priceLabel;
@property (nonatomic, strong) UILabel *copiesLabel;

@property (nonatomic, strong) NSArray *testArray;

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, assign) BOOL isChanged;

@end

@implementation MyCartViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor colorWithRed:0.93f green:0.93f blue:0.93f alpha:1.00f];
    LOG(self.cartInfo.foodsArray);
    [self initData];
    [self setNav];
    [self createBottomView];
    [self createTableView];
    [self downloadData];
}

- (void)initData
{
    //    self.testArray = @[@[@"红酒蜂蜜鸡腿排/份", @"1", @"$5.0"],
    //                       @[@"法式芝心蓝莓猪排/份", @"1", @"$9.0"],
    //                       @[@"芝士龙利鱼/份", @"1", @"$6.0"],
    //                       @[@"征税", @"", @"$2.0"]];
    self.cartInfo = [[CartInfo alloc] init];
}


#pragma mark Download Data

- (void)downloadData
{
    self.cartInfo = nil;
    self.cartInfo = [[CartInfo alloc] init];
    NSString *url;
    if ([Public sharedPublic].userInfo.userID) {
        url = [NSString stringWithFormat:@"%@/user_id/%@/session_id/%@",DIANCAN_CAR,[Public sharedPublic].userInfo.userID,[Public getMac]];
    } else {
        url = [NSString stringWithFormat:@"%@/user_id/0/session_id/%@",DIANCAN_CAR,[Public getMac]];
    }
    [GCDServer serverWithUrl:url complete:^(NSData *data) {
        NSMutableArray * arr = [JSON getFoodsInShoppingCart:data];
        self.cartInfo.foodsArray = arr;
        if (!arr.count) {
            return;
        }
        CartFoodInfo * info0 = arr[0];
        self.cartInfo.userID = info0.userID;
        self.cartInfo.restaurID = info0.restaurID;
        for (CartFoodInfo * cfInfo in arr) {
            self.cartInfo.totalCopies += cfInfo.quantity.intValue;
            self.cartInfo.totalPrice += cfInfo.quantity.intValue * cfInfo.price.floatValue;
        }
        [self reloadView];
        
    } error:^(NSError *error) {
        
    }];
}
- (void)reloadView
{
    [self.tableView reloadData];
    [self bottomViewChanged];
}
- (void)setNav
{
    [self resetTitleView:@"购物车"];
    [self setSliderItem];
    
    //[self setBackItem:@selector(backPop)];
}

//- (void)backPop
//{
//    [self.navigationController popViewControllerAnimated:YES];
//    if (self.isChanged) {
//        [self.cartDelegate reloadView];
//    }
//}

- (void)createBottomView
{
    UIView *bgView = [[UIView alloc] init];
    bgView.frame = CGRectMake(0, SELF_VIEW_HEIGHT - kBottomAreaHeight, SELF_VIEW_WIDTH, kBottomAreaHeight);
    bgView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:bgView];
    
    UIButton *doneBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    doneBtn.frame = CGRectMake(5.0f, 33.0f, SELF_VIEW_WIDTH - 10.0f, 32.0f);
    doneBtn.layer.cornerRadius = 2.0f;
    doneBtn.backgroundColor = [UIColor colorWithRed:0.80f green:0.26f blue:0.23f alpha:1.00f];
    [doneBtn setTitle:@"确认美食" forState:UIControlStateNormal];
    [doneBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    doneBtn.titleLabel.font = [UIFont boldSystemFontOfSize:15.0f];
    [doneBtn addTarget:self action:@selector(doneBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [bgView addSubview:doneBtn];
    
    UILabel * min = [[UILabel alloc] initWithFrame:CGRectMake(30, 5, 150, 30)];
    min.text = [NSString stringWithFormat:@"起送价:￥%.2f",[Public sharedPublic].restInfo.minPrice.floatValue];
    min.backgroundColor = [UIColor clearColor];
    min.font = [UIFont systemFontOfSize:14.0f];
    [bgView addSubview:min];
    
    
    UILabel *priceLabel = [[UILabel alloc] init];
    priceLabel.frame = CGRectMake(SELF_VIEW_WIDTH - 75.0f, 5.0f, 75.0f, 20.0f);
    priceLabel.backgroundColor = [UIColor clearColor];
    priceLabel.text = [NSString stringWithFormat:@"￥%.2f", self.cartInfo.totalPrice];
    priceLabel.textColor = [UIColor redColor];
    priceLabel.font = [UIFont systemFontOfSize:14.0f];
    [bgView addSubview:priceLabel];
    self.priceLabel = priceLabel;
    
    UILabel *copiesLabel = [[UILabel alloc] init];
    copiesLabel.frame = CGRectMake(SELF_VIEW_WIDTH - 80.0f - 80.0f, 5.0f, 80.0f, 20.0f);
    copiesLabel.backgroundColor = [UIColor clearColor];
    copiesLabel.text = [NSString stringWithFormat:@"%d份美食", self.cartInfo ? self.cartInfo.totalCopies : 0];
    copiesLabel.textColor = [UIColor grayColor];
    copiesLabel.textAlignment = NSTextAlignmentRight;
    copiesLabel.font = [UIFont boldSystemFontOfSize:14.0f];
    [bgView addSubview:copiesLabel];
    self.copiesLabel = copiesLabel;
}

#pragma mark -
#pragma mark - tableView

- (void)createTableView
{
    CGRect frame = CGRectMake(5.0f,
                              SELF_VIEW_ORIGIN_Y,
                              SELF_VIEW_WIDTH - 10.0f,
                              SELF_VIEW_HEIGHT - SELF_VIEW_ORIGIN_Y - kBottomAreaHeight);
    UITableView *tableView = [[UITableView alloc] initWithFrame:frame style:UITableViewStylePlain];
    tableView.contentInset = UIEdgeInsetsMake(5.0f, 0, 5.0f, 0);
    tableView.backgroundColor = [UIColor clearColor];
    tableView.showsVerticalScrollIndicator = NO;
    tableView.contentSize = CGSizeMake(SELF_VIEW_WIDTH - 10.0f, 4 * 32.0f);
    if (IOS_VERSION >= 7.0f) {
        tableView.separatorInset = UIEdgeInsetsZero;
    }
    tableView.dataSource = self;
    tableView.delegate = self;
    [self.view addSubview:tableView];
    
    UIView *emptyView = [[UIView alloc] init];
    [tableView setTableFooterView:emptyView];
    
    self.tableView = tableView;
}

#pragma mark - tableViewDataSource tableViewDelegate
//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
//{
//    if (self.cartInfo && self.cartInfo.foodsArray.count) {
//        return 2;
//    }
//    return 0;
//}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //    if (self.cartInfo && self.cartInfo.foodsArray.count) {
    //        if (1 == section) {
    //            return 1;
    //        }
    //        return self.cartInfo.foodsArray.count;
    //    }
    if (self.cartInfo.foodsArray.count) {
        return self.cartInfo.foodsArray.count;
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 32.0f;
}


#pragma mark cellForRow

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellName = @"CartCell";
    CartCell *cell = [tableView dequeueReusableCellWithIdentifier:cellName];
    if (nil == cell) {
        cell = [[CartCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell.addButton addTarget:self
                           action:@selector(changeCopies:)
                 forControlEvents:UIControlEventTouchUpInside];
        [cell.minusButton addTarget:self
                             action:@selector(changeCopies:)
                   forControlEvents:UIControlEventTouchUpInside];
    }
    
    cell.addButton.indexPath = indexPath;
    cell.minusButton.indexPath = indexPath;
    cell.addButton.tag = TAG_MIN + 100;
    cell.minusButton.tag = TAG_MIN + 101;
    
    //    if (self.cartInfo.foodsArray.count == indexPath.row) {
    //        cell.copiesLabel.hidden = YES;
    //        cell.addButton.hidden = YES;
    //        cell.minusButton.hidden = YES;
    //        cell.nameLabel.textColor = [UIColor colorWithRed:0.99f green:0.42f blue:0.38f alpha:1.00f];
    //        cell.nameLabel.text = @"征税";
    //        cell.priceLabel.text = @"$2.0";
    //    } else {
    CartFoodInfo *food = self.cartInfo.foodsArray[indexPath.row];
    cell.copiesLabel.hidden = NO;
    cell.nameLabel.textColor = [UIColor blackColor];
    cell.nameLabel.text = [NSString stringWithFormat:@"%@/份", food.foodName];
    cell.copiesLabel.text = [NSString stringWithFormat:@"%d", food.quantity.intValue];
    cell.priceLabel.text = [NSString stringWithFormat:@"￥%@", food.price];
    //    }
    
    return cell;
}
//#pragma mark 获取FoodInfo对象
//
//- (CartFoodInfo *)getFoodInfo:(NSIndexPath *)indexPath
//{
//    if (self.cartInfo) {
//        return (CartFoodInfo *)[self.cartInfo.foodsArray objectAtIndex:indexPath.row];
//    }
//    return nil;
//}
//
//- (CartFoodInfo *)getFoodInfoWithButton:(VCButton *)btn
//{
//    if (self.cartInfo) {
//        return (CartFoodInfo *)[self.cartInfo.foodsArray objectAtIndex:btn.indexPath.row];
//    }
//    return nil;
//}


#pragma mark - 事件处理 -


#pragma mark 加/减美食份数

- (void)changeCopies:(VCButton *)btn
{
    //    self.isChanged = YES;
    
    CartFoodInfo *foodInfo = self.cartInfo.foodsArray[btn.indexPath.row];
    if (TAG_MIN + 100 == btn.tag) { //  加
        [self editCartWithId:foodInfo.carID num:(foodInfo.quantity.integerValue+1)];
        [self cartInfoChanged:foodInfo isAdd:YES];
        [self cartArrayWith:foodInfo isAdd:YES];
        [self.tableView reloadRowsAtIndexPaths:@[btn.indexPath]
                              withRowAnimation:UITableViewRowAnimationAutomatic];
    } else {    // 减
        if (foodInfo.quantity.integerValue == 1) {
            [self deleteWithId:foodInfo.carID];
        } else {
            [self editCartWithId:foodInfo.carID num:(foodInfo.quantity.integerValue-1)];
        }
        [self cartInfoChanged:foodInfo isAdd:NO];
        [self cartArrayWith:foodInfo isAdd:NO];
        [self.tableView reloadData];
    }
    [self bottomViewChanged];
}
- (void)editCartWithId:(NSString *)recid num:(int)num
{
    
    NSString * path = [NSString stringWithFormat:@"%@/editcar/rec_id/%@/quantity/%d",DIANCAN_VIEW1,recid,num];
    [GCDServer serverWithUrl:path complete:^(NSData * data) {
        NSDictionary * dict = [JSON jsonParse:data];
        if ([dict[@"status"] isEqualToNumber:@1]) {
            [SVProgressHUD showSuccessWithStatus:dict[@"msg"]];
            [self downloadData];
        } else {
            [SVProgressHUD showErrorWithStatus:dict[@"msg"]];
        }
    }];
}
- (void)deleteWithId:(NSString *)recid
{
    NSString * path = [NSString stringWithFormat:@"%@/delcar/rec_id/%@",DIANCAN_VIEW1,recid];
    [GCDServer serverWithUrl:path complete:^(NSData * data) {
        NSDictionary * dict = [JSON jsonParse:data];
        if ([dict[@"status"] isEqualToNumber:@1]) {
            [SVProgressHUD showSuccessWithStatus:dict[@"msg"]];
            [self downloadData];
        } else {
            [SVProgressHUD showErrorWithStatus:dict[@"msg"]];
        }
    }];
}


#pragma mark 改变cartInfo的总份数和总钱数

- (void)cartInfoChanged:(CartFoodInfo *)foodInfo isAdd:(BOOL)isAdd
{
    self.cartInfo.totalCopies = isAdd ?
    self.cartInfo.totalCopies + 1 :
    self.cartInfo.totalCopies - 1;
    
    self.cartInfo.totalPrice = isAdd ?
    self.cartInfo.totalPrice + foodInfo.price.floatValue :
    self.cartInfo.totalPrice - foodInfo.price.floatValue;
    
}

#pragma mark 遍历cartInfo的foodsArray，做相应的操作

- (void)cartArrayWith:(CartFoodInfo *)foodInfo isAdd:(BOOL)isAdd
{
    for (CartFoodInfo *food in self.cartInfo.foodsArray) {
        if ([foodInfo.foodID isEqualToString:food.foodID]) {
            //  对应FoodInfo对象份数+1/-1
            food.quantity = [NSString stringWithFormat:@"%d",(isAdd ? food.quantity.intValue + 1 : food.quantity.intValue -1)];
            if (0 == food.quantity.integerValue && !isAdd) {
                [self.cartInfo.foodsArray removeObject:food];
            }
            return;
        }
    }
}

#pragma mark 对底部的cartView的总份数总钱数的Label从新赋值

- (void)bottomViewChanged
{
    self.copiesLabel.text = [NSString stringWithFormat:@"%d份美食", self.cartInfo.totalCopies];
    self.priceLabel.text = [NSString stringWithFormat:@"￥%.2f", self.cartInfo.totalPrice];
    if (0 == self.cartInfo.totalCopies) {
        self.priceLabel.text = @"￥0";
    }
}


#pragma mark - 确认美食
- (void)doneBtnClick
{
    RestaurInfo * pinfo = [Public sharedPublic].restInfo;
    if (pinfo.minPrice.floatValue <= self.cartInfo.totalPrice) {
        [Public sharedPublic].cartInfo = self.cartInfo;
        AddressViewController *aVC = [[AddressViewController alloc] init];
        [self.navigationController pushViewController:aVC animated:YES];
    } else {
        NSString * path = [NSString stringWithFormat:@"你还差%.2f元满起送价",(pinfo.minPrice.floatValue - self.cartInfo.totalPrice)];
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:path message:nil delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
        [alert show];
    }
    
    
    
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

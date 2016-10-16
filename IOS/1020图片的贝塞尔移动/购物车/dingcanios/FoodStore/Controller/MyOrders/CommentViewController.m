//
//  CommentViewController.m
//  FoodStore
//
//  Created by ZhangShouC on 12/31/14.
//  Copyright (c) 2014 liuguopan. All rights reserved.
//

#import "CommentViewController.h"

@interface CommentViewController () <UITableViewDataSource,UITableViewDelegate>
{
    NSMutableArray * _dataArr;
    NSMutableArray * _answerArr;
    UIScrollView * _scrollView;
}
@property (nonatomic,strong) UITableView * tableView;
@end

@implementation CommentViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [self setNav];
    [self downloadData];
    [self initView];
    
}
- (void)downloadData
{
    _answerArr = [[NSMutableArray alloc] initWithCapacity:0];
    NSString * path = [NSString stringWithFormat:@"%@/order_goods/order_id/%@",DIANCAN_VIEW1,self.info.order_id];
    [GCDServer serverWithUrl:path complete:^(NSData * data) {
        NSMutableArray * arr = [JSON getOrder:data];
        if (arr.count) {
            _dataArr = arr;
            for (int i = 0; i <= arr.count; i++) {
                [_answerArr addObject:@"4"];
            }
            [_tableView reloadData];
        }
    }];
}
//

- (void)initView
{
    self.view.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1];
    [self setFooter];
    [self setTable];
}
- (void)setTable
{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(10, 70, 300, SELF_VIEW_HEIGHT-150) style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.showsHorizontalScrollIndicator = NO;
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.backgroundColor = [UIColor clearColor];
    [_tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    _tableView.tableFooterView = [[UIView alloc] init];
    [self.view addSubview:_tableView];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 110;
    } else {
        if (indexPath.row <= _dataArr.count) {
            return 30;
        } else {
            return 50;
        }
    }
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
    }
    return 2+_dataArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    static NSString *cellName = @"OrderCommentCell";
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellName];
//    if (nil == cell) {
//        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
//        cell.backgroundColor = [UIColor clearColor];
//        cell.selectionStyle = UITableViewCellSelectionStyleNone;
//    }
    static NSString *cellName = @"OrderCommentCell";
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
    cell.backgroundColor = [UIColor clearColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if (indexPath.section == 0) {
        cell.backgroundView = [self setHead];
    } else {
        cell.backgroundColor = [UIColor whiteColor];
        if (indexPath.row == 0) {
            cell.backgroundView = [self label];
        } else if (indexPath.row <= _dataArr.count) {
            [cell addSubview:[self starView:(indexPath.row-1)]];
        } else {
            [cell addSubview:[self allStarView]];
        }
    }
    
    
    return cell;
}

- (UIView *)setHead
{
    UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 300, 110)];
    
    UIView * head = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 300, 100)];
    head.backgroundColor = [UIColor whiteColor];
    [view addSubview:head];
    
    UILabel * lab1 = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 180, 44)];
    lab1.text = [NSString stringWithFormat:@"订单号: %@", self.info.order_sn];
    lab1.font = [UIFont systemFontOfSize:16];
    [head addSubview:lab1];
    
    UILabel * lab2 = [[UILabel alloc] initWithFrame:CGRectMake(190, 0, 120, 44)];
    lab2.text = @"订单状态: 已完成";
    lab2.font = [UIFont systemFontOfSize:14];
    [head addSubview:lab2];
    
    UIView * line = [[UIView alloc] initWithFrame:CGRectMake(0, 44, 300, 1)];
    line.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1];
    [head addSubview:line];
    
    UILabel * lab3 = [[UILabel alloc] initWithFrame:CGRectMake(10, 45, 280, 27)];
    lab3.text = [NSString stringWithFormat:@"订餐时间 : %@", self.info.add_time];
    lab3.font = [UIFont systemFontOfSize:16];
    [head addSubview:lab3];
    
    UILabel * lab4 = [[UILabel alloc] initWithFrame:CGRectMake(10, 72, 280, 27)];
    lab4.text = [NSString stringWithFormat:@"餐厅名称 : %@", self.info.restaurName];
    lab4.font = [UIFont systemFontOfSize:16];
    [head addSubview:lab4];
    
    return view;
}
- (UIView *)label
{
    UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 300, 30)];
    
    UILabel * lab = [[UILabel alloc] initWithFrame:CGRectMake(200, 0, 80, 30)];
    lab.text = @"评价";
    lab.textAlignment = NSTextAlignmentRight;
    lab.font = [UIFont systemFontOfSize:18];
    [view addSubview:lab];
    
    return view;
}
- (UIView *)starView:(NSInteger)index
{
    UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 300, 30)];
    
    UILabel * lab =[[UILabel alloc] initWithFrame:CGRectMake(10, 5, 120, 20)];
    lab.font = [UIFont systemFontOfSize:16];
    [view addSubview:lab];

    if (index < _dataArr.count) {
        CartFoodInfo * info = _dataArr[index];
        lab.text = info.foodName;
        lab.textColor = [UIColor blackColor];
    } else {
        lab.text = @"餐厅整体评价";
        lab.textColor = [UIColor redColor];
    }
    
    for (int i = 0; i < 5; i++) {
        UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(150+25*i, 5, 20, 20);
        button.tag = 100*index + i +1;
        if (index == _dataArr.count) {
            button.tag = 100*_dataArr.count+i +1;
        }
        [button setImage:[UIImage imageNamed:(i < 4 ? @"star_selected" : @"star_unselected")] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(starClick:) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:button];
    }

    
    return view;
}
- (UIView *)allStarView
{
    UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 300, 50)];
    
    UIView * line = [[UIView alloc] initWithFrame:CGRectMake(0, 2, 300, 1)];
    line.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1];
    [view addSubview:line];
    
    UIView * star = [[UIView alloc] initWithFrame:CGRectMake(0, 10, 300, 30)];
    [star addSubview:[self starView:_dataArr.count]];
    [view addSubview:star];
    
    return view;
}
- (void)starClick:(UIButton *)button
{
    NSInteger row = button.tag/100;
    NSInteger index = button.tag - 100*row-1;
    NSLog(@"index==%d,row==%d",index,row);
    NSString * str = [NSString stringWithFormat:@"%d",index+1];
    if ([_answerArr[row] isEqualToString:str]) {
        return;
    }
    [_answerArr replaceObjectAtIndex:row withObject:str];
    for (NSInteger i = 0; i <= index; i++) {
        UIButton * btn = (UIButton *)[self.view viewWithTag:100*row+i+1];
        [btn setImage:[UIImage imageNamed:@"star_selected"] forState:UIControlStateNormal];
    }
    for (NSInteger i = index+1; i < 5; i++) {
        UIButton * btn = (UIButton *)[self.view viewWithTag:100*row+i+1];
        [btn setImage:[UIImage imageNamed:@"star_unselected"] forState:UIControlStateNormal];
    }
}
- (void)setFooter
{
    UILabel * loginLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, SELF_VIEW_HEIGHT-80, 300, 40)];
    loginLabel.text = @"提交评价";
    loginLabel.textColor = [UIColor whiteColor];
    loginLabel.backgroundColor = [UIColor colorWithRed:0.80f green:0.26f blue:0.23f alpha:1.00f];
    loginLabel.textAlignment = NSTextAlignmentCenter;
    loginLabel.font = [UIFont systemFontOfSize:20];
    [self.view addSubview:loginLabel];
    loginLabel.userInteractionEnabled = YES;
    UITapGestureRecognizer * loginTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(uploadClick)];
    [loginLabel addGestureRecognizer:loginTap];
}
- (void)uploadClick
{
//    LOG_METHOD;
    for (int i = 0; i < _answerArr.count; i++) {
        NSString * path;
        if (i == _answerArr.count-1) {
            path = [NSString stringWithFormat:@"%@/add_comment/comment_type/1/id_value/%@/user_id/%@/content/12345/comment_rank/%@",DIANCAN_VIEW1,_info.restaurID,[Public sharedPublic].userInfo.userID,_answerArr[i]];
        } else {
            CartFoodInfo * info = _dataArr[i];
            path = [NSString stringWithFormat:@"%@/add_comment/comment_type/2/id_value/%@/user_id/%@/content/12345/comment_rank/%@",DIANCAN_VIEW1,info.foodID,[Public sharedPublic].userInfo.userID,_answerArr[i]];
        }
        [GCDServer serverWithUrl:path complete:^(NSData * data) {
            NSDictionary * dict = [JSON jsonParse:data];
            if ([dict[@"status"] isEqualToNumber:@1]) {
                [SVProgressHUD showSuccessWithStatus:dict[@"msg"]];
            } else {
                [SVProgressHUD showErrorWithStatus:dict[@"msg"]];
            }
        }];
    }
    
}
- (void)setNav
{
    [self resetTitleView:@"评价"];
    [self setBackItem:@selector(backPop)];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

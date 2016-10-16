//
//  AddressViewController.m
//  FoodStore
//
//  Created by liuguopan on 14/12/25.
//  Copyright (c) 2014年 viewcreator3d. All rights reserved.
//

#import "AddressViewController.h"
#import "AddAddressViewController.h"
#import "SubmitViewController.h"
#import "AddressCell.h"

#define kBottomAreaHeight   70.0f

@interface AddressViewController ()
<UITableViewDataSource, UITableViewDelegate, UIAlertViewDelegate>
{
    NSInteger _select;
}
@property (nonatomic,strong) NSMutableArray * dataArr;
@property (nonatomic, strong) UITableView *addressTableView;
@property (nonatomic,strong) UserInfo * info;
@property (nonatomic, strong) AddressCell *lastSelectedCell;

@end

@implementation AddressViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self initArr];
    NSLog(@"%@",[Public sharedPublic].addressInfo.name);
}
- (void)initArr
{
    NSString * path = [NSString stringWithFormat:@"%@/userid/%@",DIANCAN_ADDRESS,_info.userID];
    [GCDServer serverWithUrl:path complete:^(NSData * data) {
        NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        if ([dict[@"status"] isEqualToNumber:@1]) {
            [_dataArr removeAllObjects];
            for (NSDictionary * dic in dict[@"info"]) {
                AddressInfo * info = [[AddressInfo alloc] init];
                info.addressID = dic[@"id"];
                info.name = dic[@"consignee"];
                info.userID = dic[@"user_id"];
                info.address = dic[@"address"];
                info.tel = dic[@"phone_tel"];
                [_dataArr addObject:info];
            }
            [_addressTableView reloadData];
        }
    }];

}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor colorWithRed:0.93f green:0.93f blue:0.93f alpha:1.00f];
    [self setNav];
    [self initData];
    [self createNextButton];
    [self createTableView];
}
- (void)initData
{
    _dataArr = [[NSMutableArray alloc] initWithCapacity:0];
    _info = [Public sharedPublic].userInfo;
}
- (void)setNav
{
    [self resetTitleView:@"送餐地址"];
    [self setBackItem:@selector(backPop)];
    [self setRightItem:@"新增" sel:@selector(addAddress)];
}
- (void)backPop
{
    [Public sharedPublic].addressInfo = nil;
    [super backPop];
}
- (void)createNextButton
{
    UIView *bgView = [[UIView alloc] init];
    bgView.frame = CGRectMake(0, SELF_VIEW_HEIGHT - kBottomAreaHeight, SELF_VIEW_WIDTH, kBottomAreaHeight);
    bgView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:bgView];
    
    UIButton *nextBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    nextBtn.frame = CGRectMake(5.0f, 20.0f, SELF_VIEW_WIDTH - 10.0f, 32.0f);
    nextBtn.layer.cornerRadius = 2.0f;
    nextBtn.backgroundColor = [UIColor colorWithRed:0.80f green:0.26f blue:0.23f alpha:1.00f];
    [nextBtn setTitle:@"下一步" forState:UIControlStateNormal];
    [nextBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    nextBtn.titleLabel.font = [UIFont boldSystemFontOfSize:15.0f];
    [nextBtn addTarget:self
                action:@selector(nextBtnClick)
                forControlEvents:UIControlEventTouchUpInside];
    [bgView addSubview:nextBtn];
}

#pragma mark - 
#pragma mark - tableView
- (void)createTableView
{
    CGRect frame = CGRectMake(5.0f,
                              SELF_VIEW_ORIGIN_Y,
                              SELF_VIEW_WIDTH - 10.0f,
                              SELF_VIEW_HEIGHT - SELF_VIEW_ORIGIN_Y - kBottomAreaHeight);
    UITableView *addressTableView = [[UITableView alloc] initWithFrame:frame
                                                                 style:UITableViewStylePlain];
    addressTableView.contentInset = UIEdgeInsetsMake(5.0f, 0, 5.0f, 0);
    addressTableView.backgroundColor = [UIColor clearColor];
    addressTableView.showsVerticalScrollIndicator = NO;
    if (IOS_VERSION >= 7.0f) {
        addressTableView.separatorInset = UIEdgeInsetsZero;
    }
    addressTableView.dataSource = self;
    addressTableView.delegate = self;
    [self.view addSubview:addressTableView];
    
    UILabel *headerLabel = [[UILabel alloc] init];
    headerLabel.frame = CGRectMake(0, 0, SELF_VIEW_WIDTH, 25.0f);
    headerLabel.text = @"长按地址可以编辑和删除";
    headerLabel.textColor = [UIColor grayColor];
    headerLabel.font = [UIFont systemFontOfSize:11.0f];
    [addressTableView setTableHeaderView:headerLabel];
    
    UIView *emptyView = [[UIView alloc] init];
    [addressTableView setTableFooterView:emptyView];
    
    //  长按手势
    UILongPressGestureRecognizer *lpgr = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressAction:)];
    lpgr.minimumPressDuration = 0.8f;
    [addressTableView addGestureRecognizer:lpgr];
    
    self.addressTableView = addressTableView;
}

#pragma mark - tableViewDataSource tableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 45.0f;
}

#pragma mark - cellForRow
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellName = @"AddressCell";
    AddressCell *cell = [tableView dequeueReusableCellWithIdentifier:cellName];
    if (nil == cell) {
        cell = [[AddressCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;

    }

    AddressInfo * info = _dataArr[indexPath.row];
    cell.addressLabel.text = info.address;
    cell.telLabel.text = info.tel;

    return cell;
}

#pragma mark - 事件处理 -


#pragma mark cellSelected

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.lastSelectedCell) {
        self.lastSelectedCell.accessoryType = UITableViewCellAccessoryNone;
    }
    AddressCell *cell = (AddressCell *)[tableView cellForRowAtIndexPath:indexPath];
    cell.accessoryType = UITableViewCellAccessoryCheckmark;
    self.lastSelectedCell = cell;
    [Public sharedPublic].addressInfo = _dataArr[indexPath.row];
    NSLog(@"%@",[Public sharedPublic].addressInfo.name);
}

#pragma mark 长按手势
- (void)longPressAction:(UILongPressGestureRecognizer *)lpgr
{
    if (lpgr.state == UIGestureRecognizerStateBegan) {
        CGPoint point = [lpgr locationInView:self.addressTableView];
        LOG_FORMAT(@"long press at point %f %f", point.x, point.x);
        NSIndexPath *indexPath = [self.addressTableView indexPathForRowAtPoint:point];
        if (indexPath) {
            _select = indexPath.row;
            LOG_FORMAT(@"index path %d %d", indexPath.section, indexPath.row);
            if (IOS_VERSION >= 8.0f) {
                
            } else {
                
            }
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"编辑或删除当前地址"
                                                                message:nil
                                                               delegate:self
                                                      cancelButtonTitle:@"取消"
                                                      otherButtonTitles:@"编辑", @"删除", nil];
            alertView.tag = TAG_MIN;
            [alertView show];
            
        }
    }
}

#pragma mark - 下一步
- (void)nextBtnClick
{
    if (![Public sharedPublic].addressInfo) {
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"请先选择或添加送餐地址信息" message:nil delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
        [alert show];
        return;
    }
    SubmitViewController *sVC = [[SubmitViewController alloc] init];
    [self.navigationController pushViewController:sVC animated:YES];
}

#pragma mark - 新增地址
- (void)addAddress
{
    AddAddressViewController * add = [[AddAddressViewController alloc] init];
    [self.navigationController pushViewController:add animated:YES];
}



- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (TAG_MIN == alertView.tag) {
        AddressInfo * info = _dataArr[_select];
        //  提示编辑或删除
        if (1 == buttonIndex) {         //  编辑
//            UIAlertView *editAlert = [[UIAlertView alloc] initWithTitle:@"编辑"
//                                                                message:nil
//                                                               delegate:self
//                                                      cancelButtonTitle:@"放弃修改"
//                                                      otherButtonTitles:@"保存修改", nil];
//            editAlert.tag = TAG_MIN + 1;
//            editAlert.alertViewStyle = UIAlertViewStyleLoginAndPasswordInput;
//            
//            UITextField *address = [editAlert textFieldAtIndex:0];
//            address.placeholder = @"地址";
//            address.text = @"微斯特尔德伦购物中心";
//            
//            UITextField *tel = [editAlert textFieldAtIndex:1];
//            tel.secureTextEntry = NO;
//            tel.placeholder = @"电话";
//            tel.text = @"18663495673";
//            [editAlert show];
            
            AddAddressViewController * add = [[AddAddressViewController alloc] init];
            [add dataWithInfo:info];
            [self.navigationController pushViewController:add animated:YES];
            
            
            
        } else if (2 == buttonIndex) {  //  删除
            
            NSString * path = [NSString stringWithFormat:@"%@/id/%@",DIANCAN_DEL_ADDR,info.addressID];
            [GCDServer serverWithUrl:path complete:^(NSData * data) {
                NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
                LOG(dict[@"msg"]);
                if ([dict[@"status"] isEqualToNumber:@1]) {
                    [_dataArr removeObjectAtIndex:_select];
                    [_addressTableView reloadData];
                }
            }];
            
            
            
        }
    }
//    else if (TAG_MIN + 1 == alertView.tag) {  //  编辑地址和电话
//        
//        if (1 == buttonIndex) {     //  保存修改
//            UITextField *address = [alertView textFieldAtIndex:0];
//            LOG(address.text);
//            UITextField *tel = [alertView textFieldAtIndex:1];
//            LOG(tel.text);
//        }
//    } else {
//        
//    }
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

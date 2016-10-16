//
//  AddressEditViewController.m
//  FoodStore
//
//  Created by ZhangShouC on 12/29/14.
//  Copyright (c) 2014 liuguopan. All rights reserved.
//

#import "AddressEditViewController.h"
#import "AddAddressViewController.h"
@interface AddressEditViewController () <UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate>
{
    UITableView * _tableView;
    NSInteger _select;
    
}
@property (nonatomic,strong) NSMutableArray * dataArr;
@property (nonatomic,strong) UserInfo * info;
@end

@implementation AddressEditViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self initArr];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [self setNav];
    [self initData];
    [self initView];
}
- (void)initData
{
    _info = [Public sharedPublic].userInfo;
    _dataArr = [[NSMutableArray alloc] initWithCapacity:0];
}
- (void)initArr
{
    NSString * path = [NSString stringWithFormat:@"%@/userid/%@",DIANCAN_ADDRESS,_info.userID];
    [SVProgressHUD show];
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
            [SVProgressHUD dismiss];
            [_tableView reloadData];
        }
    }];
    
}
- (void)initView
{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(10, 10, 300, SELF_VIEW_HEIGHT) style:UITableViewStylePlain];
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
    return 60;
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
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellId];
    }
    AddressInfo * info = _dataArr[indexPath.row];
    cell.textLabel.text = info.address;
    cell.detailTextLabel.text = info.tel;
    cell.detailTextLabel.font = [UIFont systemFontOfSize:16];
    cell.backgroundColor = [UIColor whiteColor];
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    _select = indexPath.row;
    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"地址编辑" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"修改",@"删除", nil];
    [alert show];
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    AddressInfo * info = _dataArr[_select];
    if (buttonIndex == 1) {
        AddAddressViewController * add = [[AddAddressViewController alloc] init];
        [add dataWithInfo:info];
        [self.navigationController pushViewController:add animated:YES];
        
    } else if (buttonIndex == 2) {
        NSString * path = [NSString stringWithFormat:@"%@/id/%@",DIANCAN_DEL_ADDR,info.addressID];
        [GCDServer serverWithUrl:path complete:^(NSData * data) {
            
            NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            LOG(dict[@"msg"]);
            if ([dict[@"status"] isEqualToNumber:@1]) {
                [SVProgressHUD showSuccessWithStatus:dict[@"msg"]];
                [_dataArr removeObjectAtIndex:_select];
                [_tableView reloadData];
            } else {
                [SVProgressHUD showErrorWithStatus:dict[@"msg"]];
            }
        }];
    }

}
- (void)setNav
{
    [self resetTitleView:@"地址管理"];
    [self setBackItem:@selector(backPop)];
    [self setRightItem:@"新增" sel:@selector(addClick)];
    
    self.view.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1];
}
- (void)addClick
{
    [self.navigationController pushViewController:[[AddAddressViewController alloc] init] animated:YES];
    
}
- (void)delet
{
    /*
     //            UIAlertView * edit = [[UIAlertView alloc] initWithTitle:@"编辑" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
     //            edit.tag = 11;
     //            edit.alertViewStyle = UIAlertViewStyleLoginAndPasswordInput;
     //            UITextField * addr = [edit textFieldAtIndex:0];
     //            addr.placeholder = @"addr";
     //            addr.text = alertView.title;
     //
     //            UITextField * tel = [edit textFieldAtIndex:1];
     //            tel.secureTextEntry = NO;
     //            tel.placeholder = @"tel";
     //            tel.text = alertView.message;
     //            
     //            [edit show];
     */
    
    /*
     //    } else if (alertView.tag == 11) {
     //        if (buttonIndex) {
     ////            修改
     //            UITextField * addr = [alertView textFieldAtIndex:0];
     //            UITextField * tel = [alertView textFieldAtIndex:1];
     //            if (addr.text.length && tel.text.length && tel.text.length <= 11) {
     //                AddressInfo * info = _dataArr[_select];
     //                NSString * path = [NSString stringWithFormat:@"%@/id/%@/address/%@/phone_tel/%@",DIANCAN_EDIT_ADDR,info.addressID,addr.text,tel.text];
     //                [GCDServer serverWithUrl:path complete:^(NSData * data) {
     //                    NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
     //                    LOG(dict[@"msg"]);
     //                    if ([dict[@"status"] isEqualToNumber:@1]) {
     //
     ////                        [self initArr];
     //                        info.address = addr.text;
     //                        info.tel = tel.text;
     //                        [_dataArr replaceObjectAtIndex:_select withObject:info];
     //                        [_tableView reloadData];
     //
     //                    }
     //                }];
     //
     //            }
     //        }
     */
    
    /*
     //    else if (alertView.tag == 100) {
     //        NSLog(@"%d",buttonIndex);
     //        if (buttonIndex) {
     //            UITextField * addr = [alertView textFieldAtIndex:0];
     //            UITextField * tel = [alertView textFieldAtIndex:1];
     //            NSLog(@"%d",tel.text.length);
     //            if (addr.text.length && tel.text.length && tel.text.length <= 11) {
     //
     //                NSString * path = [NSString stringWithFormat:@"%@/userid/%@",DIANCAN_DEL_ADDR,_info.userID];
     //                [GCDServer serverWithUrl:path complete:^(NSData * data) {
     //                    NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
     //                    LOG(dict[@"msg"]);
     //                    if (![dict[@"status"] isEqualToNumber:@0]) {
     //
     //                        [self initArr];
     //                    }
     //                }];
     //            }
     //        }
     //        
     //    }
     */
    
    //    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"新增地址" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    //    alert.tag = 100;
    //    alert.alertViewStyle = UIAlertViewStyleLoginAndPasswordInput;
    //    UITextField * addr = [alert textFieldAtIndex:0];
    //    addr.placeholder = @"addr";
    //
    //    UITextField * tel = [alert textFieldAtIndex:1];
    //    tel.secureTextEntry = NO;
    //    tel.placeholder = @"tel";
    //    
    //    [alert show];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

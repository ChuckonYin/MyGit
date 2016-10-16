//
//  AddAddressViewController.m
//  FoodStore
//
//  Created by liuguopan on 14/12/25.
//  Copyright (c) 2014年 viewcreator3d. All rights reserved.
//

#import "AddAddressViewController.h"

@interface AddAddressViewController () <UITextFieldDelegate>
{
    UITextField * _old;
    UITextField * _new;
    UITextField * _again;
    NSString * path;
    AddressInfo * _info;
}
@end

@implementation AddAddressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setNav];
    [self initView];
}
- (void)viewWillAppear:(BOOL)animated
{
    if (_info) {
        _old.text = _info.name;
        _new.text = _info.address;
        _again.text = _info.tel;
        [self resetTitleView:@"地址修改"];
    }
}
- (void)initView
{
    _old = [[UITextField alloc] initWithFrame:CGRectMake(10, 80, 300, 40)];
    _old.placeholder = @"订餐人姓名(必填)";
    _old.delegate = self;
    _old.backgroundColor = [UIColor whiteColor];
    _old.borderStyle = UITextBorderStyleRoundedRect;
    _old.secureTextEntry = NO;
    _old.returnKeyType = UIReturnKeyDone;
    _old.clearButtonMode = UITextFieldViewModeWhileEditing;
    [self.view addSubview:_old];
    
    _new = [[UITextField alloc] initWithFrame:CGRectMake(10, 123, 300, 40)];
    _new.placeholder = @"送餐地址(必填)";
    _new.delegate = self;
    _new.backgroundColor = [UIColor whiteColor];
    _new.borderStyle = UITextBorderStyleRoundedRect;
    _new.secureTextEntry = NO;
    _new.returnKeyType = UIReturnKeyDone;
    _new.clearButtonMode = UITextFieldViewModeWhileEditing;
    [self.view addSubview:_new];
    
    _again = [[UITextField alloc] initWithFrame:CGRectMake(10, 166, 300, 40)];
    _again.placeholder = @"订餐人联系电话(必填)";
    _again.delegate = self;
    _again.backgroundColor = [UIColor whiteColor];
    _again.borderStyle = UITextBorderStyleRoundedRect;
    _again.secureTextEntry = NO;
    _again.returnKeyType = UIReturnKeyDone;
    _again.clearButtonMode = UITextFieldViewModeWhileEditing;
    [self.view addSubview:_again];
    
    UILabel * loginLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 225, 300, 50)];
    loginLabel.text = @"确认";
    loginLabel.textColor = [UIColor whiteColor];
    loginLabel.backgroundColor = [UIColor colorWithRed:0.80f green:0.26f blue:0.23f alpha:1.00f];;
    loginLabel.textAlignment = NSTextAlignmentCenter;
    loginLabel.font = [UIFont systemFontOfSize:20];
    [self.view addSubview:loginLabel];
    loginLabel.userInteractionEnabled = YES;
    UITapGestureRecognizer * loginTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(changeClick)];
    [loginLabel addGestureRecognizer:loginTap];
}
- (void)changeClick
{
    [_old resignFirstResponder];
    [_new resignFirstResponder];
    [_again resignFirstResponder];
    
    if (_old.text.length && _new.text.length && _again.text.length) {
        [self loadData];
    }
    
    
}
- (void)dataWithInfo:(AddressInfo *)info
{
    _info = info;
}

- (void)loadData
{
    [SVProgressHUD show];
    UserInfo * info = [Public sharedPublic].userInfo;
    if (_info) {
        path = [NSString stringWithFormat:@"%@/id/%@/consignee/%@/address/%@/phone_tel/%@",DIANCAN_EDIT_ADDR,_info.addressID,_old.text,_new.text,_again.text];
    } else {
        path = [NSString stringWithFormat:@"%@/user_id/%@/consignee/%@/address/%@/phone_tel/%@",DIANCAN_EDIT_ADDR,info.userID,_old.text,_new.text,_again.text];
    }
    
    
    [GCDServer serverWithUrl:path complete:^(NSData * data) {
        NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        
        if ([dict[@"status"] isEqualToNumber:@1]) {
            [SVProgressHUD showSuccessWithStatus:dict[@"msg"]];
        } else {
            [SVProgressHUD showErrorWithStatus:dict[@"msg"]];
        }
    }];

}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (void)setNav
{
    [self resetTitleView:@"新增地址"];
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

//
//  ViewController.m
//  16_05_12登陆输入框优化
//
//  Created by ChuckonYin on 16/5/12.
//  Copyright © 2016年 pinAn.com. All rights reserved.
//

#import "ViewController.h"
#import "YZTAnimateTextField.h"
#import "Masonry.h"
#import "AppDelegate.h"
#import "ViewController1.h"

@interface ViewController ()<UIScrollViewDelegate, UITextFieldDelegate>

@property (nonatomic, strong) YZTAnimateTextField *accountTextField;

@property (nonatomic, strong) YZTAnimateTextField *passwordTextField;

@property (nonatomic, strong) UIScrollView *mainScrollView;

@property (nonatomic, strong) UIView *mainContentView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
//    self.navigationController.navigationBar.translucent = NO;
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(push)];
    
    [self.view addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(yzt_stopAllEditing)]];;
    
    [self.view addSubview:self.mainScrollView];
    [self.mainScrollView addSubview:self.mainContentView];
    [self.mainContentView addSubview:self.accountTextField];
    [self.mainContentView addSubview:self.passwordTextField];
    __unsafe_unretained ViewController *weakSelf = self;
    [self.mainScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf.view);
    }];
    [self.mainContentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf.mainScrollView);
        make.size.mas_equalTo(CGSizeMake(weakSelf.view.frame.size.width, 600));
    }];
    [self.accountTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.mainContentView).offset(20);
        make.right.equalTo(weakSelf.mainContentView).offset(-20);
        make.top.equalTo(weakSelf.mainContentView).offset(150);
        make.height.mas_equalTo(58);
    }];
    [self.passwordTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.mainContentView).offset(20);
        make.right.equalTo(weakSelf.mainContentView).offset(-20);
        make.top.equalTo(weakSelf.mainContentView).offset(220);
        make.height.mas_equalTo(58);
    }];
}

- (void)viewWillDisappear:(BOOL)animated{
    [_accountTextField resignFirstResponder];
    [_passwordTextField resignFirstResponder];
    [self yzt_stopAllEditing];
}

- (void)yzt_stopAllEditing{
    if ([_accountTextField.textField isFirstResponder]) {
        [_accountTextField.textField resignFirstResponder];
    }
    if ([_passwordTextField.textField isFirstResponder]) {
        [_passwordTextField.textField resignFirstResponder];
    }
    [_mainScrollView setContentOffset:CGPointMake(0, 0) animated:YES];
    [self.view becomeFirstResponder];
}

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    CGPoint p = CGPointZero;
    p = [_passwordTextField convertPoint:CGPointMake(0, 58) toView:[self appWindow]];
    CGFloat needOffY = 300 - ([[UIScreen mainScreen] bounds].size.height - p.y);
    if (needOffY>0){
        [self.mainScrollView setContentOffset:CGPointMake(0, needOffY) animated:YES];
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    if (![_accountTextField.textField isFirstResponder] && ![_passwordTextField.textField isFirstResponder]) {
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (scrollView.isDragging) {
        [self yzt_stopAllEditing];
    }
}

- (void)push{
    [self.navigationController pushViewController:[ViewController1 new] animated:YES];
}

#pragma mark - set & get

- (YZTAnimateTextField *)accountTextField{
    if (!_accountTextField) {
        _accountTextField = [[YZTAnimateTextField alloc] initWithNormalPlaceholder:@"用户名/手机号/身份证号" delegate:self];
        _accountTextField.delegate = self;
    }
    return _accountTextField;
}

- (YZTAnimateTextField *)passwordTextField{
    if (!_passwordTextField) {
        _passwordTextField = [[YZTAnimateTextField alloc] initWithNormalPlaceholder:@"请输入登录密码" delegate:self];
        _passwordTextField.delegate = self;
    }
    return _passwordTextField;
}
//
- (UIScrollView *)mainScrollView{
    if (!_mainScrollView) {
        _mainScrollView = [[UIScrollView alloc] init];
        _mainScrollView.delegate = self;
        _mainScrollView.contentOffset = CGPointMake(0, 0);
    }
    return _mainScrollView;
}

- (UIView *)mainContentView{
    if (!_mainContentView) {
        _mainContentView = [[UIView alloc] init];
    }
    return _mainContentView;
}

- (UIWindow *)appWindow{
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    return appDelegate.window;
}


@end
















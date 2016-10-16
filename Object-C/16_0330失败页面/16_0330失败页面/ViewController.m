//
//  ViewController.m
//  16_0330失败页面
//
//  Created by ChuckonYin on 16/3/30.
//  Copyright © 2016年 PingAn. All rights reserved.
//

#import "ViewController.h"
#import "UIScrollView+YZTNetFailed.h"

@interface ViewController ()<YZTNetFailedViewDelegate, YZTNetFailedViewSource, UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"一账通失败页面";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"进入失败页面" style:0 target:self action:@selector(intoFailedView)];
    self.navigationController.navigationBar.translucent = NO;
    
    [self.view addSubview:self.tableView];
//    [self.tableView yzt_showFailedView];
}

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.contentSize = CGSizeMake(0, 700);
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.netFailedDelegate = self;
        _tableView.netFailedSource = self;
    }
    return _tableView;
}

#pragma mark - dataSource


#pragma mark - YZTNetFailedViewDelegate

- (void)yzt_netFailedView:(UIScrollView *)scrollView didTapView:(UIView *)view{
    NSLog(@"点击失败页");
}

- (void)yzt_netFailedView:(UIScrollView *)scrollView didTapButton:(UIButton *)button{
    NSLog(@"点击按钮");
    [self.tableView yzt_hideFailedView];
}

#pragma mark - response

- (void)intoFailedView{
    [self.tableView yzt_showFailedView];
    [self.tableView reloadData];
}

#pragma mark - UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return tableView.isFailedViewShow?0:10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 70;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellid = @"cellid";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
    }
    cell.backgroundColor = [UIColor colorWithRed:(CGFloat)(arc4random()%10)/10.0 green:(CGFloat)(arc4random()%10)/10.0  blue:(CGFloat)(arc4random()%10)/10.0  alpha:1];
    return cell;
}


@end






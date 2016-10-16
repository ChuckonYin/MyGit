//
//  ViewController.m
//  2016_0224YZTRefresh
//
//  Created by ChuckonYin on 16/2/24.
//  Copyright © 2016年 PingAn. All rights reserved.
//

#import "ViewController.h"
#import "UIScrollView+YZTRefresh.h"
#import "YZTRefreshNormalHeader.h"

@interface ViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
    
    self.navigationController.navigationBar.translucent = NO;
    
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 80, 0);
    
}

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView yzt_addHeaderWithTarget:self action:@selector(loadData)];
//        _tableView.mj_header = [[YZTRefreshNormalHeader alloc] init];
//        [_tableView yzt_setHeaderRefreshingTextColorWhite:YES];
//        [_tableView yzt_setRefreshingArrowColorWhite:YES];
        [_tableView yzt_addFooterWithTarget:self action:@selector(loadData)];
    }
    return _tableView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [[UITableViewCell alloc] init];
}

- (void)loadData{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.tableView yzt_headerEndRefreshing];
        [self.tableView yzt_footerEndRefreshing];
    });
}

@end

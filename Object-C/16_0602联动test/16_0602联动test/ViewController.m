//
//  ViewController.m
//  16_0602联动test
//
//  Created by apple on 16/6/2.
//  Copyright © 2016年 pinAn.com. All rights reserved.
//

#import "ViewController.h"
#import "CYScrollView.h"

#define kScreenWidth [[UIScreen mainScreen] bounds].size.width
const CGFloat headerHeight = 200;

@interface ViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UIView *tableViewHeader;

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    CYScrollView *cyScroll = [[CYScrollView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:cyScroll];
    cyScroll.backgroundColor = [UIColor lightGrayColor];
    
    UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(50, 50, 200, 100)];
    label1.backgroundColor = [UIColor redColor];
    [cyScroll addSubview:label1];
    
    UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(50, 250, 200, 100)];
    label2.backgroundColor = [UIColor yellowColor];
    [cyScroll addSubview:label2];
    
}

- (UIView *)tableViewHeader{
    if (!_tableViewHeader) {
        _tableViewHeader = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, headerHeight)];
        _tableViewHeader.backgroundColor = [UIColor redColor];
    }
    return _tableViewHeader;
}

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cellid"];
        _tableView.tableHeaderView = self.tableViewHeader;
    }
    return _tableView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 30;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 50)];
    label.backgroundColor = [UIColor lightGrayColor];
    label.text = @"   主题                摘要             内容";
    return label;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellid"];
    cell.textLabel.text = [NSString stringWithFormat:@"%li", indexPath.row];
    return cell;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    NSLog(@"%f", scrollView.bounds.origin.y);
}

@end















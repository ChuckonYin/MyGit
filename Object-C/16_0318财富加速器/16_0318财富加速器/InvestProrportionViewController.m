//
//  InvestProrportionViewController.m
//  16_0318财富加速器
//
//  Created by ChuckonYin on 16/3/22.
//  Copyright © 2016年 PingAn. All rights reserved.
//

#import "InvestProrportionViewController.h"
#import "InvestFinanceCell.h"
#import "InvestFundCell.h"

#define kScreenWidth [[UIScreen mainScreen] bounds].size.width

@interface InvestProrportionViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UITableViewCell *thirdSectionHeader;
@property (nonatomic, strong) UITableViewCell *fourSectionHeader;

@end

@implementation InvestProrportionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
    
}

#pragma mark - get & set

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}

#pragma mark - UITableViewDelegate

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *PieChartCellid = @"PieChartCellid";
    static NSString *BarChartCellid = @"BarChartCellid";
    static NSString *financialCellid = @"financialCellid";
    static NSString *funCellid = @"funCellid";
    switch (indexPath.section) {
        case 0:{
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:PieChartCellid];
            if (!cell) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:PieChartCellid];
            }
            return cell;
        }
        case 1:{
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:BarChartCellid];
            if (!cell) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:financialCellid];
            }
            return cell;
        }
        //专项理财
        case 2:{
            InvestFinanceCell *cell = [tableView dequeueReusableCellWithIdentifier:financialCellid];
            if (!cell) {
                cell = [[InvestFinanceCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:financialCellid];
            }
            return cell;
        }
        //基金
        case 3:{
            InvestFundCell *cell = [tableView dequeueReusableCellWithIdentifier:funCellid];
            if (!cell) {
                cell = [[InvestFundCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:funCellid];
            }
            return cell;
        }
        default:
            break;
    }
    return nil;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    switch (section) {
        case 0: return 1;
        case 1: return 1;
        case 2: return 2;
        case 3: return 3;
    }
    return 0;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 4;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    switch (section) {
        case 0: return 0.001;
        case 1: return 0.001;
        case 2: return 30;
        case 3: return 30;
    }
    return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    switch (section) {
        case 0: return nil;
        case 1: return nil;
        case 2:{
            if (!_thirdSectionHeader) {
                _thirdSectionHeader = [self creatSectionHeader];
                _thirdSectionHeader.textLabel.text = @"专项理财";
            }
            return _thirdSectionHeader;
        }
        case 3:{
            if (!_fourSectionHeader) {
                _fourSectionHeader = [self creatSectionHeader];
                _fourSectionHeader.textLabel.text = @"热门基金";
            }
            return _fourSectionHeader;
        }
        default: return nil;
    }
}

- (UITableViewCell*)creatSectionHeader{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    cell.backgroundColor = self.view.backgroundColor;
    cell.textLabel.font = [UIFont systemFontOfSize:12.0];
    CALayer *layer = [CALayer layer];
    layer.frame = CGRectMake(0, 30-0.5, kScreenWidth, 0.5);
    layer.backgroundColor = [UIColor colorWithRed:0.80 green:0.80 blue:0.80 alpha:1].CGColor;
    [cell.layer addSublayer:layer];
    return cell;
};

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 5.0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.section) {
        case 0: return 100;
        case 1: return 100;
        case 2: return 60;
        case 3: return 60;
    }
    return 0;
}


#pragma mark - set & get


@end









//
//  GCLoadingView.m
//  加载动画
//
//  Created by ChuckonYin on 16/4/5.
//  Copyright © 2016年 PingAn. All rights reserved.
//

#import "GCLoadingView.h"

@interface GCLoadingView()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *dataArray;

@end


@implementation GCLoadingView


- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor lightGrayColor];
        [self addSubview:self.tableView];
        _dataArray = [NSMutableArray new];
    }
    return self;
}

- (void)startAnimation{
    __block UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 300, [[UIScreen mainScreen] bounds].size.width, 44)];
    label.backgroundColor = [UIColor redColor];
    label.text = @"我是尹绪坤";
    [self addSubview:label];
    
    [UIView animateWithDuration:1 animations:^{
        label.transform = CGAffineTransformTranslate(CGAffineTransformMakeScale(0.5, 0.5), 0, -200);
    } completion:^(BOOL finished) {
        [label removeFromSuperview];
        [[self currentEmptyCell] addSubview:label];
    }];
}

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, 250)];
        _tableView.backgroundColor = [UIColor grayColor];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.scrollEnabled = NO;
    }
    return _tableView;
}

- (UITableViewCell *)currentEmptyCell{
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:_dataArray.count inSection:0];
    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
//    return CGRectMake(0, 0, self.frame.size.width, 44);
    return cell;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellid = @"cellid";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
    }
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 20;
}

@end







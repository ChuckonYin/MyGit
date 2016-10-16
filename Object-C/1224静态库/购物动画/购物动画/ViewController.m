//
//  ViewController.m
//  购物动画
//
//  Created by ChuckonYin on 15/12/26.
//  Copyright © 2015年 PingAn. All rights reserved.
//

#define headerHeight 100
#define cellHeight 100
#import "CYKit.h"
#import "CYCell.h"
#import "ViewController.h"
#import "CYParabolaView.h"

@interface ViewController ()
<UITableViewDataSource,
UITableViewDelegate,
CYCellDelegate,
CYParabolaViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) UIView *headerView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, headerHeight)];
    _headerView.layer.contents = (id)UIImageNamed(@"222.jpg").CGImage;
    
    _tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
    [self.view addSubview:_tableView];
    _tableView.tableHeaderView = _headerView;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    [_tableView registerClass:[CYCell class] forCellReuseIdentifier:@"cellid"];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return cellHeight;
}
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CYCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellid" forIndexPath:indexPath];
    cell.delegate = self;
    cell.indexPath = indexPath;
    return cell;
}

-(void)cyCellBtnClick:(UIButton *)btn image:(UIImage *)img indexPath:(NSIndexPath *)indexPath
{
    //获取按钮图
//    UIImage *btnImg = [btn.layer imageShotAllLayer];
    
    CGFloat offY = _tableView.contentOffset.y;
    //计算出按钮在当前视图的位置
    CGFloat btnY = headerHeight + indexPath.row * cellHeight - offY + btn.centerY;
    
    CGFloat btnX = btn.centerX;
    
    CYParabolaView *paraView = [[CYParabolaView alloc] initWithSuperView:self.view delegate:self];
    [self.view addSubview:paraView];
    
    [paraView startMove:img startCenter:CGPointMake(btnX, btnY) stopCenter:CGPointMake(kScreenWidth/2, 500) interval:1 minScale:1 callback:^{
        
    }];
}

-(void)CYParabolaViewAnimationStop
{
    
}



@end












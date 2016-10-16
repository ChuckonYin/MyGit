//
//  ViewController.m
//  CYParabolaView
//
//  Created by ChuckonYin on 15/10/19.
//  Copyright © 2015年 PingAn. All rights reserved.
//

#import "ViewController.h"
//#import "LZGCell.h"
#import "CYParabolaView.h"
#import "LZGCell.h"

@interface ViewController ()<CYParabolaViewDelegate,UITableViewDataSource,CYCellDelegate>
{
    UITableView *_tableView;
    CGFloat _currentOffY;
    CGPoint _touchPoint;
    CGPoint _stopP;
    CYParabolaView *parabolaView;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    [self.view addSubview:_tableView];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    //模拟的购物车位置
    _stopP = CGPointMake([[UIScreen mainScreen] bounds].size.width*9/10, [[UIScreen mainScreen] bounds].size.height-22);
    
    //点击开始动画时创建一个与self.view相同大小的透明视图覆盖在该视图上，动画结束后，必须在代理方法中移除此控件，并做出相应的数据处理。你要处理的唯一难点时startPoint的位置。
}

-(void)CYParabolaViewAnimationStop
{
    NSLog(@"调整星期，购物车");
    parabolaView.hidden = YES;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 20;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellid = @"cellid";
    LZGCell * cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    if (!cell) {
        cell = [[LZGCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
//        cell.delegate = self;
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
     LZGCell *cell = [tableView cellForRowAtIndexPath:indexPath];

    parabolaView = [[CYParabolaView alloc] initWithSuperView:self.view delegate:self];
    [self.view addSubview:parabolaView];
    
    //注意传入的必须是UIImageview
    [parabolaView startMove:cell.adImg startCenter:_touchPoint stopCenter:_stopP interval:1 minScale:0.1 callback:^{
    }];}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    _currentOffY = scrollView.contentOffset.y;
    
}
-(void)LZGCellTouchWithEvent:(NSSet<UITouch *> *)touches {
    _touchPoint = [[touches anyObject] locationInView:self.view];
    
    NSInteger index = (NSInteger)(_currentOffY + _touchPoint.y)/44;
    
    NSIndexPath *path = [NSIndexPath indexPathForRow:index inSection:0];
    
    LZGCell *cell = [_tableView cellForRowAtIndexPath:path];
    
    parabolaView = [[CYParabolaView alloc] initWithSuperView:self.view delegate:self];
    [self.view addSubview:parabolaView];
    //注意传入的必须是UIImageview
    [parabolaView startMove:cell.adImg startCenter:_touchPoint stopCenter:_stopP interval:1 minScale:0.1 callback:^{
    }];
}




@end

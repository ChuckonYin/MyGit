//
//  ViewController.m
//  1231tabelview制作轮播控件
//
//  Created by ChuckonYin on 15/12/31.
//  Copyright © 2015年 PingAn. All rights reserved.
//

#import "ViewController.h"
#import "CYCell.h"
@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArray;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"联系人";
    
    [self loadData];
    
    [self initSubviews];
}
-(void)loadData
{
//    _dataArray = [NSMutableArray new];
    _dataArray = @[@"0.jpg",@"1.jpg",@"2.jpg"].mutableCopy;
   
}
- (void)initSubviews
{
    
    self.navigationController.navigationBar.translucent = NO;
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(-self.view.bounds.size.height/2 + self.view.bounds.size.width/2, self.view.bounds.size.height/2 - self.view.bounds.size.width/2, self.view.bounds.size.height, self.view.bounds.size.width) style:UITableViewStylePlain];
    [self.view addSubview:_tableView];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.rowHeight = screenWidth;
    
    _tableView.pagingEnabled = YES;
    _tableView.transform = CGAffineTransformMakeRotation(-M_PI/2);
}
//
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ooo = @"celliddd";
    CYCell *cell = [tableView dequeueReusableCellWithIdentifier:ooo];
    if (cell == nil) {
        cell = [[CYCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ooo];
        cell.clipsToBounds = NO;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
//    cell.layer.contents = (id)(.CGImage);
    cell.imageView.image = [UIImage imageNamed:_dataArray[indexPath.row]];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArray.count;
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
   
    NSLog(@"%f", scrollView.contentOffset.y);
    if (_tableView.contentOffset.y >= (_dataArray.count-1)*screenWidth) {
        NSLog(@"该换数据源了");
//        _dataArray
        NSString *s = _dataArray[0];
        [_dataArray removeObjectAtIndex:0];
        [_dataArray insertObject:s atIndex:_dataArray.count];
          _tableView.contentOffset = CGPointMake(0, screenWidth);
        [_tableView reloadData];
      
    }
    else if (_tableView.contentOffset.y <= 0){
        NSString *s = _dataArray[_dataArray.count-1];
        [_dataArray removeObjectAtIndex:_dataArray.count-1];
        [_dataArray insertObject:s atIndex:0];
          _tableView.contentOffset = CGPointMake(0, screenWidth);
        [_tableView reloadData];
      
    }
}


@end









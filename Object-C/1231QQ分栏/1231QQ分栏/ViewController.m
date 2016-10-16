//
//  ViewController.m
//  1231QQ分栏
//
//  Created by ChuckonYin on 15/12/31.
//  Copyright © 2015年 PingAn. All rights reserved.
//

#import "ViewController.h"
#import "QQSectionModel.h"
@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) NSMutableArray *sectionHeaderArr;
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
    _dataArray = [NSMutableArray new];
    NSArray *sections = @[@"我的好友",@"皇亲国戚",@"凤山城回忆录",@"才华1班",@"同僚"];
    NSArray *rows = @[@"好友1",@"好友2",@"好友3",@"好友4",@"好友5"];
    for (int i=0; i < sections.count; i++) {
        QQSectionModel *model = [[QQSectionModel alloc] init];
        model.sectionTitle = sections[i];
        model.friendArr = rows;
        model.isUnfold = YES;
        [_dataArray addObject:model];
    }
    
    _sectionHeaderArr = [NSMutableArray new];
    for (int i=0; i<sections.count; i++) {
        UIButton *v = [[UIButton alloc] initWithFrame:CGRectMake(0, 30, 400, 14)];
        v.backgroundColor = [UIColor lightGrayColor];
        [v setTitle:sections[i] forState:UIControlStateNormal];
        [v setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        v.tag = 1990 + i;
//        v.backgroundColor = [UIColor whiteColor];
        v.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 300);
        [_sectionHeaderArr addObject:v];
        [v addTarget:self action:@selector(friendsUnfold:) forControlEvents:UIControlEventTouchUpInside];
    }
}
- (void)initSubviews
{
    self.navigationController.navigationBar.translucent = NO;
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(-self.view.bounds.size.height/2 + self.view.bounds.size.width/2, self.view.bounds.size.height/2 - self.view.bounds.size.width/2, self.view.bounds.size.height, self.view.bounds.size.width) style:UITableViewStyleGrouped];
    [self.view addSubview:_tableView];
    _tableView.dataSource = self;
    _tableView.delegate = self;
        
//    _tableView.contentInset = UIEdgeInsetsMake(-35, 0, 0, 0);
    _tableView.pagingEnabled = YES;
    _tableView.transform = CGAffineTransformMakeRotation(M_PI/2);
}
//
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30.0f;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [[UIScreen mainScreen] bounds].size.width;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [_dataArray[section] sectionTitle];
}

- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return _sectionHeaderArr[section];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ooo = @"celliddd";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ooo];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ooo];
    }
    cell.backgroundColor = [UIColor colorWithRed:(CGFloat)(arc4random()%10)/10 green:(CGFloat)(arc4random()%10)/10 blue:(CGFloat)(arc4random()%10)/10 alpha:1];
    cell.textLabel.text = [_dataArray[indexPath.section] friendArr][indexPath.row];
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _dataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    QQSectionModel *sectionModel = _dataArray[section];
    if (sectionModel.isUnfold){
        return sectionModel.friendArr.count;
    }
    else{
        return 0;
    }
}

- (void)friendsUnfold:(UIButton*)btn
{
    NSInteger index = btn.tag - 1990;
    
    QQSectionModel *model = _dataArray[index];
    
    model.isUnfold = !model.isUnfold;
    
    [_tableView reloadData];
    
}















@end







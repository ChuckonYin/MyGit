//
//  AboutUsViewController.m
//  FoodStore
//
//  Created by ZhangShouC on 12/26/14.
//  Copyright (c) 2014 liuguopan. All rights reserved.
//

#import "AboutUsViewController.h"

@interface AboutUsViewController () <UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate>
{
    UILabel * _versonLbl;
    UITableView * _tableView;
    NSMutableArray * _dataArr;
    NSString * currentVersion;
    NSString * server_folder;
}
@end

@implementation AboutUsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self sliderAbled:YES];
}
- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [self sliderAbled:NO];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [self setNav];
    [self initData];
//    [self initView];
    [self setTable];
}
- (void)initData
{
    currentVersion =[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    NSString * path = [NSString stringWithFormat:@"检测更新 (v%@)",currentVersion];
   _dataArr = [NSMutableArray arrayWithArray:@[path,@"分享给朋友",@"使用条款和协议",@"客服电话：4000-557117"]];
}
- (void)setTable
{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(10, 10, 300, SELF_VIEW_HEIGHT) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.showsHorizontalScrollIndicator = NO;
    _tableView.backgroundColor = [UIColor clearColor];
    if (IOS_VERSION>=7.0) {
        [_tableView setSeparatorInset:UIEdgeInsetsZero];
    }
    _tableView.tableFooterView = [[UIView alloc] init];
    [self.view addSubview:_tableView];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArr.count;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * cellId = @"cell";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    
    cell.backgroundColor = [UIColor whiteColor];
    cell.textLabel.text = _dataArr[indexPath.row];
    
    cell.imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"about_%d",indexPath.row]];
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSInteger index = indexPath.row;
    
    if (index == 0) {
        NSString * path = [NSString stringWithFormat:@"%@/app_info/type/Iphone",DIANCAN_VIEW1];
        [GCDServer serverWithUrl:path complete:^(NSData * data) {
            NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            if ([currentVersion compare:dict[@"info"][@"version"]]==NSOrderedAscending) {
                server_folder = dict[@"info"][@"server_folder"];
                UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"软件更新" message:@"当前有新版本，是否立即更新" delegate:self cancelButtonTitle:@"稍后更新" otherButtonTitles:@"立即更新", nil];
                [alert setTag:90];
                [alert show];
            } else {
                UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"软件更新" message:@"当前版本为最新版本，不需更新" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                [alert show];
            }
        }];
    } else if (index == 1) {

    } else if (index == 2) {
        
    } else if (index == 3) {
        
    }
    
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 90 && buttonIndex == 1) {
      [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"itms-services://?action=download-manifest&url=%@",server_folder]]];
    }
}






- (void)initView
{
//    NSArray * imgArr = @[@"about_1"];
    NSArray * titleArr = @[@"检测更新",@"分享给朋友",@"使用条款和协议",@"客服电话：4000-557117"];
    for (int i = 0; i < 4; i++) {
        UIImageView * img = [[UIImageView alloc] initWithFrame:CGRectMake(10, 75+50*i, 300, 40)];
        img.backgroundColor = [UIColor whiteColor];
        img.userInteractionEnabled = YES;
        [self.view addSubview:img];
        
        UIImageView * left = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 20, 20)];
//        left.image = [UIImage imageNamed:imgArr[i]];
//        left.image = [UIImage imageNamed:@"LeftSide.png"];
        [img addSubview:left];
        
        UILabel * title = [[UILabel alloc] initWithFrame:CGRectMake(40, 0, 200, 40)];
        title.text = titleArr[i];
        title.font = [UIFont systemFontOfSize:18];
        [img addSubview:title];
        
        if (!i) {
            _versonLbl = [[UILabel alloc] initWithFrame:CGRectMake(240, 0, 50, 40)];
            _versonLbl.text = @"v4.3.1";
            _versonLbl.textAlignment = NSTextAlignmentRight;
            [img addSubview:_versonLbl];
        }
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] init];
        if (i == 0) {
            [tap addTarget:self action:@selector(versionClick)];
        } else if (i == 1) {
            [tap addTarget:self action:@selector(shareClick)];
        } else if (i == 2) {
            [tap addTarget:self action:@selector(useClick)];
        } else if (i == 3) {
            [tap addTarget:self action:@selector(telClick)];
        }
        [img addGestureRecognizer:tap];
    }
}
- (void)versionClick
{
    LOG_METHOD;
}
- (void)shareClick
{
    LOG_METHOD;
}
- (void)useClick
{
    LOG_METHOD;
}
- (void)telClick
{
    LOG_METHOD;
}
- (void)setNav
{
    [self setSliderItem];
    [self resetTitleView:@"关于我们"];
    self.view.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

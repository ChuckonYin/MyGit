//
//  OrderFoodViewController.m
//  FoodStore
//
//  Created by liuguopan on 14/12/19.
//  Copyright (c) 2014年 viewcreator3d. All rights reserved.
//

#import "OrderFoodViewController.h"
#import "LocationViewController.h"
#import "RestaurSearchViewController.h"
#import "VCSegmentedButton.h"
#import "RestaurCell.h"
#import "FoodListViewController.h"
#import "CustomViewController.h"
#import "Model.h" 
#import "VCStarsImageView.h"
#import "JSON.h"
#import "UIImageView+WebCache.h"
#import "MJRefresh.h"
#import "LoginViewController.h"
#import "AFNetworking.h"
#import "cateModel.h"
#define kSegmentButtonHeight 46.0f

typedef enum {
    TableViewTypeNormal,
    TableViewTypeLeftOption,
    TableViewTypeRightOption,
} TableViewType;

@interface OrderFoodViewController ()
<UITableViewDataSource,
 UITableViewDelegate,
 LocationVCDelegate,
 CustomVCDelegate,
 MJRefreshBaseViewDelegate,
 UIAlertViewDelegate>

@property (nonatomic, assign) int pagenum;                      //  第几页
@property (nonatomic, strong) NSMutableArray *resourceArray;    //  下载数据

@property (nonatomic, strong) NSArray *leftDefaultArray;        //  默认筛选分类
@property (nonatomic, strong) NSMutableArray *leftArray;        //  调整过后的筛选分类数组
@property (nonatomic, strong) NSArray *rightArray;              //  与筛选所对应的大数组
@property (nonatomic, strong) NSArray *sortArray;               //  排序条件数组
@property (nonatomic, strong) NSArray *otherArray;
@property (nonatomic, strong) NSArray *dataArray;               //  筛选对应的小数组

@property (nonatomic, strong) UIView *bgOptionView;             //  筛选排序的底层视图
@property (nonatomic, strong) UIView *midOptionView;            //  筛选排序的中间层视图
@property (nonatomic, strong) UITableView *normalTableView;     //  餐厅列表视图
@property (nonatomic, strong) UITableView *leftOptionTableView; //  筛选左侧列表
@property (nonatomic, strong) UITableView *rightOptionTableView;//  右侧列表

@property (nonatomic, assign) NSInteger lastSelectedLeftIndex;          //  右侧列表上次选中cell的index

@property (nonatomic, strong) UITableViewCell *lastSelectedLeftCell;    //  左侧列表上次选中cell
@property (nonatomic, strong) UITableViewCell *lastSelectedRightCell;   //  右侧列表上次选中cell

@property (nonatomic, strong) VCSegmentedButton *segmentedBtn;          //  筛选、排序、更多
@property (nonatomic, strong) RestaurOption *option;                    //  记下所选结果
@property (nonatomic, strong) NSString * orderTitle;
@property (nonatomic, strong) MJRefreshHeaderView *mjHeaderView;        //  下拉刷新
@property (nonatomic, strong) MJRefreshFooterView *mjFooterView;        //  上拉加载
@property (nonatomic ,strong)NSMutableArray *cateArr;
@end

@implementation OrderFoodViewController

#pragma mark - Lift Cycle -

#pragma mark viewDidLoad

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _cateArr =[NSMutableArray arrayWithObjects:@"默认", nil];
    [self initData];
    [self setNav];
    [self createSegmentedButton];
    [self createTableView:TableViewTypeNormal];
    [self createMJRefreshView];
    [self createOptionView];
    [self downCataName];
//    [self performSelector:@selector(download)
//               withObject:nil
//               afterDelay:0.5f];
}


#pragma mark Appear

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    
        [self downloadUser];
    
    
}
- (void)downloadUser
{
    if ([Public sharedPublic].userInfo.userID == nil) {
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        if ((NSNull *)[userDefaults objectForKey:@"username"] != [NSNull null]) {
            NSString * name = [userDefaults objectForKey:@"username"];
            NSString * pass = [userDefaults objectForKey:@"password"];
            NSString * urlpath = [NSString stringWithFormat:@"%@/username/%@/password/%@/session_id/%@",DIANCAN_LOGIN,name,pass,[Public getMac]];
            [GCDServer serverWithUrl:urlpath complete:^(NSData * data) {
                NSMutableArray * arr = [JSON getUser:data];
                if (arr.count == 1) {
                    [Public sharedPublic].userInfo = arr[0];
                    [self download];
                }
            }];
        }
    } else {
        [self download];
    }
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


#pragma mark dealloc

- (void)dealloc
{
    [_mjHeaderView free];
    [_mjFooterView free];
}

#pragma mark - 初始化数据

- (void)initData
{
    if (!self.resourceArray) {
        NSMutableArray *arr = [[NSMutableArray alloc] init];
        self.resourceArray = arr;
    }
    
   
    NSArray *leftArray = @[@"菜系", @"星级", @"距离", @"人均消费", @"确定"];
    self.leftDefaultArray = leftArray;
    self.leftArray = [[NSMutableArray alloc] initWithArray:leftArray];
    
    self.rightArray = @[_cateArr,
                        @[@"默认", @"一星", @"二星", @"三星", @"四星", @"五星"],
                        @[@"默认", @"<1Km", @"<5Km", @"<10Km", @"<20Km"],
                        @[@"默认", @"<5￥", @"<10￥", @"<20￥", @"<50￥"]];
    self.sortArray =  @[@"默认", @"按星级排序", @"按距离排序", @"按人均消费排序"];
    self.otherArray = @[@"默认",@"支持开发票",@"不支持开发票"];
    self.dataArray =  _cateArr;
    RestaurOption *option = [[RestaurOption alloc] init];
    self.option = option;
}

//  等待连接网络，延时0.5s，再去下载。
- (void)download
{
    if (self.resourceArray.count) {
        [self.resourceArray removeAllObjects];
        
    }
    [self downloadData:0];
    [self.normalTableView reloadData];
}
- (NSString *)addPath
{
    NSString * caixi = @"";
    NSString * xingji = @"";
    NSString * juli = @"";
    NSString * faPiao =@"";
    NSString * renjun = @"";
    NSString * paixu = @"";
    if (self.option.cuisine) {
        caixi = [NSString stringWithFormat:@"/cate_id/%ld",self.option.cuisine+10];
       // NSLog(@"%@",self.dataArray[self.option.cuisine]);
    }
    
    if (self.option.otherOption) {
        faPiao = [NSString stringWithFormat:@"/is_invoice/%ld",self.option.otherOption-1];
        
       // NSLog(@"kkk%ld",self.option.otherOption);
    }
    if (self.option.minStars) {
        xingji = [NSString stringWithFormat:@"/rank/%ld",self.option.minStars];
    }
    if (self.option.maxDistanceLevel) {
        juli = [NSString stringWithFormat:@"/range/%ld",self.option.maxDistanceLevel*1000];
    }
    if (self.option.maxPercapitaLevel) {
        renjun = [NSString stringWithFormat:@"/rank/%ld",self.option.maxDistanceLevel];
    }
    NSArray * arr = @[@"rank",@"range",@"renjun"];
    if (self.option.sortOption != 0) {
        paixu = [NSString stringWithFormat:@"/by/%@",arr[self.option.sortOption-1]];
    }
    
    return [NSString stringWithFormat:@"%@%@%@%@%@%@",caixi,faPiao, xingji,juli,renjun,paixu];
}
#pragma mark - Download Data
//菜系名称
- (void)downCataName{
    NSString *path =[NSString stringWithFormat:@"%@/index.php/Dy/View/storecatdata",DIANCAN_URL];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    [manager GET:path parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSArray *arr =(NSArray *)responseObject;
//        NSString *string =[[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
//        
//        NSLog(@"%@",string);
        
        for (NSDictionary *dic  in arr) {
            
            
            NSString *cateName =dic[@"cate_name"];
            
            [_cateArr addObject:cateName];
            
        }
        NSLog(@"%@",_cateArr);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error.description);
    }];
    
}


- (void)downloadData:(int)pagenum
{
    if (NotNetworkStatu == [Public sharedPublic].networkState) {
        [self.mjHeaderView endRefreshing];
        [self.mjFooterView endRefreshing];
        [SVProgressHUD showErrorWithStatus:@"sssssssssssssssb无法下载数据，请检查你的网络！" duration:0.5f];
        return;
    }

    CLLocationCoordinate2D coordinate = [CustomViewController sharedCustom].coordinate;
    NSString *url = [NSString stringWithFormat:@"%@/lat/%f/lon/%f/pagenum/%d%@",
                                                 DIANCAN_STOREDATA,
                                                 coordinate.latitude,
                                                 coordinate.longitude,
                                                 pagenum,
                                                [self addPath]];
    if ([Public sharedPublic].userInfo.userID) {
        url = [url stringByAppendingFormat:@"/user_id/%@", [Public sharedPublic].userInfo.userID];
    }
//    LOG_FORMAT(@"");
    [GCDServer serverWithUrl:url
                    complete:^(NSData *data) {
                        
        NSArray *restaurs = [JSON getRestaurs:data];
            if (restaurs && restaurs.count) {
                if (0 == pagenum) {
                    [self.resourceArray removeAllObjects];
                }
                for (RestaurInfo * info in restaurs) {
                    int cou = 0;
                    for (RestaurInfo * Ainfo in self.resourceArray) {
                        if ([info.restaurID isEqualToString:Ainfo.restaurID]) {
                            cou ++;
                            break;
                        }
                    }
                    if (!cou) {
                        [self.resourceArray addObject:info];
                    }
                }
//                [self.resourceArray addObjectsFromArray:restaurs];
                [self.normalTableView reloadData];
                [self.mjHeaderView endRefreshing];
                [self.mjFooterView endRefreshing];
//                [SVProgressHUD showSuccessWithStatus:@"数据加载完成。"];
                LOG(restaurs);
            }
    } error:^(NSError *error) {
        [self.mjHeaderView endRefreshing];
        [self.mjFooterView endRefreshing];
//        [SVProgressHUD showErrorWithStatus:@"下载失败！"];
    }];
}
    

#pragma mark - Custom View -
#pragma mark NavigationBar

- (void)setNav
{
    [self setSliderItem];
    [self setRightSearchItem:@selector(searchClick)];
    [self setTitleButton:@"餐厅列表" sel:@selector(location)];
    _orderTitle = @"餐厅列表";
    [CustomViewController sharedCustom].delegate = self;
    [[CustomViewController sharedCustom] locationHome];
  //  [SVProgressHUD showWithStatus:@"定位中"];
}


#pragma mark 筛选/排序/其它 选项

- (void)createSegmentedButton
{
    CGRect frame = CGRectMake(0, SELF_VIEW_ORIGIN_Y, SELF_VIEW_WIDTH, kSegmentButtonHeight);
    VCSegmentedButton *segmentedBtn = [[VCSegmentedButton alloc] initWithFrame:frame];
    segmentedBtn.backgroundColor = [UIColor colorWithRed:0.98f green:0.98f blue:0.98f alpha:1.00f];
    [segmentedBtn addTarget:self
                     action:@selector(segmentedBtnClick:)
           forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:segmentedBtn];
    self.segmentedBtn = segmentedBtn;
}


#pragma mark 筛选/排序/其它 下拉菜单

- (void)createOptionView
{
    UIView *bgOptionView = [[UIView alloc] init];
    bgOptionView.frame = CGRectMake(0,
                                    SELF_VIEW_ORIGIN_Y + kSegmentButtonHeight,
                                    SELF_VIEW_WIDTH,
                                    SELF_VIEW_HEIGHT - NAVIGATIONBAR_HEIGHT - kSegmentButtonHeight);
    bgOptionView.backgroundColor = [UIColor colorWithWhite:0.0f alpha:0.40f];
    bgOptionView.hidden = YES;
    [self.view addSubview:bgOptionView];
    self.bgOptionView = bgOptionView;
    
    //  创建中间层
    [self createOptionMiddleView];
    
    //  创建下部手势视图
    [self createBottomView];
    
    //  创建选项列表
    [self createTableView:TableViewTypeLeftOption];
    [self createTableView:TableViewTypeRightOption];
}

- (void)createBottomView
{
    UIView *bottomView = [[UIView alloc] init];
    bottomView.frame = CGRectMake(0,
                                  VIEW_HEIGHT(self.midOptionView),
                                  VIEW_WIDTH(self.bgOptionView),
                                  VIEW_HEIGHT(self.bgOptionView) - VIEW_HEIGHT(self.midOptionView));
    UITapGestureRecognizer *tgr = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(bgOptionViewPressed:)];
    [bottomView addGestureRecognizer:tgr];
    [self.bgOptionView addSubview:bottomView];
}

- (void)createOptionMiddleView
{
    UIView *midOptionView = [[UIView alloc] init];
    midOptionView.frame = CGRectMake(0, 0, VIEW_WIDTH(self.bgOptionView), VIEW_HEIGHT(self.bgOptionView) / 3 * 2);
    midOptionView.backgroundColor = [UIColor whiteColor];
    [self.bgOptionView addSubview:midOptionView];
    self.midOptionView = midOptionView;
}


#pragma mark MJRefresh

- (void)createMJRefreshView
{
    MJRefreshHeaderView *mjHeaderView = [MJRefreshHeaderView header];
    mjHeaderView.scrollView = self.normalTableView;
    mjHeaderView.delegate = self;
    self.mjHeaderView = mjHeaderView;
    
    MJRefreshFooterView *mjFooterView = [MJRefreshFooterView footer];
    mjFooterView.scrollView = self.normalTableView;
    mjFooterView.delegate = self;
    self.mjFooterView = mjFooterView;
}

#pragma mark - TableView
#pragma mark -

- (void)createTableView:(TableViewType)type
{
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectZero
                                                          style:UITableViewStylePlain];
    tableView.backgroundColor = [UIColor whiteColor];
    tableView.tag = TAG_MIN + type;
    tableView.showsVerticalScrollIndicator = NO;
    if (IOS_VERSION >= 7.0f) {
        [tableView setSeparatorInset:UIEdgeInsetsZero];
    }
    tableView.dataSource = self;
    tableView.delegate = self;
    
    UIView *emptyView = [[UIView alloc] init];
    [tableView setTableFooterView:emptyView];
    
    
    if (TableViewTypeNormal == type) {                      //  餐厅列表
        tableView.frame = CGRectMake(0,
                                     SELF_VIEW_ORIGIN_Y + kSegmentButtonHeight,
                                     SELF_VIEW_WIDTH,
                                     SELF_VIEW_HEIGHT - STATUS_NAV_BAR_HEIGHT - kSegmentButtonHeight);
        tableView.contentInset = UIEdgeInsetsMake(0, 0, 5.0f, 0);
        [self.view addSubview:tableView];
        self.normalTableView = tableView;
        
        [self createHeaderView];
        
    } else if (TableViewTypeLeftOption == type) {  //  筛选/排序左侧选项列表
        tableView.frame = CGRectMake(0,
                                     0,
                                     VIEW_WIDTH(self.midOptionView) / 3,
                                     VIEW_HEIGHT(self.midOptionView));
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
        [tableView selectRowAtIndexPath:indexPath
                               animated:NO
                         scrollPosition:UITableViewScrollPositionTop];
        tableView.scrollEnabled = NO;
        [self.midOptionView addSubview:tableView];
        self.leftOptionTableView = tableView;
        
    } else if (TableViewTypeRightOption == type) { //  筛选/排序右侧选项列表
        tableView.frame = CGRectMake(VIEW_WIDTH(self.midOptionView) / 3,
                                     0,
                                     VIEW_WIDTH(self.midOptionView) / 3 * 2,
                                     VIEW_HEIGHT(self.midOptionView));
        tableView.backgroundColor = [UIColor colorWithRed:0.85f green:0.85f blue:0.85f alpha:1.00f];
        [self.midOptionView addSubview:tableView];
        self.rightOptionTableView = tableView;
    }
}

- (void)createHeaderView
{
    UILabel *headerLabel = [[UILabel alloc] init];
    headerLabel.frame = CGRectMake(0, 0, VIEW_WIDTH(self.normalTableView), 40.0f);
    headerLabel.backgroundColor = [UIColor clearColor];
    headerLabel.text = @"  餐厅列表";
    headerLabel.font = [UIFont systemFontOfSize:13.0f];
    headerLabel.layer.borderWidth = 1.0f;
    headerLabel.layer.borderColor = [UIColor colorWithRed:0.96f
                                                    green:0.96f
                                                     blue:0.96f
                                                    alpha:1.00f].CGColor;
    headerLabel.userInteractionEnabled = YES;
    self.normalTableView.tableHeaderView = headerLabel;
    
//    [self createMoreBtn:headerLabel];
}

/*
- (void)createMoreBtn:(UILabel *)headerLabel
{
    UIButton *moreBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    moreBtn.frame = CGRectMake(headerLabel.frame.size.width - 60, 0, 60.0f, 30);
    moreBtn.backgroundColor = [UIColor clearColor];
    [moreBtn setTitle:@" 更多" forState:UIControlStateNormal];
    [moreBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [moreBtn setTitleEdgeInsets:UIEdgeInsetsMake(8, 20, 0, 5)];
    moreBtn.titleLabel.font = [UIFont systemFontOfSize:11];
    [moreBtn addTarget:self action:@selector(moreBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [headerLabel addSubview:moreBtn];
}
*/


#pragma mark UITableViewDataSource UITableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (TAG_MIN + TableViewTypeNormal == tableView.tag) {
        return self.resourceArray.count;    
    } else if (TAG_MIN + TableViewTypeLeftOption == tableView.tag) {
        return self.leftArray.count;
    } else if (TAG_MIN + TableViewTypeRightOption == tableView.tag) {
        if (self.dataArray) {
            return self.dataArray.count;
        }
        return 0;
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (TAG_MIN + TableViewTypeNormal == tableView.tag) {
        return 90.0f;
    }
    if (TAG_MIN + TableViewTypeLeftOption == tableView.tag
        && 4 == indexPath.row) {
        return 80;
    }
    return 40.0f;
}


#pragma mark cellForRow

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (TAG_MIN + TableViewTypeNormal == tableView.tag) {
        static NSString *cellName = @"RestaurCell";
        RestaurCell *cell = [tableView dequeueReusableCellWithIdentifier:cellName];
        if (nil == cell) {
            cell = [[RestaurCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:cellName];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            [cell.favoriteButton addTarget:self
                                    action:@selector(favoriteBtnClick:)
                          forControlEvents:UIControlEventTouchUpInside];
        }
        cell.stars = 3.0f;
        RestaurInfo *restaur = (RestaurInfo *)[self.resourceArray objectAtIndex:indexPath.row];
     
        cell.favoriteButton.indexPath = indexPath;
        cell.favoriteButton.site_id = restaur.restaurID;
        cell.favoriteButton.selected = restaur.favorite;
//        NSString *iconStr = [NSString stringWithFormat:@"%@%@", DIANCAN_URL, restaur.restaurIcon];
        NSURL *iconURL = [NSURL URLWithString:[NSString stringWithFormat:@"http://dingcan.viewcreator3d.cn%@",restaur.restaurIcon]];
        //NSLog(@"%@",restaur.restaurIcon);
        [cell.iconImageView setImageWithURL:iconURL];
        cell.restaurNameLabel.text = restaur.restaurName;
        cell.stars = restaur.stars;
        cell.reviewsLabel.text = [NSString stringWithFormat:@"(%@)",restaur.reviews];
        cell.sellCopiesLable.text = [NSString stringWithFormat:@"月售%@份",restaur.monthlySales];
        cell.percapitaExpenseLabel.text = [NSString stringWithFormat:@"人均：%@",restaur.percapita];
        cell.freightLabel.text = [NSString stringWithFormat:@"起送价：%.2f",restaur.minPrice.floatValue];
        cell.freightTimeLabel.text = [NSString stringWithFormat:@"送餐时间:%@",restaur.freightTime];
        cell.cuisineLabel.text = [NSString stringWithFormat:@"菜系：%@",restaur.cuisine];
        cell.couponTipsLabel.text = [NSString stringWithFormat:@"优惠/提醒:%@",@"辣椒可以免费吃"];
        
        
        return cell;
    }  else if (TAG_MIN + TableViewTypeLeftOption == tableView.tag) {
        static NSString *cellName = @"Cell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellName];
        if (nil == cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                          reuseIdentifier:cellName];
            cell.textLabel.font = [UIFont systemFontOfSize:15.0f];
            cell.textLabel.textAlignment = NSTextAlignmentCenter;
            if (0 == indexPath.row) {
                cell.textLabel.textColor = [UIColor redColor];
                self.lastSelectedLeftIndex = 0;
                self.lastSelectedLeftCell = cell;
            }
        }
        cell.textLabel.text = [self.leftArray objectAtIndex:indexPath.row];
        return cell;
    } else if (TAG_MIN + TableViewTypeRightOption == tableView.tag) {
        static NSString *cellName = @"Cell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellName];
        if (nil == cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                          reuseIdentifier:cellName];
            cell.textLabel.font = [UIFont systemFontOfSize:15.0f];
            cell.textLabel.textAlignment = NSTextAlignmentCenter;
            cell.backgroundColor = [UIColor clearColor];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            if (0 == indexPath.row) {
                cell.textLabel.textColor = [UIColor redColor];
            }
        }
        cell.textLabel.text = [self.dataArray objectAtIndex:indexPath.row];
        if (0 == self.segmentedBtn.currentSelectedIndex) {
            switch (self.lastSelectedLeftIndex) {
                case 0:
                    if (self.option.cuisine == indexPath.row) {
                        cell.textLabel.textColor = [UIColor redColor];
                    } else {
                        cell.textLabel.textColor = [UIColor blackColor];
                    }
                    break;
                case 1:
                    if (self.option.minStars == indexPath.row) {
                        cell.textLabel.textColor = [UIColor redColor];
                    } else {
                        cell.textLabel.textColor = [UIColor blackColor];
                    }
                    break;
                case 2:
                    if (self.option.maxDistanceLevel == indexPath.row) {
                        cell.textLabel.textColor = [UIColor redColor];
                    } else {
                        cell.textLabel.textColor = [UIColor blackColor];
                    }
                    break;
                case 3:
                    if (self.option.maxPercapitaLevel == indexPath.row) {
                        cell.textLabel.textColor = [UIColor redColor];
                    } else {
                        cell.textLabel.textColor = [UIColor blackColor];
                    }
                    break;
                default:
                    break;
            }
        } else if (1 == self.segmentedBtn.currentSelectedIndex) {
            if (self.option.sortOption == indexPath.row) {
                cell.textLabel.textColor = [UIColor redColor];
            } else {
                cell.textLabel.textColor = [UIColor blackColor];
            }
        } else if (2 == self.segmentedBtn.currentSelectedIndex) {
            if (self.option.otherOption == indexPath.row) {
                cell.textLabel.textColor = [UIColor redColor];
            } else {
                cell.textLabel.textColor = [UIColor blackColor];
            }
        }
        return cell;
    }
    return nil;
}


#pragma mark - 事件处理


#pragma mark - cellSelected

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (TAG_MIN + TableViewTypeNormal == tableView.tag) {
        FoodListViewController *flVC = [[FoodListViewController alloc] init];
        flVC.restInfo = self.resourceArray[indexPath.row];
        [self.navigationController pushViewController:flVC animated:YES];
        // 实现从右侧滑动，后退  iOS7
        if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
            self.navigationController.interactivePopGestureRecognizer.delegate = nil;
        }
        
    } else if (TAG_MIN + TableViewTypeLeftOption == tableView.tag) {
        if (4 == indexPath.row) {
            self.bgOptionView.hidden = YES;
            [self.segmentedBtn cancelSelect];
            [self download];
            return;
        }
        if (self.lastSelectedLeftCell) {
            self.lastSelectedLeftCell.textLabel.textColor = [UIColor blackColor];
        }
        UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        cell.textLabel.textColor = [UIColor redColor];
        self.lastSelectedLeftCell = cell;
        self.lastSelectedLeftIndex = indexPath.row;
        self.dataArray = [self.rightArray objectAtIndex:indexPath.row];
        [self.rightOptionTableView reloadData];
    } else if (TAG_MIN + TableViewTypeRightOption == tableView.tag) {
        if (0 == self.segmentedBtn.currentSelectedIndex) {
            switch (self.lastSelectedLeftIndex) {
                case 0:
                    self.option.cuisine = indexPath.row;
                    break;
                case 1:
                    self.option.minStars = indexPath.row;
                    break;
                case 2:
                    self.option.maxDistanceLevel = indexPath.row;
                    break;
                case 3:
                    self.option.maxPercapitaLevel = indexPath.row;
                    break;
                default:
                    break;
            }
            NSString *result;
            if (0 == indexPath.row) {
                //  如果选默认，左侧显示菜系、星级...
                result = [self.leftDefaultArray objectAtIndex:self.lastSelectedLeftIndex];
            } else {
                //  如果选的不是默认，将右侧选中的结果显示在左侧
                result = [self.dataArray objectAtIndex:indexPath.row];
            }
            [self.leftArray replaceObjectAtIndex:self.lastSelectedLeftIndex withObject:result];
            [self.rightOptionTableView reloadData];
            [self.leftOptionTableView reloadData];
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:self.lastSelectedLeftIndex inSection:0];
            [self.leftOptionTableView selectRowAtIndexPath:indexPath
                                                  animated:NO
                                            scrollPosition:UITableViewScrollPositionNone];
        } else if (1 == self.segmentedBtn.currentSelectedIndex) {
            self.option.sortOption = indexPath.row;
            self.bgOptionView.hidden = YES;
            [self download];
            [self.segmentedBtn cancelSelect];
        } else if (2 == self.segmentedBtn.currentSelectedIndex) {
            self.option.otherOption =indexPath.row;
            self.bgOptionView.hidden = YES;
            [self download];
            [self.segmentedBtn cancelSelect];
        }
    }
}


#pragma mark MJRefreshBaseViewDelegate

- (void)refreshViewBeginRefreshing:(MJRefreshBaseView *)refreshView
{
    if (self.normalTableView.contentOffset.y < 0) {
        self.pagenum = 0;
        [self downloadUser];
    } else {
        self.pagenum++;
        [self downloadData:self.pagenum];
    }
    
}

- (void)refreshViewEndRefreshing:(MJRefreshBaseView *)refreshView
{
    
}

#pragma mark 定位

- (void)location
{
    LocationViewController * location = [[LocationViewController alloc] init];
    BaseNavigationController *nav = [[BaseNavigationController alloc]
                                        initWithRootViewController:location];
    location.delegate = self;
    [self presentViewController:nav
                       animated:YES
                     completion:nil];
}


#pragma mark CustomVCDelegate

- (void)locationWithData:(NSString *)place
{
    [SVProgressHUD dismiss];
    if (place.length && ![_orderTitle isEqualToString:place]) {
        _orderTitle = place;
        [self setTitleButton:[NSString stringWithFormat:@"%@附近",place] sel:@selector(location)];
        CLLocationCoordinate2D coordinate = [CustomViewController sharedCustom].coordinate;
        NSString *strCoordinate=[NSString stringWithFormat:@"经度1:%f \n纬度1:%f",coordinate.latitude,coordinate.longitude];
        NSLog(@"%@",strCoordinate);
        
        [self downloadUser];
    }
}


#pragma mark LocationVCDelegate

- (void)changeLocation:(NSString *)title
{
    [self locationWithData:title];
}


#pragma mark 搜索

- (void)searchClick
{
    //    [self presentViewController:[[BaseNavigationController alloc] initWithRootViewController:[[RestaurSearchViewController alloc] init]] animated:YES completion:nil];
    [self.navigationController pushViewController:[[RestaurSearchViewController alloc] init] animated:YES];
}


#pragma mark 筛选/排序/其他

- (void)segmentedBtnClick:(VCSegmentedButton *)sender
{
    if (-1 == sender.currentSelectedIndex) {
        self.bgOptionView.hidden = YES;
        return;
    } else {
        self.bgOptionView.hidden = NO;
        if (0 == sender.currentSelectedIndex) {
            self.dataArray = [self.rightArray objectAtIndex:self.lastSelectedLeftIndex];
            self.leftOptionTableView.frame = CGRectMake(0,
                                         0,
                                         VIEW_WIDTH(self.midOptionView) / 3,
                                         VIEW_HEIGHT(self.midOptionView));
            self.rightOptionTableView.frame = CGRectMake(VIEW_WIDTH(self.midOptionView) / 3,
                                                         0,
                                                         VIEW_WIDTH(self.midOptionView) / 3 * 2,
                                                         VIEW_HEIGHT(self.midOptionView));
            NSIndexPath *indexPath = [self.leftOptionTableView indexPathForCell:self.lastSelectedLeftCell];
            [self.leftOptionTableView reloadData];
            [self.leftOptionTableView selectRowAtIndexPath:indexPath
                                                  animated:NO
                                            scrollPosition:UITableViewScrollPositionNone];
        } else if (1 == sender.currentSelectedIndex) {
            self.dataArray = self.sortArray;
            self.leftOptionTableView.frame = CGRectZero;
            self.rightOptionTableView.frame = CGRectMake(0,
                                                         0,
                                                         VIEW_WIDTH(self.midOptionView),
                                                         VIEW_HEIGHT(self.midOptionView));
        }
        else if (2 == sender.currentSelectedIndex) {
            //self.bgOptionView.hidden = YES;
            self.dataArray = self.otherArray;
            self.leftOptionTableView.frame = CGRectZero;
            self.rightOptionTableView.frame = CGRectMake(0,
                                                         0,
                                                         VIEW_WIDTH(self.midOptionView),
                                                         VIEW_HEIGHT(self.midOptionView));
        }
        [self.rightOptionTableView reloadData];
    }
}

- (void)bgOptionViewPressed:(UIPinchGestureRecognizer *)pgr
{
    self.bgOptionView.hidden = YES;
    [self.segmentedBtn cancelSelect];
}


#pragma mark 收藏

- (void)favoriteBtnClick:(VCButton *)favoriteBtn
{
    if ([Public sharedPublic].userInfo.userID == nil) {
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"登陆后可收藏餐厅" message:nil delegate:self cancelButtonTitle:@"以后再说" otherButtonTitles:@"登陆注册", nil];
        [alert show];
        return;
    }
    NSString * path = [NSString stringWithFormat:@"%@/%@/store_id/%@/user_id/%@",DIANCAN_VIEW1,(favoriteBtn.selected ? @"del_collect_store" : @"collect_store"),favoriteBtn.site_id,[Public sharedPublic].userInfo.userID];
    [GCDServer serverWithUrl:path complete:^(NSData * data) {
        NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        if ([dict[@"status"] isEqualToNumber:@1]) {
            [SVProgressHUD showSuccessWithStatus:dict[@"msg"]];
            favoriteBtn.selected = !favoriteBtn.selected;
        } else {
            [SVProgressHUD showErrorWithStatus:dict[@"msg"]];
        }
    }];
    
    
    
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        [self presentViewController:[[BaseNavigationController alloc] initWithRootViewController:[[LoginViewController alloc] init]] animated:YES completion:nil];
    }
}
/*
#pragma mark - 更多

- (void)moreBtnClick
{
    LOG(@"MoreBtn Click!!!");
}
*/

#pragma mark -
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

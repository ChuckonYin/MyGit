//  FoodListViewController.m
//  FoodStore
//  Created by liuguopan on 14/12/25.
//  Copyright (c) 2014年 viewcreator3d. All rights reserved.

#import "FoodListViewController.h"
#import "VCSegmentedButton.h"
#import "VCCartView.h"
#import "FoodCell.h"
#import "RestaurInfoViewController.h" 
#import "CartViewController.h"
#import "Model.h"
#import "MJRefresh.h"
#import "JSON.h"
#import "LoginViewController.h"

#define kSegmentButtonHeight    46.0f
#define kCartViewHeight         40.0f

typedef enum {
    TableViewTypeNormal,
    TableViewTypeOption,
} TableViewType;

@interface FoodListViewController ()
<UITableViewDataSource,
 UITableViewDelegate,
 MJRefreshBaseViewDelegate,
 UIAlertViewDelegate>

@property (nonatomic, strong) NSArray *leftArray;   //  左侧筛选数组
@property (nonatomic, strong) NSArray *rightArray;  //  右侧排序数组
@property (nonatomic, strong) NSArray *dataArray;   //  筛选/排序TableView数据源

@property (nonatomic, strong) UIView *bgOptionView; //  筛选/排序视图底图
@property (nonatomic, strong) UIView *midOptionView;//  筛选/排序中间层视图

@property (nonatomic, strong) UITableView *normalTableView; //  美食列表TableView
@property (nonatomic, strong) UITableView *optionTableView; //  筛选/排序TableView

@property (nonatomic, assign) NSInteger lastSelectedLeftIndex;          //  筛选上次选中的条目
@property (nonatomic, assign) NSInteger lastSelectedRightIndex;         //  排序上次选中的条目
@property (nonatomic, strong) UITableViewCell *lastSelectedLeftCell;    //  筛选上次选中的cell
@property (nonatomic, strong) UITableViewCell *lastSelectedRightCell;   //  排序上次选中的cell
@property (nonatomic, assign) NSInteger currentSelectedOptionButton;    //  当前选中的是筛选还是排序
@property (nonatomic, strong) UIButton *selectedOptionButton;           //  当前选中的是筛选还是排序按钮

@property (nonatomic, strong) RestaurOption *option;        //

@property (nonatomic, assign) BOOL isFirstClickOptionButton;//

@property (nonatomic, strong) UIView *foodDetailView;       //
@property (nonatomic, strong) UIView *bgFoodDetailView;     //

@property (nonatomic, assign) int pagenum;                              //  第几页
@property (nonatomic, strong) MJRefreshHeaderView *mjHeaderView;        //  下拉刷新
@property (nonatomic, strong) MJRefreshFooterView *mjFooterView;        //  上拉加载
@property (nonatomic, strong) NSMutableArray *resourceArray;            //  美食列表数据源

@property (nonatomic, strong) VCCartView *carView;

@property (nonatomic, strong) NSMutableArray *cartArray;
@property (nonatomic, strong) CartInfo *cartInfo;

@end

@implementation FoodListViewController
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
//    if (self.resourceArray.count) {
//        [self downloadCart];
//    } else {
        [self downloadData:0];
//    }
//    [self downloadCart];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initData];
    [self setNav];
    [self createOptionButton];
    [self createTableView:TableViewTypeNormal];
    [self createMJRefreshView];
    [self createCartView];
    [self createOptionView];
    [self createFoodDetailView];
}
- (void)dealloc
{
    [_mjHeaderView free];
    [_mjFooterView free];
}
#pragma mark - 初始化数据

- (void)initData
{
    self.leftArray = @[@"全部", @"鲁菜", @"川菜", @"苏菜", @"粤菜", @"闽菜", @"浙菜", @"徽菜", @"湘菜"];
    self.rightArray = @[@"默认", @"销量最高",@"价格最低", @"评分最高"];
    self.dataArray = self.leftArray;
    
    RestaurOption *option = [[RestaurOption alloc] init];
    self.option = option;
    
    self.currentSelectedOptionButton = -1;
    self.isFirstClickOptionButton = YES;
    
    NSMutableArray *arr = [[NSMutableArray alloc] init];
    self.resourceArray = arr;
    self.cartInfo = [[CartInfo alloc] init];
}

#pragma mark Download Data

- (void)downloadData:(int)pagenum
{
    if (NotNetworkStatu == [Public sharedPublic].networkState) {
        [self.mjHeaderView endRefreshing];
        [self.mjFooterView endRefreshing];
        [SVProgressHUD showErrorWithStatus:@"无法下载数据，Please check your network！" duration:0.5f];
        return;
    }
    NSString *url = [NSString stringWithFormat:@"%@/store_id/%@/pagenum/%d", DIANCAN_GOODSDATA, _restInfo.restaurID,pagenum];
    if ([Public sharedPublic].userInfo.userID) {
        url = [NSString stringWithFormat:@"%@/user_id/%@/store_id/%@/pagenum/%d", DIANCAN_GOODSDATA,[Public sharedPublic].userInfo.userID,_restInfo.restaurID, pagenum];
    }
    [GCDServer serverWithUrl:url
                    complete:^(NSData *data) {
                        
                        NSArray *foods = [JSON getFoods:data];
                        if (foods && foods.count) {
                            if (0 == pagenum) {
                                [self.resourceArray removeAllObjects];
                            } 
                            for (FoodInfo * info in foods) {
                                int cou = 0;
                                for (FoodInfo * Ainfo in self.resourceArray) {
                                    if ([info.foodID isEqualToString:Ainfo.foodID]) {
                                        cou ++;
                                        break;
                                    }
                                }
                                if (!cou) {
                                    [self.resourceArray addObject:info];
                                }
                            }
//                            [self.resourceArray addObjectsFromArray:foods];
                            [self.normalTableView reloadData];
                            [self.mjHeaderView endRefreshing];
                            [self.mjFooterView endRefreshing];
                            [self downloadCart];
                            
                        }
        
    } error:^(NSError *error) {
        [self.mjHeaderView endRefreshing];
        [self.mjFooterView endRefreshing];
    }];
}
- (void)downloadCart
{
    self.cartInfo = nil;
    self.cartInfo = [[CartInfo alloc] init];
    
    NSString * path;
     if ([Public sharedPublic].userInfo.userID) {
        path = [NSString stringWithFormat:@"%@/user_id/%@/session_id/%@",DIANCAN_CAR,[Public sharedPublic].userInfo.userID,[Public getMac]];
         NSLog(@"=================================================%@",path);
    } else {
        path = [NSString stringWithFormat:@"%@/user_id/0/session_id/%@",DIANCAN_CAR,[Public getMac]];
    }
    [GCDServer serverWithUrl:path complete:^(NSData * data) {
        NSMutableArray * arr = [JSON getFoodsInShoppingCart:data];
//        self.cartInfo.foodsArray = arr;
        if (!arr.count) {
            [self reloadView];
            return;
        }
        CartFoodInfo * info0 = arr[0];
        self.cartInfo.userID = info0.userID;
        self.cartInfo.restaurID = info0.restaurID;
        
        if (![Public sharedPublic].restInfo || ![self.cartInfo.restaurID isEqualToString:[Public sharedPublic].restInfo.restaurID]) {
            [self downloadRest];
        }
        
        if (![self.restInfo.restaurID isEqualToString:info0.restaurID]) {
            self.cartInfo.foodsArray = arr;
            for (CartFoodInfo * cfInfo in arr) {
                self.cartInfo.totalCopies += cfInfo.quantity.intValue;
                self.cartInfo.totalPrice += cfInfo.quantity.intValue * cfInfo.price.floatValue;
            }
            [self reloadView];
            return;
        }
        for (CartFoodInfo * cfInfo in arr) {
            self.cartInfo.totalCopies += cfInfo.quantity.intValue;
            self.cartInfo.totalPrice += cfInfo.quantity.intValue * cfInfo.price.floatValue;
            for (int i = 0; i < self.resourceArray.count; i++) {
                FoodInfo * info = self.resourceArray[i];
                if ([info.foodID isEqualToString:cfInfo.foodID]) {
                    info.carID = cfInfo.carID;
                    info.copies = cfInfo.quantity.intValue;
                    [self.resourceArray replaceObjectAtIndex:i withObject:info];
                    [self.cartInfo.foodsArray addObject:info];
                }
            }
        }
        
        [self reloadView];
    }];
}
- (void)downloadRest
{
    NSString * urlPath = [NSString stringWithFormat:@"%@/storedata/store_id/%@",DIANCAN_VIEW,self.cartInfo.restaurID];
    [GCDServer serverWithUrl:urlPath complete:^(NSData * data) {
        NSArray * arr = [JSON getRestaurs:data];
        if (arr && arr.count == 1) {
            [Public sharedPublic].restInfo = arr[0];
            [self reloadView];
        }
    }];
}
//- (NSString *)getCarId:(NSString *)foodId
//{
//    for (CartFoodInfo * info in self.cartInfo.foodsArray) {
//        if ([info.foodID isEqualToString:foodId]) {
//            return info.carID;
//        }
//    }
//    return nil;
//}
- (void)setNav
{
    [self resetTitleView:self.restInfo.restaurName];
    [self setBackItem:@selector(backPop)];
    [self setRightItem:@"餐厅介绍" sel:@selector(viewRestaurantInfo)];
}

- (void)createOptionButton
{
    for (int i = 0; i < 2; i++) {
        UIButton *btn = [[UIButton alloc] init];
        btn.frame = CGRectMake(SELF_VIEW_WIDTH / 2 * i,
                               SELF_VIEW_ORIGIN_Y,
                               SELF_VIEW_WIDTH / 2,
                               kSegmentButtonHeight);
        btn.tag = TAG_MIN + i;
        [btn setBackgroundImage:[UIImage imageNamed:@"food_option_unselected.jpg"]
                       forState:UIControlStateNormal];
        [btn setBackgroundImage:[UIImage imageNamed:@"food_option_selected.jpg"]
                       forState:UIControlStateSelected];
        [btn setBackgroundImage:[UIImage imageNamed:@"food_option_selected.jpg"]
                       forState:UIControlStateHighlighted];
        [btn setBackgroundImage:[UIImage imageNamed:@"food_option_selected.jpg"]
                       forState:UIControlStateHighlighted | UIControlStateSelected];
        if (0 == i) {
            btn.selected = YES;
            [btn setTitle:@"菜单分类" forState:UIControlStateNormal];
        } else {
            [btn setTitle:@"排序" forState:UIControlStateNormal];
        }
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        btn.adjustsImageWhenHighlighted = NO;
        btn.showsTouchWhenHighlighted = NO;
        [btn addTarget:self
                action:@selector(optionBtnClick:)
                forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn];
    }
}


#pragma mark - 筛选/排序/其它 下拉菜单

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
    [self createTableView:TableViewTypeOption];
}

- (void)createOptionMiddleView
{
    UIView *midOptionView = [[UIView alloc] init];
    midOptionView.frame = CGRectMake(0, 0, VIEW_WIDTH(self.bgOptionView), VIEW_HEIGHT(self.bgOptionView) / 3 * 2);
    midOptionView.backgroundColor = [UIColor whiteColor];
    [self.bgOptionView addSubview:midOptionView];
    self.midOptionView = midOptionView;
}

- (void)createBottomView
{
    UIView *bottomView = [[UIView alloc] init];
    bottomView.frame = CGRectMake(0,
                                  VIEW_HEIGHT(self.midOptionView),
                                  VIEW_WIDTH(self.bgOptionView),
                                  VIEW_HEIGHT(self.bgOptionView) - VIEW_HEIGHT(self.midOptionView));
    UITapGestureRecognizer *tgr = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(bgOptionViewPressed:)];
    [bottomView addGestureRecognizer:tgr];
    [self.bgOptionView addSubview:bottomView];
}


#pragma mark 美食详情

- (void)createFoodDetailView
{
    [self createBgFoodDetailView];
    
    UIView *foodDetailView = [[UIView alloc] init];
    foodDetailView.frame = CGRectMake(0, 0, 260.0f, 360.0f);
    foodDetailView.center = self.bgFoodDetailView.center;
    foodDetailView.backgroundColor = [UIColor whiteColor];
    foodDetailView.layer.cornerRadius = 2.0f;
    [self.bgFoodDetailView addSubview:foodDetailView];
    self.foodDetailView = foodDetailView;
    
    [self createFoodDetailButton];
}

- (void)createFoodDetailButton
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(10.0f,
                           VIEW_HEIGHT(self.foodDetailView) - 40.0f,
                           VIEW_WIDTH(self.foodDetailView) - 20.0f,
                           30.0f);
    btn.backgroundColor = [UIColor orangeColor];
    btn.layer.cornerRadius = 3.0f;
    [btn setTitle:@"确认" forState:UIControlStateNormal];
    [btn addTarget:self
            action:@selector(foodDetailBtnClick:)
            forControlEvents:UIControlEventTouchUpInside];
    [self.foodDetailView addSubview:btn];
}

- (void)createBgFoodDetailView
{
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    UIView *bgFoodDetailView = [[UIView alloc] init];
    bgFoodDetailView.frame = window.bounds;
    bgFoodDetailView.backgroundColor = [UIColor colorWithWhite:0.0f alpha:0.40f];
    bgFoodDetailView.hidden = YES;
    [window addSubview:bgFoodDetailView];
    self.bgFoodDetailView = bgFoodDetailView;
}


#pragma mark - 购物车

- (void)createCartView
{
    CGRect frame = CGRectMake(0,
                              SELF_VIEW_HEIGHT - kCartViewHeight,
                              SELF_VIEW_WIDTH,
                              kCartViewHeight);
    VCCartView *cartView = [[VCCartView alloc] initWithFrame:frame];
    [cartView.settleAccountButton addTarget:self
                                     action:@selector(settleAccount)
                           forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:cartView];
    self.carView = cartView;
}


#pragma mark MJRefreshView

- (void)createMJRefreshView
{
//    self.mjHeaderView = [MJRefreshHeaderView header];
//    self.mjHeaderView.scrollView = self.normalTableView;
//    
//    self.mjFooterView = [MJRefreshFooterView footer];
//    self.mjFooterView.scrollView = self.normalTableView;
    
    
     
     MJRefreshHeaderView *mjHeaderView = [MJRefreshHeaderView header];
     mjHeaderView.scrollView = self.normalTableView;
     mjHeaderView.delegate = self;
     self.mjHeaderView = mjHeaderView;
     
     MJRefreshFooterView *mjFooterView = [MJRefreshFooterView footer];
     mjFooterView.scrollView = self.normalTableView;
     mjFooterView.delegate = self;
     self.mjFooterView = mjFooterView;
    
}


#pragma mark -
#pragma mark - talbeView
- (void)createTableView
{
    CGRect frame = CGRectMake(0,
                              SELF_VIEW_ORIGIN_Y + kSegmentButtonHeight,
                              SELF_VIEW_WIDTH,
                              SELF_VIEW_HEIGHT - SELF_VIEW_ORIGIN_Y - kSegmentButtonHeight - kCartViewHeight);
    UITableView *foodsTableView = [[UITableView alloc] initWithFrame:frame style:UITableViewStylePlain];
    if (IOS_VERSION >= 7.0) {
        [foodsTableView setSeparatorInset:UIEdgeInsetsZero];
    }
    foodsTableView.backgroundColor = [UIColor whiteColor];
    foodsTableView.showsVerticalScrollIndicator = NO;
    foodsTableView.dataSource = self;
    foodsTableView.delegate = self;
    [self.view addSubview:foodsTableView];
}

- (void)createTableView:(TableViewType)type
{
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
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
    
    
    if (TableViewTypeNormal == type) {                      //  美食列表
        tableView.frame = CGRectMake(0,
                                     SELF_VIEW_ORIGIN_Y + kSegmentButtonHeight,
                                     SELF_VIEW_WIDTH,
                                     SELF_VIEW_HEIGHT - SELF_VIEW_ORIGIN_Y - kSegmentButtonHeight - kCartViewHeight);
        tableView.contentInset = UIEdgeInsetsMake(0, 0, 5.0f, 0);
        [self.view addSubview:tableView];
        self.normalTableView = tableView;
        
        
    } else if (TableViewTypeOption == type) { //  筛选/排序右侧选项列表
        tableView.frame = CGRectMake(0,
                                     0,
                                     VIEW_WIDTH(self.midOptionView),
                                     VIEW_HEIGHT(self.midOptionView));;
        tableView.backgroundColor = [UIColor colorWithRed:0.85f green:0.85f blue:0.85f alpha:1.00f];
        [self.midOptionView addSubview:tableView];
        self.optionTableView = tableView;
    }
}


#pragma mark - tableViewDataSource talbeViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (TAG_MIN + TableViewTypeNormal == tableView.tag) {
        return self.resourceArray.count;
    } else if (TAG_MIN + TableViewTypeOption == tableView.tag) {
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
        return 100.0f;
    }
    return 40.0f;
}


#pragma mark cellForRow

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (TAG_MIN + TableViewTypeNormal == tableView.tag) {
        static NSString *cellName = @"FoodCell";
        FoodCell *cell = [tableView dequeueReusableCellWithIdentifier:cellName];
        if (cell == nil) {
            cell = [[[NSBundle mainBundle] loadNibNamed:cellName owner:self options:nil] lastObject];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            [cell.foodFavoriteBtn setImage:[UIImage imageNamed:@"restaur_favorite_unselected.png"]
                                 forState:UIControlStateNormal];
            [cell.foodFavoriteBtn setImage:[UIImage imageNamed:@"restaur_favorite_selected.png"]
                                  forState:UIControlStateSelected];
            [cell.foodFavoriteBtn addTarget:self
                                     action:@selector(favorite:)
                                     forControlEvents:UIControlEventTouchUpInside];
            cell.foodAddBtn.tag = TAG_MIN + 100;
            cell.foodMinusBtn.tag = TAG_MIN + 101;
            [cell.foodAddBtn addTarget:self
                                action:@selector(changeCopies:)
                                forControlEvents:UIControlEventTouchUpInside];
            
            [cell.foodMinusBtn addTarget:self
                                  action:@selector(changeCopies:)
                                  forControlEvents:UIControlEventTouchUpInside];
            
        }
        FoodInfo * info = self.resourceArray[indexPath.row];
        cell.foodFavoriteBtn.selected = info.favorite;
        cell.foodNameLabel.text = info.foodName;
        cell.foodPriceLabel.text = [NSString stringWithFormat:@"￥%@/份",info.price];
        cell.starsView.stars = info.stars;
        cell.foodPraisesLabel.text = [NSString stringWithFormat:@"%@人点过",info.sales];
        cell.foodFavoriteBtn.indexPath = indexPath;
        cell.foodFavoriteBtn.site_id = info.foodID;
        cell.foodFavoriteBtn.selected = info.favorite;
        cell.foodAddBtn.indexPath = indexPath;
        cell.foodMinusBtn.indexPath = indexPath;
        cell.foodCopiesLabel.text = [NSString stringWithFormat:@"%d", info.copies];
        cell.foodCopiesLabel.hidden = !(BOOL)info.copies;
        cell.foodMinusBtn.hidden = !(BOOL)info.copies;
        [cell.foodIconImgView setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://dingcan.viewcreator3d.cn%@",info.foodIcon]] placeholderImage:[UIImage imageNamed:@"food_icon_temp"]];
        
        return cell;
    }  else if (TAG_MIN + TableViewTypeOption == tableView.tag) {
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
        if (0 == self.currentSelectedOptionButton) {
            if (indexPath.row == self.option.cuisine) {
                cell.textLabel.textColor = [UIColor redColor];
            } else {
                cell.textLabel.textColor = [UIColor blackColor];
            }
        } else if (1 == self.currentSelectedOptionButton) {
            if (indexPath.row == self.option.sortOption) {
                cell.textLabel.textColor = [UIColor redColor];
            } else {
                cell.textLabel.textColor = [UIColor blackColor];
            }
        }
        return cell;
    }
    return nil;
}

#pragma mark -
#pragma mark - 事件处理


#pragma mark - cellSelected
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (TAG_MIN + TableViewTypeNormal == tableView.tag) {
//        FoodListViewController *flVC = [[FoodListViewController alloc] init];
//        [self.navigationController pushViewController:flVC animated:YES];
//        self.bgFoodDetailView.hidden = NO;
        
        
        FoodInfo * info = self.resourceArray[indexPath.row];
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:info.foodName message:info.brief delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
        
    } else if (TAG_MIN + TableViewTypeOption == tableView.tag) {
        if (0 == self.currentSelectedOptionButton) {
            self.option.cuisine = indexPath.row;
        
        } else if (1 == self.currentSelectedOptionButton) {
            self.option.sortOption = indexPath.row;
            [self rightSortWithIndex:indexPath.row];
        }
        [self.optionTableView reloadData];
        self.bgOptionView.hidden = YES;
        if (self.selectedOptionButton) {
            self.selectedOptionButton.selected = NO;
        }
    }
}
- (void)rightSortWithIndex:(NSInteger)index
{
    
    for (int i = 0; i < self.resourceArray.count -1; i++) {
        FoodInfo * infoi = self.resourceArray[i];
        for (int j = 1; j < self.resourceArray.count; j++) {
            FoodInfo * infoj = self.resourceArray[j];
            if (index == 1) {
                if (infoi.sales.floatValue < infoj.sales.floatValue) {
                    [self.resourceArray exchangeObjectAtIndex:i withObjectAtIndex:j];
                }
            } else if (index == 2) {
                if (infoi.price.floatValue > infoj.price.floatValue) {
                    [self.resourceArray exchangeObjectAtIndex:i withObjectAtIndex:j];
                }
            } else if (index == 3) {
                if (infoi.stars < infoj.stars) {
                    [self.resourceArray exchangeObjectAtIndex:i withObjectAtIndex:j];
                }
            }
        }
    }
    [self.normalTableView reloadData];
    
}

#pragma mark MJRefreshBaseViewDelegate

- (void)refreshViewBeginRefreshing:(MJRefreshBaseView *)refreshView
{
    if (self.normalTableView.contentOffset.y < 0) {
        self.pagenum = 0;
    } else {
        self.pagenum++;
    }
    [self downloadData:self.pagenum];
}

- (void)refreshViewEndRefreshing:(MJRefreshBaseView *)refreshView
{
    
}


#pragma mark 当前网络状态

- (BOOL)networkStatus
{
    if (NotNetworkStatu == [Public sharedPublic].networkState) {
        [SVProgressHUD showErrorWithStatus:@"无法下载数据，请检查你的网络！" duration:0.5f];
        return NO;
    }
    return YES;
}

#pragma mark 菜单分类/排序

- (void)optionBtnClick:(UIButton *)btn
{
    if (btn.selected && !self.isFirstClickOptionButton) {
        btn.selected = NO;
        self.currentSelectedOptionButton = -1;
        self.selectedOptionButton = nil;
        self.bgOptionView.hidden = YES;
    } else {
        self.isFirstClickOptionButton = NO;
        UIButton *anotherBtn = (UIButton *)[self.view viewWithTag:2 * TAG_MIN + 1 - btn.tag];
        anotherBtn.selected = NO;
        btn.selected = YES;
        self.currentSelectedOptionButton = btn.tag - TAG_MIN;
        self.selectedOptionButton = btn;
        self.bgOptionView.hidden = NO;
        if (TAG_MIN == btn.tag) {
            self.dataArray = self.leftArray;
        } else {
            self.dataArray = self.rightArray;
        }
        [self.optionTableView reloadData];
    }
}

- (void)bgOptionViewPressed:(UITapGestureRecognizer *)tgr
{
    self.currentSelectedOptionButton = -1;
    self.bgOptionView.hidden = YES;
    if (self.selectedOptionButton) {
        self.selectedOptionButton.selected = NO;
    }
    self.selectedOptionButton = nil;
}


#pragma mark 美食详情

- (void)foodDetailBtnClick:(UIButton *)btn
{
    self.bgFoodDetailView.hidden = YES;
}


#pragma mark 收藏

- (void)favorite:(VCButton *)favoriteBtn
{
    if ([Public sharedPublic].userInfo.userID == nil) {
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"登陆后可收藏美食" message:nil delegate:self cancelButtonTitle:@"以后再说" otherButtonTitles:@"登陆注册", nil];
        alert.tag = 500;
        [alert show];
        return;
    }
    NSString * path = [NSString stringWithFormat:@"%@/%@/goods_id/%@/user_id/%@",DIANCAN_VIEW1,(favoriteBtn.selected ? @"del_collect_goods" : @"collect_goods"),favoriteBtn.site_id,[Public sharedPublic].userInfo.userID];
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
        if (alertView.tag == 500) {
            [self presentViewController:[[BaseNavigationController alloc] initWithRootViewController:[[LoginViewController alloc] init]] animated:YES completion:nil];
        } else if (alertView.tag == 501) {
            NSArray * arr = self.cartInfo.foodsArray;
            
            for (int i = 0; i < arr.count; i++) {
                CartFoodInfo * info = arr[i];
                NSString * path = [NSString stringWithFormat:@"%@/delcar/rec_id/%@",DIANCAN_VIEW1,info.carID];
                [GCDServer serverWithUrl:path complete:^(NSData * data) {
                    NSDictionary * dict = [JSON jsonParse:data];
                    if ([dict[@"status"] isEqualToNumber:@1]) {
                        [SVProgressHUD showSuccessWithStatus:dict[@"msg"]];
                        self.cartInfo= nil;
                        self.cartInfo = [[CartInfo alloc] init];
                        [Public sharedPublic].restInfo = nil;
                        [self reloadView];
                    } else {
                        [SVProgressHUD showErrorWithStatus:dict[@"msg"]];
                    }
                }];
            }
            
        }
    }
    if (buttonIndex == 0) {
        NSLog(@"111");
    }
}


#pragma mark 改变份数

- (void)changeCopies:(VCButton *)btn
{
    FoodInfo *foodInfo = [self getFoodInfoWithButton:btn];
    
    
//    if ([Public sharedPublic].restInfo && ![self.restInfo.restaurID isEqualToString:[Public sharedPublic].restInfo.restaurID]) {
//        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"购物车" message:@"是否把美食放在一起" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"清空", nil];
//        alert.tag = 501;
//        [alert show];
//        return;
//    }
    
    if ([Public sharedPublic].restInfo && ![self.restInfo.restaurID isEqualToString:[Public sharedPublic].restInfo.restaurID]) {
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"购物车" message:@"清空后才能添加所点美食" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"清空", nil];
        alert.tag = 501;
        [alert show];
        return;
    }
    
    
    if (TAG_MIN + 100 == btn.tag) {
        [self addcartWithFood:foodInfo];
        [self cartInfoChanged:foodInfo isAdd:YES];
        [self cartArrayWith:foodInfo isAdd:YES];
        [self animation:btn];
        
    } else {
        [self deleteWithFood:foodInfo];
        [self cartInfoChanged:foodInfo isAdd:NO];
        [self cartArrayWith:foodInfo isAdd:NO];
        [self cartViewChanged];
    }
    [self.normalTableView reloadRowsAtIndexPaths:@[btn.indexPath]
                                withRowAnimation:UITableViewRowAnimationNone];
}
- (void)addcartWithFood:(FoodInfo *)info
{
    NSString * userid = [Public sharedPublic].userInfo.userID ? [Public sharedPublic].userInfo.userID:@"0";
    NSString * path;
    if (!info.carID || info.copies == 0) {
       path = [NSString stringWithFormat:@"%@/cart/user_id/%@/session_id/%@/goods_id/%@/quantity/%d",DIANCAN_VIEW2,userid,[Public getMac],info.foodID,1];
    } else {
        path = [NSString stringWithFormat:@"%@/editcar/rec_id/%@/quantity/%d",DIANCAN_VIEW1,info.carID,(info.copies+1)];
    }
    [GCDServer serverWithUrl:path complete:^(NSData * data) {
        NSDictionary * dict = [JSON jsonParse:data];
        if ([dict[@"status"] isEqualToNumber:@1]) {
            [SVProgressHUD showSuccessWithStatus:dict[@"msg"]];
            [self downloadCart];
            
        } else {
            [SVProgressHUD showErrorWithStatus:dict[@"msg"]];
        }
    }];
}
- (void)deleteWithFood:(FoodInfo *)info
{
    NSString * path;
    if (info.copies > 1) {
        path = [NSString stringWithFormat:@"%@/editcar/rec_id/%@/quantity/%d",DIANCAN_VIEW1,info.carID,info.copies-1];
    } else {
        path = [NSString stringWithFormat:@"%@/delcar/rec_id/%@",DIANCAN_VIEW1,info.carID];
        
    }
    [GCDServer serverWithUrl:path complete:^(NSData * data) {
        NSDictionary * dict = [JSON jsonParse:data];
        if ([dict[@"status"] isEqualToNumber:@1]) {
            [SVProgressHUD showSuccessWithStatus:dict[@"msg"]];
            [self downloadCart];
//            if (info.copies == 1) {
//                
//            }
        } else {
            [SVProgressHUD showErrorWithStatus:dict[@"msg"]];
        }
    }];
}
#pragma mark gcdser
//- (void)addcartWithId:(NSString *)goodsid num:(int)num
//{
//    NSString * userid = [Public sharedPublic].userInfo.userID ? [Public sharedPublic].userInfo.userID:@"0";
//    NSString * path = [NSString stringWithFormat:@"%@/cart/user_id/%@/session_id/%@/goods_id/%@/quantity/%d",DIANCAN_VIEW2,userid,[Public getMac],goodsid,num];
//    [GCDServer serverWithUrl:path complete:^(NSData * data) {
//        NSDictionary * dict = [JSON jsonParse:data];
//        if ([dict[@"status"] isEqualToNumber:@1]) {
//            [SVProgressHUD showSuccessWithStatus:dict[@"msg"]];
////            [self downloadCart];
//        } else {
//            [SVProgressHUD showErrorWithStatus:dict[@"msg"]];
//        }
//    }];
//}
//- (void)editCartWithId:(NSString *)recid num:(int)num
//{
//    NSString * path = [NSString stringWithFormat:@"%@/editcar/rec_id/%@/quantity/%d",DIANCAN_VIEW1,recid,num];
//    [GCDServer serverWithUrl:path complete:^(NSData * data) {
//        NSDictionary * dict = [JSON jsonParse:data];
//        if ([dict[@"status"] isEqualToNumber:@1]) {
//            [SVProgressHUD showSuccessWithStatus:dict[@"msg"]];
////            [self downloadCart];
//        } else {
//            [SVProgressHUD showErrorWithStatus:dict[@"msg"]];
//        }
//    }];
//}
//- (void)deleteWithId:(NSString *)recid
//{
//    NSString * path = [NSString stringWithFormat:@"%@/delcar/rec_id/%@",DIANCAN_VIEW1,recid];
//    [GCDServer serverWithUrl:path complete:^(NSData * data) {
//        NSDictionary * dict = [JSON jsonParse:data];
//        if ([dict[@"status"] isEqualToNumber:@1]) {
//            [SVProgressHUD showSuccessWithStatus:dict[@"msg"]];
////            [self downloadCart];
//        } else {
//            [SVProgressHUD showErrorWithStatus:dict[@"msg"]];
//        }
//    }];
//}

#pragma mark 改变cartInfo的总份数和总钱数

- (void)cartInfoChanged:(FoodInfo *)foodInfo isAdd:(BOOL)isAdd
{
    self.cartInfo.totalCopies = isAdd ?
                                    self.cartInfo.totalCopies + 1 :
                                    self.cartInfo.totalCopies - 1;
    
    self.cartInfo.totalPrice = isAdd ?
                                    self.cartInfo.totalPrice + foodInfo.price.floatValue :
                                    self.cartInfo.totalPrice - foodInfo.price.floatValue;
//    [self cartViewChanged];
//    [self performSelector:@selector(cartViewChanged) withObject:nil afterDelay:1];
}

#pragma mark 遍历cartInfo的foodsArray，做相应的操作

- (void)cartArrayWith:(FoodInfo *)foodInfo isAdd:(BOOL)isAdd
{
    for (FoodInfo *food in self.cartInfo.foodsArray) {
        if ([foodInfo.foodID isEqualToString:food.foodID]) {
            //  对应FoodInfo对象份数+1/-1
            food.copies = isAdd ? food.copies + 1 : food.copies -1;
            if (0 == food.copies && !isAdd) {
                [self cartArrayChange:food isAdd:isAdd];
            }
            return;
        }
    }
    
    //  如果cartArray中没有foodInfo这个对象
    [self cartArrayChange:foodInfo isAdd:isAdd];
}

#pragma mark 对底部的cartView的总份数总钱数的Label从新赋值

- (void)cartViewChanged
{
    self.carView.copiesLabel.text = [NSString stringWithFormat:@"%d份", self.cartInfo.totalCopies];
    self.carView.priceLabel.text = [NSString stringWithFormat:@"￥%.2f",self.cartInfo.totalPrice];
    if (0 == self.cartInfo.totalCopies) {
        self.carView.priceLabel.text = @"购物车空空的";
        self.carView.priceLabel.textColor =[UIColor orangeColor];
    }
    
    //[UIColor colorWithRed:1.00f green:0.89f blue:0.02f alpha:1.00f];
    if ([Public sharedPublic].restInfo && [Public sharedPublic].restInfo.minPrice.floatValue <= self.cartInfo.totalPrice) {
        self.carView.settleAccountButton.backgroundColor = [UIColor colorWithRed:1.00f
                                                                           green:0.89f
                                                                            blue:0.02f
                                                                           alpha:1.00f];
    } else {
        self.carView.settleAccountButton.backgroundColor = [UIColor grayColor];
    }
}

- (void)cartArrayChange:(FoodInfo *)foodInfo isAdd:(BOOL)isAdd
{
    if (isAdd) {
        foodInfo.copies = 1;
        [self.cartInfo.foodsArray addObject:foodInfo];
    } else {
        [self.cartInfo.foodsArray removeObject:foodInfo];
    }
}

#pragma mark 增加份数的动画

- (void)animation:(VCButton *)btn
{
    UIWindow *keyWindow = [[UIApplication sharedApplication] keyWindow];
    
    CATextLayer *addTextLayer = [[CATextLayer alloc] init];
    addTextLayer.backgroundColor = [[UIColor clearColor] CGColor];
    [addTextLayer setFontSize:15.0f];
    addTextLayer.string = @"hello";
    addTextLayer.foregroundColor = [[UIColor darkGrayColor] CGColor];
    [keyWindow.layer addSublayer:addTextLayer];
    
    CGPoint newAddOrigin = [keyWindow convertPoint:btn.frame.origin fromView:btn.superview];
    addTextLayer.frame = CGRectMake(newAddOrigin.x - 30.0f, newAddOrigin.y - 5.0f, 20.0f, 20.0f);
    
    
    [CATransaction begin];
    [CATransaction setValue:(id)kCFBooleanTrue forKey:kCATransactionDisableActions];
    [CATransaction commit];
    
    UIBezierPath *bezierPath = [UIBezierPath bezierPath];
    [bezierPath moveToPoint:addTextLayer.position];
    CGPoint controlPoint = CGPointMake(newAddOrigin.x - 140.0f, newAddOrigin.y  - 80.0f);
    
    CGPoint toPoint = [keyWindow convertPoint:self.carView.copiesLabel.center
                                     fromView:self.carView];
    [bezierPath addQuadCurveToPoint:toPoint controlPoint:controlPoint];
    
    //  animationWithKeyPath:的参数为`position`，其它的可能动画不执行
    CAKeyframeAnimation *keyAnimation = [CAKeyframeAnimation
                                         animationWithKeyPath:@"position"];
    keyAnimation.path = bezierPath.CGPath;
    keyAnimation.removedOnCompletion = NO;
    
    CAAnimationGroup *group = [CAAnimationGroup animation];
    group.beginTime = CACurrentMediaTime();
    group.duration = 1.0f;
    group.animations = [NSArray arrayWithObjects:keyAnimation, nil];
    group.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    group.delegate = self;
    group.fillMode = kCAFillModeForwards;
    group.removedOnCompletion = NO;
    group.autoreverses = NO;
    
    [addTextLayer addAnimation:group forKey:@"FoodList_Add_Copies"];
    
    NSDictionary *dict = [[NSDictionary alloc] initWithObjectsAndKeys:addTextLayer, @"layer",
                          btn, @"button", nil];
    
    [self performSelector:@selector(addCopiesAnimationFinish:)
               withObject:dict
               afterDelay:1.0f];
}


#pragma mark 增加钱数动画

- (void)addCopiesAnimationFinish:(NSDictionary *)dict
{
    CALayer *layer = (CALayer *)[dict objectForKey:@"layer"];
    
    [layer removeFromSuperlayer];
    layer = nil;
    
    VCButton *btn = (VCButton *)[dict objectForKey:@"button"];
    FoodInfo *food = (FoodInfo *)[self.resourceArray objectAtIndex:btn.indexPath.row];
    [self cartViewChanged];
    
    
    CATextLayer *transitionLayer = [[CATextLayer alloc] init];
    transitionLayer.frame = CGRectMake(90, 430.0f, 40.0f, 20.0f);
    transitionLayer.opacity = 1.0f;
    transitionLayer.backgroundColor = [[UIColor clearColor] CGColor];
    transitionLayer.string = food.price;
    [transitionLayer setFontSize:14.0f];
    transitionLayer.foregroundColor = [[UIColor lightGrayColor] CGColor];
    [self.view.layer addSublayer:transitionLayer];
    
    [CATransaction begin];
    [CATransaction setValue:(id)kCFBooleanTrue forKey:kCATransactionDisableActions];
    [CATransaction commit];
    
    CABasicAnimation *positionAnimation = [CABasicAnimation animationWithKeyPath:@"position"];
    CGPoint fromPoint = CGPointMake(110.0f, 450.0f);
    CGPoint toPoint = CGPointMake(130.0f, 430.0f);
    positionAnimation.fromValue = [NSValue valueWithCGPoint:fromPoint];
    positionAnimation.toValue = [NSValue valueWithCGPoint:toPoint];
    
    CABasicAnimation *opacityAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    opacityAnimation.fromValue = [NSNumber numberWithFloat:1.0f];
    opacityAnimation.toValue = [NSNumber numberWithFloat:0.0f];
    
    CABasicAnimation *rotateAnimation = [CABasicAnimation animationWithKeyPath:@"rotate"];
    rotateAnimation.fromValue = [NSNumber numberWithFloat:0 * M_PI];
    rotateAnimation.toValue = [NSNumber numberWithFloat:2 * M_PI];
    
    CAAnimationGroup *group = [CAAnimationGroup animation];
    group.beginTime = CACurrentMediaTime();
    group.duration = 0.4f;
    group.animations = [NSArray arrayWithObjects:positionAnimation,
                                                 opacityAnimation,
                                                 rotateAnimation,
                                                 nil];
    
    group.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    group.delegate = self;
    group.fillMode = kCAFillModeForwards;
    group.removedOnCompletion = NO;
    group.autoreverses = NO;
    [transitionLayer addAnimation:group forKey:@"transform"];
}


#pragma mark 获取FoodInfo对象

- (FoodInfo *)getFoodInfoWithButton:(VCButton *)btn
{
    return [self.resourceArray objectAtIndex:btn.indexPath.row];
}

- (FoodInfo *)getFoodInfoWithIndexPath:(NSIndexPath *)indexPath
{
    return [self.resourceArray objectAtIndex:indexPath.row];
}


#pragma mark 跳转到店铺详情

- (void)viewRestaurantInfo
{
    RestaurInfoViewController *riVC = [[RestaurInfoViewController alloc] init];
    riVC.restInfo = self.restInfo;
    [self.navigationController pushViewController:riVC animated:YES];
}


#pragma mark 跳转到购物车
- (void)settleAccount
{
    RestaurInfo * Pinfo = [Public sharedPublic].restInfo;
    NSLog(@"%@",[Public sharedPublic].restInfo.restaurName);
    if (Pinfo && Pinfo.minPrice.floatValue <= self.cartInfo.totalPrice) {
        CartViewController *cVC = [[CartViewController alloc] init];
//        cVC.cartInfo = self.cartInfo;
//        cVC.cartDelegate = self;
        
        cVC.isTiao =YES;
        [self.navigationController pushViewController:cVC animated:YES];
    } else {
//        //  提示
        [SVProgressHUD showErrorWithStatus:@"你的订餐还不够起送底线哦" duration:0.8f];
    }
    
}


#pragma mark CartViewContorllerDelegate

- (void)reloadView
{
    [self.normalTableView reloadData];
    [self cartViewChanged];
}

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

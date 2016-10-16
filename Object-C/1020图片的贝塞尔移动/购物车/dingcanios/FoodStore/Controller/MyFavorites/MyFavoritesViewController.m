//
//  MyFavoritesViewController.m
//  FoodStore
//
//  Created by liuguopan on 14/12/19.
//  Copyright (c) 2014年 viewcreator3d. All rights reserved.
//

#import "MyFavoritesViewController.h"
#import "FoodListViewController.h"
#import "RestaurCell.h"
#import "FoodCell.h"
#import "VCCartView.h"
#import "CartViewController.h"

@interface MyFavoritesViewController () <UITableViewDataSource,
UITableViewDelegate,UIAlertViewDelegate>
{
    NSInteger _select;
    UIView * _line;
    NSString * path;
   
}
@property (nonatomic,strong) UITableView * tableView;
@property (nonatomic,strong) NSMutableArray * restArr;
@property (nonatomic,strong) NSMutableArray * foodArr;
@property (nonatomic,strong) UserInfo * info;
@property (nonatomic,strong) VCCartView *carView;
@property (nonatomic,strong) CartInfo *cartInfo;
//@property (nonatomic, strong) MJRefreshHeaderView *mjHeaderView;        //  下拉刷新
@end

@implementation MyFavoritesViewController

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
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if (_select == 0) {
        [self initRestArr];
    } else {
        [self initFoodArr];
    }
}
- (void)initRestArr
{
    [_restArr removeAllObjects];
//    [_tableView reloadData];
    _info = [Public sharedPublic].userInfo;
    if (_info.userID == nil) {
        return;
    }
    NSString * restPath = [NSString stringWithFormat:@"%@/user_collect_store/user_id/%@",DIANCAN_VIEW1,_info.userID];
    [GCDServer serverWithUrl:restPath complete:^(NSData * data) {
        
        _restArr = [JSON getRestaurs:data];
        [_tableView reloadData];
        
    }];
    
}
- (void)initFoodArr
{
    
    [_foodArr removeAllObjects];
//    [_tableView reloadData];
    _info = [Public sharedPublic].userInfo;
    if (_info.userID == nil) {
        return;
    }
    
    NSString * foodPath = [NSString stringWithFormat:@"%@/user_collect_goods/user_id/%@",DIANCAN_VIEW1,_info.userID];
    [GCDServer serverWithUrl:foodPath complete:^(NSData * data) {
        
        _foodArr = [JSON getFoods:data];
        for (FoodInfo * info in _foodArr) {
            info.favorite = YES;
        }
        [_tableView reloadData];
        
        [self downloadCart];
        
    }];
    
}
#pragma mark downloadCart
- (void)downloadCart
{
    if (self.cartInfo == nil) {
        self.cartInfo = [[CartInfo alloc] init];
    } else {
        self.cartInfo.totalCopies = 0;
        self.cartInfo.totalPrice = 0;
    }
    path = [NSString stringWithFormat:@"%@/user_id/%@/session_id/%@",DIANCAN_CAR,[Public sharedPublic].userInfo.userID,[Public getMac]];
    [GCDServer serverWithUrl:path complete:^(NSData *data) {
        NSMutableArray * arr = [JSON getFoodsInShoppingCart:data];

        if (!arr.count) {
            [self reloadView];
            return;
        }
        self.cartInfo.foodsArray = arr;
        CartFoodInfo * info0 = arr[0];
        self.cartInfo.userID = info0.userID;
        self.cartInfo.restaurID = info0.restaurID;
        
        if (![Public sharedPublic].restInfo || ![self.cartInfo.restaurID isEqualToString:[Public sharedPublic].restInfo.restaurID]) {
            [self downloadRest];
        }
//        if (![self.restInfo.restaurID isEqualToString:info0.restaurID]) {
//            self.cartInfo.foodsArray = arr;
//            for (CartFoodInfo * cfInfo in arr) {
//                self.cartInfo.totalCopies += cfInfo.quantity.intValue;
//                self.cartInfo.totalPrice += cfInfo.quantity.intValue * cfInfo.price.floatValue;
//            }
//            [self reloadView];
//            return;
//        }
        
        for (CartFoodInfo * cfInfo in arr) {
            self.cartInfo.totalCopies += cfInfo.quantity.intValue;
            self.cartInfo.totalPrice += cfInfo.quantity.intValue * cfInfo.price.floatValue;
            for (int i = 0; i < self.foodArr.count; i++) {
                FoodInfo * info = self.foodArr[i];
                if ([info.foodID isEqualToString:cfInfo.foodID]) {
                    info.carID = cfInfo.carID;
                    info.copies = cfInfo.quantity.intValue;
                    [self.foodArr replaceObjectAtIndex:i withObject:info];
//                    [self.cartInfo.foodsArray addObject:info];
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
- (void)reloadView
{
    [self.tableView reloadData];
    [self cartViewChanged];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setNav];
    [self initData];
    [self initView];
    //[self createMJRefreshView];
}
//- (void)createMJRefreshView
//{
//    MJRefreshHeaderView *mjHeaderView = [MJRefreshHeaderView header];
//    mjHeaderView.scrollView = self.tableView;
//    mjHeaderView.delegate = self;
//    self.mjHeaderView = mjHeaderView;
//
//}
- (void)initData
{
    _foodArr = [[NSMutableArray alloc] initWithCapacity:0];
    _restArr = [[NSMutableArray alloc] initWithCapacity:0];
}
- (void)initView
{
    [self setSelect];
    [self setTable];
    [self createCartView];
}
- (void)setTable
{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 110, 320, SELF_VIEW_HEIGHT-110) style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.showsHorizontalScrollIndicator = NO;
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.backgroundColor = [UIColor clearColor];
    if (IOS_VERSION>=7.0) {
        [_tableView setSeparatorInset:UIEdgeInsetsZero];
    }
     _tableView.tableFooterView = [[UIView alloc] init];
    [self.view addSubview:_tableView];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (!_select) {
        return 90;
    }
    return 100;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (!_select) {
        return _restArr.count;
    }
    return _foodArr.count;
//    return 2;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_select == 0) {
        static NSString *cellName = @"RestaurCell";
        RestaurCell *cell = [tableView dequeueReusableCellWithIdentifier:cellName];
        if (nil == cell) {
            cell = [[RestaurCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            [cell.favoriteButton addTarget:self
                                    action:@selector(restClick:)
                          forControlEvents:UIControlEventTouchUpInside];
            
        }
        
        RestaurInfo * info = _restArr[indexPath.row];
        cell.favoriteButton.indexPath = indexPath;
        cell.favoriteButton.site_id = info.restaurID;
        cell.favoriteButton.selected = YES;
        cell.restaurNameLabel.text = info.restaurName;
        cell.stars = info.stars;
        cell.reviewsLabel.text = [NSString stringWithFormat:@"(%@)",info.reviews];
        cell.sellCopiesLable.text = [NSString stringWithFormat:@"月售%@份",info.monthlySales];
        cell.percapitaExpenseLabel.text = [NSString stringWithFormat:@"人均：%@",info.percapita];
        cell.freightLabel.text = [NSString stringWithFormat:@"起送价：%.2f",info.minPrice.floatValue];
        cell.freightTimeLabel.text = [NSString stringWithFormat:@"送餐时间:%@",info.freightTime];
        cell.cuisineLabel.text = [NSString stringWithFormat:@"菜系：%@",info.cuisine];
        cell.couponTipsLabel.text = [NSString stringWithFormat:@"优惠/提醒:%@",info.couponTips];
        [GCDServer setImageWithUrl:[NSString stringWithFormat:@"http://dingcan.viewcreator3d.cn%@",info.restaurIcon] view:cell.iconImageView];
        
        return cell;
    } else if (_select == 1){
        static NSString * cellId = @"FoodCell";
        FoodCell * cell = [tableView dequeueReusableCellWithIdentifier:cellId];
        if (cell == nil) {
            cell = [[[NSBundle mainBundle] loadNibNamed:cellId owner:self options:nil] lastObject];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            [cell.foodFavoriteBtn addTarget:self
                                    action:@selector(foodClick:)
                          forControlEvents:UIControlEventTouchUpInside];
            [cell.foodFavoriteBtn setImage:[UIImage imageNamed:@"restaur_favorite_unselected.png"]
                                  forState:UIControlStateNormal];
            [cell.foodFavoriteBtn setImage:[UIImage imageNamed:@"restaur_favorite_selected.png"]
                                  forState:UIControlStateSelected];
            cell.foodAddBtn.tag = TAG_MIN + 100;
            cell.foodMinusBtn.tag = TAG_MIN + 101;
            [cell.foodAddBtn addTarget:self
                                action:@selector(changeCopies:)
                      forControlEvents:UIControlEventTouchUpInside];
            [cell.foodMinusBtn addTarget:self
                                  action:@selector(changeCopies:)
                        forControlEvents:UIControlEventTouchUpInside];
        }
        FoodInfo * info = _foodArr[indexPath.row];
        cell.foodFavoriteBtn.indexPath = indexPath;
        cell.foodFavoriteBtn.site_id = info.foodID;
        cell.foodFavoriteBtn.selected = info.favorite;
        cell.foodNameLabel.text = info.foodName;
        cell.foodAddBtn.indexPath = indexPath;
        cell.foodMinusBtn.indexPath = indexPath;
//        cell.foodPraisesLabel.text = [NSString stringWithFormat:@"%@",info.sales];
//        cell.foodPriceLabel.text = info.price;
        [GCDServer setImageWithUrl:[NSString stringWithFormat:@"http://dingcan.viewcreator3d.cn%@",info.foodIcon] view:cell.foodIconImgView];
        cell.foodPriceLabel.text = [NSString stringWithFormat:@"$%@/份",info.price];
        cell.starsView.stars = info.stars;
        cell.foodPraisesLabel.text = [NSString stringWithFormat:@"%@人点过",info.sales];
        cell.foodCopiesLabel.hidden = !(BOOL)info.copies;
        cell.foodCopiesLabel.text = [NSString stringWithFormat:@"%d",info.copies];
        cell.foodMinusBtn.hidden = !(BOOL)info.copies;
        return cell;
    }

    return nil;
    
    
}
- (void)restClick:(VCButton *)btn
{
    path = [NSString stringWithFormat:@"%@/%@/store_id/%@/user_id/%@",DIANCAN_VIEW1,(btn.selected ? @"del_collect_store" : @"collect_store"),btn.site_id,_info.userID];
    [GCDServer serverWithUrl:path complete:^(NSData * data) {
        NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        if ([dict[@"status"] isEqualToNumber:@1]) {
            [SVProgressHUD showSuccessWithStatus:dict[@"msg"]];
            btn.selected = !btn.selected;
            
        } else {
            [SVProgressHUD showErrorWithStatus:dict[@"msg"]];
        }
    }];
}
- (void)foodClick:(VCButton *)btn
{
    path = [NSString stringWithFormat:@"%@/%@/goods_id/%@/user_id/%@",DIANCAN_VIEW1,(btn.selected ? @"del_collect_goods" : @"collect_goods"),btn.site_id,_info.userID];
    [GCDServer serverWithUrl:path complete:^(NSData * data) {
        NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        if ([dict[@"status"] isEqualToNumber:@1]) {
            [SVProgressHUD showSuccessWithStatus:dict[@"msg"]];
            btn.selected = !btn.selected;
        } else {
            [SVProgressHUD showErrorWithStatus:dict[@"msg"]];
        }
    }];

}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (_select == 0) {
        RestaurInfo * info = _restArr[indexPath.row];
        FoodListViewController *flVC = [[FoodListViewController alloc] init];
        flVC.restInfo = info;
        [self.navigationController pushViewController:flVC animated:YES];
    }
}
- (void)setSelect
{
    NSArray * arr = @[@"收藏的店铺",@"收藏的美食"];
    for (int i = 0; i < 2; i++) {
        UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(160*i, 64, 160, 45);
        [button setBackgroundColor:[UIColor colorWithWhite:0.2 alpha:1]];
        [button setTitle:arr[i] forState:UIControlStateNormal];
        button.tag = 10+i;
        [button addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:button];
    }
    
    _line = [[UIView alloc] initWithFrame:CGRectMake(0, 104, 160, 5)];
    _line.backgroundColor = [UIColor redColor];
    [self.view addSubview:_line];
    
}
- (void)btnClick:(UIButton *)button
{
    if (_select == button.tag - 10) {
        return;
    }
    _select = button.tag - 10;
    _line.frame = CGRectMake(160*_select, 104, 160, 5);
    
    if (_select == 0) {
        _tableView.frame = CGRectMake(0, 110, 320, SELF_VIEW_HEIGHT-110);
        self.carView.hidden = YES;
        [self initRestArr];
    } else {
        _tableView.frame = CGRectMake(0, 110, 320, SELF_VIEW_HEIGHT-110-40);
        self.carView.hidden = NO;
        [self initFoodArr];
    }
}
- (void)createCartView
{
    CGRect frame = CGRectMake(0,
                              SELF_VIEW_HEIGHT - 40,
                              SELF_VIEW_WIDTH,
                              40);
    VCCartView *cartView = [[VCCartView alloc] initWithFrame:frame];
    [cartView.settleAccountButton addTarget:self
                                     action:@selector(settleAccount)
                           forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:cartView];
    self.carView = cartView;
    self.carView.hidden = YES;
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
//        if (alertView.tag == 500) {
//            [self presentViewController:[[BaseNavigationController alloc] initWithRootViewController:[[LoginViewController alloc] init]] animated:YES completion:nil];
//        } else if (alertView.tag == 501) {
            NSArray * arr = self.cartInfo.foodsArray;
            
            for (int i = 0; i < arr.count; i++) {
                CartFoodInfo * info = arr[i];
                path = [NSString stringWithFormat:@"%@/delcar/rec_id/%@",DIANCAN_VIEW1,info.carID];
                [GCDServer serverWithUrl:path complete:^(NSData * data) {
                    NSDictionary * dict = [JSON jsonParse:data];
                    if ([dict[@"status"] isEqualToNumber:@1]) {
                        [SVProgressHUD showSuccessWithStatus:dict[@"msg"]];
                        self.cartInfo = nil;
                        self.cartInfo = [[CartInfo alloc] init];
                        [Public sharedPublic].restInfo = nil;
                        [self initFoodArr];
                    } else {
                        [SVProgressHUD showErrorWithStatus:dict[@"msg"]];
                    }
                }];
            }
        
//        }
    }
    
}
- (void)changeCopies:(VCButton *)btn
{
    FoodInfo *foodInfo = _foodArr[btn.indexPath.row];
//    RestaurInfo * info = [Public sharedPublic].restInfo;
//    int index = [foodInfo.restaurID isEqualToString:info.restaurID];
    if ([Public sharedPublic].restInfo && ![foodInfo.restaurID isEqualToString:[Public sharedPublic].restInfo.restaurID]) {
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"购物车" message:@"清空后才能添加所点美食" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"清空", nil];
        alert.tag = 501;
        [alert show];
        return;
    }
    
    
    if (TAG_MIN + 100 == btn.tag) {
        [self addcartWithFood:foodInfo];
//        [self cartInfoChanged:foodInfo isAdd:YES];
//        [self cartArrayWith:foodInfo isAdd:YES];
        [self animation:btn];
        
    } else {
        [self deleteWithFood:foodInfo];
//        [self cartInfoChanged:foodInfo isAdd:NO];
//        [self cartArrayWith:foodInfo isAdd:NO];
//        [self cartViewChanged];
    }
//    [self.tableView reloadRowsAtIndexPaths:@[btn.indexPath] withRowAnimation:UITableViewRowAnimationNone];
}
- (void)addcartWithFood:(FoodInfo *)info
{
    if (!info.carID || info.copies == 0) {
        path = [NSString stringWithFormat:@"%@/cart/user_id/%@/session_id/%@/goods_id/%@/quantity/%d",DIANCAN_VIEW2,[Public sharedPublic].userInfo.userID,[Public getMac],info.foodID,1];
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
    if (info.copies > 1) {
        path = [NSString stringWithFormat:@"%@/editcar/rec_id/%@/quantity/%d",DIANCAN_VIEW1,info.carID,info.copies-1];
    } else {
        path = [NSString stringWithFormat:@"%@/delcar/rec_id/%@",DIANCAN_VIEW1,info.carID];
        FoodInfo * finfo = info;
        finfo.copies = 0;
        finfo.carID = nil;
        for (int i = 0; i < _foodArr.count; i++) {
            FoodInfo * foodinfo = _foodArr[i];
            if ([foodinfo.foodID isEqualToString:finfo.foodID]) {
                [_foodArr replaceObjectAtIndex:i withObject:finfo];
            }
        }
        
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



#pragma mark 改变cartInfo的总份数和总钱数

//- (void)cartInfoChanged:(CartFoodInfo *)foodInfo isAdd:(BOOL)isAdd
//{
//    self.cartInfo.totalCopies = isAdd ?
//    self.cartInfo.totalCopies + 1 :
//    self.cartInfo.totalCopies - 1;
//    
//    self.cartInfo.totalPrice = isAdd ?
//    self.cartInfo.totalPrice + foodInfo.price.floatValue :
//    self.cartInfo.totalPrice - foodInfo.price.floatValue;
//    
//}

#pragma mark 遍历cartInfo的foodsArray，做相应的操作

//- (void)cartArrayWith:(CartFoodInfo *)foodInfo isAdd:(BOOL)isAdd
//{
//    for (CartFoodInfo *food in self.cartInfo.foodsArray) {
//        if ([foodInfo.foodID isEqualToString:food.foodID]) {
//            //  对应FoodInfo对象份数+1/-1
//            food.quantity = [NSString stringWithFormat:@"%d",(isAdd ? food.quantity.intValue + 1 : food.quantity.intValue -1)];
//            if (0 == food.quantity.integerValue && !isAdd) {
//                [self.cartInfo.foodsArray removeObject:food];
//            }
//            return;
//        }
//    }
//}

#pragma mark 对底部的cartView的总份数总钱数的Label从新赋值

- (void)cartViewChanged
{
    self.carView.copiesLabel.text = [NSString stringWithFormat:@"%d份", self.cartInfo.totalCopies];
    self.carView.priceLabel.text = [NSString stringWithFormat:@"$%.2f",self.cartInfo.totalPrice];
    if (0 == self.cartInfo.totalCopies) {
        self.carView.priceLabel.text = @"$0";
    }
    
    if ([Public sharedPublic].restInfo && [Public sharedPublic].restInfo.minPrice.floatValue <= self.cartInfo.totalPrice) {
        self.carView.settleAccountButton.backgroundColor = [UIColor colorWithRed:1.00f green:0.89f blue:0.02f alpha:1.00f];
    } else {
        self.carView.settleAccountButton.backgroundColor = [UIColor grayColor];
    }
}
#pragma mark 增加份数的动画

- (void)animation:(VCButton *)btn
{
    UIWindow *keyWindow = [[UIApplication sharedApplication] keyWindow];
    
    CATextLayer *addTextLayer = [[CATextLayer alloc] init];
    addTextLayer.backgroundColor = [[UIColor clearColor] CGColor];
    [addTextLayer setFontSize:15.0f];
    addTextLayer.string = @"+1";
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
    FoodInfo *food = (FoodInfo *)[self.foodArr objectAtIndex:btn.indexPath.row];
//    [self cartViewChanged];
    
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

#pragma mark 跳转到购物车
- (void)settleAccount
{
    RestaurInfo * Pinfo = [Public sharedPublic].restInfo;
    NSLog(@"%@",[Public sharedPublic].restInfo.restaurName);
    if (Pinfo && Pinfo.minPrice.floatValue <= self.cartInfo.totalPrice) {
        CartViewController *cVC = [[CartViewController alloc] init];
        //        cVC.cartInfo = self.cartInfo;
        //        cVC.cartDelegate = self;
        [self.navigationController pushViewController:cVC animated:YES];
    } else {
        //        //  提示
        [SVProgressHUD showErrorWithStatus:@"你的订餐还不够起送底线哦" duration:0.8f];
    }
    
}
- (void)setNav
{
    [self setSliderItem];
    [self resetTitleView:@"我的收藏"];
}

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

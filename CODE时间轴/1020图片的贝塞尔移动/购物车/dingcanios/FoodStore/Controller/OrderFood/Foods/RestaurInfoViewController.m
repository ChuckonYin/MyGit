//
//  RestaurInfoViewController.m
//  FoodStore
//
//  Created by liuguopan on 14/12/31.
//  Copyright (c) 2014年 viewcreator3d. All rights reserved.
//

#import "RestaurInfoViewController.h"
#import "RestaurInfoNormalCell.h"
#import "RestaurInfoFirstCell.h"
#import "RestaurInfoThirdCell.h"

@interface RestaurInfoViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) NSArray *categoryArray;
@property (nonatomic,strong) UITableView * tableView;

@end

@implementation RestaurInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    if (IOS_VERSION >= 7.0) {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    [self initData];
    [self setNav];
    [self createTableView];
}

- (void)initData
{
    NSArray *categoryArray = [[NSArray alloc] initWithObjects:@"Null", @"餐厅公告", @"餐厅活动", @"餐厅风格", @"餐厅简介", @"营业时间", @"餐厅地址", nil];
  //@[@"Null", @"餐厅公告", @"餐厅活动", @"餐厅风格", @"餐厅简介", @"营业时间", @"餐厅地址"];
    self.categoryArray = categoryArray;
}

- (void)setNav
{
    [self resetTitleView:self.restInfo.restaurName];
    [self setBackItem:@selector(backPop)];
}

- (void)createTableView
{
    CGRect frame = CGRectMake(0, SELF_VIEW_ORIGIN_Y, SELF_VIEW_WIDTH, SELF_VIEW_HEIGHT - SELF_VIEW_ORIGIN_Y);
    UITableView *restaurInfoTableView = [[UITableView alloc] initWithFrame:frame style:UITableViewStylePlain];
    restaurInfoTableView.contentInset = UIEdgeInsetsMake(5.0f, 0, 5.0f, 0);
    restaurInfoTableView.backgroundColor = [UIColor colorWithRed:0.92f green:0.92f blue:0.94f alpha:1.00f];
    restaurInfoTableView.showsVerticalScrollIndicator = NO;
    restaurInfoTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    restaurInfoTableView.dataSource = self;
    restaurInfoTableView.delegate = self;
    [self.view addSubview:restaurInfoTableView];
    self.tableView = restaurInfoTableView;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 7;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (0 == indexPath.section/* || 2 == indexPath.section*/) {
        return 113.0f;
    }
//    else if (indexPath.section == 4) {
//        return [self sizeWithStr:self.restInfo.brief]+30;
//    }
    return 60.0f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (0 == indexPath.section) {
        static NSString *cellName_0 = @"RestaurInfoFirstCell";
        RestaurInfoFirstCell *cell = [tableView dequeueReusableCellWithIdentifier:cellName_0];
        if (nil == cell) {
            cell = [[[NSBundle mainBundle] loadNibNamed:cellName_0 owner:self options:nil] lastObject];
        }

        [GCDServer setImageWithUrl:[NSString stringWithFormat:@"http://dingcan.viewcreator3d.cn%@",self.restInfo.restaurIcon] view:cell.RestaurIconImgView];
        [cell.favBtn addTarget:self action:@selector(favClick) forControlEvents:UIControlEventTouchUpInside];
        [cell.favBtn setTitle:(self.restInfo.favorite?@"取消收藏":@"收藏") forState:UIControlStateNormal];
        cell.restaurNameLabel.text = self.restInfo.restaurName;
        cell.pingfenLabel.text = [NSString stringWithFormat:@"%d",self.restInfo.stars];
        cell.shijianLabel.text = self.restInfo.freightTime;
        cell.qisongjiaLabel.text = self.restInfo.minPrice;
        cell.peisongfeiLabel.text = self.restInfo.freight;
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell;
    }
//    else if (2 == indexPath.section) {
//        static NSString *cellName_2 = @"RestaurInfoThirdCell";
//        RestaurInfoThirdCell *cell = [tableView dequeueReusableCellWithIdentifier:cellName_2];
//        if (nil == cell) {
//            cell = [[[NSBundle mainBundle] loadNibNamed:cellName_2 owner:self options:nil] lastObject];
//        }
//        cell.huodongLabel.text = self.restInfo.activities;
//        return cell;
//    }
    else {
        static NSString *cellName = @"RestaurInfoNormalCell";
        RestaurInfoNormalCell *cell = [tableView dequeueReusableCellWithIdentifier:cellName];
        if (nil == cell) {
            cell = [[[NSBundle mainBundle] loadNibNamed:cellName owner:self options:nil] lastObject];
            cell.contentLabel.text = @"";
        }
        switch (indexPath.section) {
            case 1:
                cell.contentLabel.text = self.restInfo.gonggao;
                break;
            case 2:
                cell.contentLabel.text = self.restInfo.activities;
                break;
            case 3:
                cell.contentLabel.text = self.restInfo.style;
                break;
            case 4:
                cell.contentLabel.text = self.restInfo.brief;
//                cell.contentLabel.frame = CGRectMake(0, 30, 300, [self sizeWithStr:self.restInfo.brief]);
//                cell.contentLabel.numberOfLines = 10;
                break;
            case 5:
                cell.contentLabel.text = self.restInfo.shopHours;
                break;
            case 6:
                cell.contentLabel.text = self.restInfo.address;
                break;
            default:
                break;
        }
        cell.titleLabel.text = [self.categoryArray objectAtIndex:indexPath.section];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
}
- (float)sizeWithStr:(NSString *)str
{
    NSDictionary * attribute  = @{NSFontAttributeName: [UIFont systemFontOfSize:12]};
    CGSize size ;
    if (IOS_VERSION>7.0) {
        size = [str boundingRectWithSize:CGSizeMake(300,0) options: NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attribute context:nil].size;
    } else {
        size = [str sizeWithFont:[UIFont systemFontOfSize:12] constrainedToSize:CGSizeMake(300, CGFLOAT_MAX) lineBreakMode:NSLineBreakByWordWrapping];
    }
    
    return size.height;
}

- (void)favClick
{
    if ([Public sharedPublic].userInfo.userID == nil) {
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"登陆后可收藏餐厅" message:nil delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
        [alert show];
        return;
    }

//    if (self.restInfo.favorite) {
//        [SVProgressHUD showSuccessWithStatus:@"你已收藏"];
//    } else {
    NSString * path = [NSString stringWithFormat:@"%@/%@/store_id/%@/user_id/%@",DIANCAN_VIEW1,(self.restInfo.favorite ? @"del_collect_store" : @"collect_store"),self.restInfo.restaurID,[Public sharedPublic].userInfo.userID];
//        NSString * path = [NSString stringWithFormat:@"%@/collect_store/store_id/%@/user_id/%@",DIANCAN_VIEW1,self.restInfo.restaurID,[Public sharedPublic].userInfo.userID];
        [GCDServer serverWithUrl:path complete:^(NSData * data) {
            NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            if ([dict[@"status"] isEqualToNumber:@1]) {
                [SVProgressHUD showSuccessWithStatus:dict[@"msg"]];
                self.restInfo.favorite = !self.restInfo.favorite;
                [self.tableView reloadData];
            } else {
                [SVProgressHUD showErrorWithStatus:dict[@"msg"]];
            }
        }];
//    }
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

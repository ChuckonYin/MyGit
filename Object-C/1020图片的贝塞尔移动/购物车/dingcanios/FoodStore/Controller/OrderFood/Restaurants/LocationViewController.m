//
//  LocationViewController.m
//  FoodStore
//
//  Created by liuguopan on 14/12/25.
//  Copyright (c) 2014年 viewcreator3d. All rights reserved.
//

#import "LocationViewController.h"
#import "CustomViewController.h"
#import "JSON.h"
#import "Model.h"

@interface LocationViewController () <UITextFieldDelegate,UITableViewDataSource,UITableViewDelegate,CustomVCDelegate>
{
    UITextField * _textField;
    UILabel * _label;
    UISwitch * _switch;
    NSArray * _dataArr;
    UIScrollView * _scrollView;
    UITableView * _tableView;
    NSInteger _select;
    UIView *_coverView;
    UITableView *_searchTableView;
    NSMutableArray *_searchDataArr;
    NSString *_searchText;
    int count;
}
@end

@implementation LocationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setNav];
    [self initData];
    [self initView];
}
- (void)initData
{
//    _dataArr = @[@"伦敦城购物中心",@"威尔士购物中心",@"苏格兰购物中心",@"伦敦城购物中心",@"伯明翰购物中心"];
    _dataArr = [CustomViewController sharedCustom].dataArr;
    _searchDataArr = [[NSMutableArray alloc] initWithCapacity:0];
    _select = -1;
}
- (void)initView
{
    self.view.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1];
    [self setImg1];
    [self setImg2];
    [self setLabel];
    [self setTable];
    [self setCoverView];
}

- (void)download:(NSString *)url
{
    //
//    if (count > 2) {
//        count = 0;
//        return;
//    }
    NSString *str = [NSString stringWithFormat:@"http://api.map.baidu.com/place/v2/search?query=%@&region=%@&output=json&ak=gGmhaPdNEKlOCynIGR2EbGPf&page_size=10&page_num=%d",_textField.text,[CustomViewController sharedCustom].placemark.administrativeArea,count];
    
    [GCDServer serverWithUrl:str
                   complete:^(NSData *data) {
                       LOG(str);LOG(data);
                       NSMutableArray * arr = [JSON getSearchInfo:data];
                       if (arr && ((_searchDataArr.count && arr.count > 1 )|| !_searchDataArr.count)) {
                           for (SearchInfo * info in arr) {
                               [_searchDataArr addObject:info];
                           }
                           _coverView.backgroundColor = [UIColor lightGrayColor];
                           [_searchTableView reloadData];
//                           if (count < 2) {
//                               [self download:nil];
//                           }
                           
                       }
//                       else {
//                           _coverView.hidden = YES;
//                       }
//                       if (count < 2) {
//                           count ++;
//                       } else{
//                           count = 0;
//                       }
    }error:^(NSError *error) {
//        _coverView.hidden = YES;
    }];
}

- (void)setCoverView
{
    _coverView = [[UIView alloc] init];
    _coverView.frame = CGRectMake(0, SELF_VIEW_ORIGIN_Y, SELF_VIEW_WIDTH, SELF_VIEW_HEIGHT - SELF_VIEW_ORIGIN_Y);
//    _coverView.frame = CGRectMake(0, 64, SELF_VIEW_WIDTH, SELF_VIEW_HEIGHT - 64);
    _coverView.backgroundColor = [UIColor colorWithWhite:0.0f alpha:0.4f];
    [self.view addSubview:_coverView];
    [self setSearchTableView];
    
    _coverView.hidden = YES;
}

- (void)setSearchTableView
{
    _searchTableView = [[UITableView alloc] initWithFrame:_coverView.bounds style:UITableViewStylePlain];
    _searchTableView.tag = TAG_MIN + 1;
    _searchTableView.delegate = self;
    _searchTableView.dataSource = self;
    if (IOS_VERSION >= 7.0f) {
        [_searchTableView setSeparatorInset:UIEdgeInsetsZero];
    }
//    _searchTableView.bounces = NO;
    _searchTableView.backgroundColor = [UIColor whiteColor];
    _searchTableView.tableFooterView = [[UIView alloc] init];
    [_coverView addSubview:_searchTableView];
}

- (void)setTable
{
    UILabel * headL = [[UILabel alloc] initWithFrame:CGRectMake(10, 200, 300, 40)];
    headL.text = @"  历史位置";
    headL.backgroundColor = [UIColor whiteColor];
    headL.font = [UIFont systemFontOfSize:20];
    [self.view addSubview:headL];
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(10, 241, 300, SELF_VIEW_HEIGHT-241) style:UITableViewStylePlain];
    _tableView.tag = TAG_MIN;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = [UIColor clearColor];
    if (IOS_VERSION>=7.0) {
        [_tableView setSeparatorInset:UIEdgeInsetsZero];
    }
    _tableView.tableFooterView = [[UIView alloc] init];
    [self.view addSubview:_tableView];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (TAG_MIN == tableView.tag) {
        return _dataArr.count;
    } else if (TAG_MIN + 1 == tableView.tag) {
//        return 10;
        return _searchDataArr.count;
    }
    return 0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (TAG_MIN == tableView.tag) {
        static NSString * cellId = @"cell";
        UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellId];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        }
        cell.textLabel.text = _dataArr[indexPath.row];
        cell.textLabel.font = [UIFont systemFontOfSize:16];
        cell.textLabel.numberOfLines = 2;
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
        return cell;
    } else if (TAG_MIN + 1 == tableView.tag) {
        static NSString * cellId = @"searchCell";
        UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellId];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellId];
//            cell.backgroundColor = [UIColor lightGrayColor];
        }
        SearchInfo *searchInfo = (SearchInfo *)[_searchDataArr objectAtIndex:indexPath.row];
        cell.textLabel.text = searchInfo.name;
        cell.detailTextLabel.text = searchInfo.address;
        return cell;
    }
    return nil;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (TAG_MIN == tableView.tag) {
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        _select = indexPath.row;
        [self addressWithPath:_dataArr[_select]];
//        [_delegate changeLocation:_dataArr[_select]];
    } else if (TAG_MIN + 1 == tableView.tag) {
        SearchInfo * info = _searchDataArr[indexPath.row];
        NSString * string = (info.address)? info.address : info.name;
        [self addressWithPath:string];
//        [_delegate changeLocation:info.name];
    }
    [self backDismiss];
}
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if ((scrollView.contentOffset.y + scrollView.frame.size.height>scrollView.contentSize.height)&& TAG_MIN + 1 == scrollView.tag)
    {
        count ++;
        [self download:nil];
    }
}


- (void)setImg1
{
    UIImageView * img = [[UIImageView alloc] initWithFrame:CGRectMake(10, 70, 300, 40)];
    img.backgroundColor = [UIColor whiteColor];
    img.userInteractionEnabled = YES;
    [self.view addSubview:img];
    
    _label = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, 230, 30)];
    _label.text = @"定位到当前位置";
    _label.userInteractionEnabled = YES;
    _label.textColor = [UIColor orangeColor];
    [img addSubview:_label];
    
    UILabel * right = [[UILabel alloc] initWithFrame:CGRectMake(250, 0, 40, 40)];
    right.text = @"◉@";
    right.userInteractionEnabled = YES;
    right.font = [UIFont systemFontOfSize:20];
    right.textAlignment = NSTextAlignmentRight;
    [img addSubview:right];
    
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap1)];
    [right addGestureRecognizer:tap];
    
    UITapGestureRecognizer * tapL = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapL)];
    [_label addGestureRecognizer:tapL];
    
    [CustomViewController sharedCustom].delegate = self;

}
- (void)tap1
{
    if (NotNetworkStatu == [Public sharedPublic].networkState) {
        [SVProgressHUD showErrorWithStatus:@"获取地址失败，请重试"];
        return;
    }
    [[CustomViewController sharedCustom] location];
}
- (void)tapL
{
    if (![_label.text isEqualToString:@"定位到当前位置"]) {
        [_delegate changeLocation:_label.text];
        [super backDismiss];
    }
}
- (void)locationWithData:(NSString *)place
{
    _label.text = place;
}
- (void)swth:(UISwitch *)s
{
    [CustomViewController sharedCustom].isOpen = s.isOn;
    
}
- (void)setImg2
{
    UIImageView * img = [[UIImageView alloc] initWithFrame:CGRectMake(10, 120, 300, 40)];
    img.backgroundColor = [UIColor whiteColor];
    img.userInteractionEnabled = YES;
    [self.view addSubview:img];
    
    UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, 150, 30)];
    label.text = @"自动定位";
    [img addSubview:label];
    
    _switch = [[UISwitch alloc] initWithFrame:CGRectMake(240, 5, 51, 30)];
    _switch.on = [CustomViewController sharedCustom].isOpen;
    [_switch addTarget:self action:@selector(swth:) forControlEvents:UIControlEventValueChanged];
    [img addSubview:_switch];
}
- (void)setLabel
{
    UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(15, 165, 280, 30)];
    label.text = @"关闭自动定位后，每次打开应用默认使用上一次位置";
    label.textColor = [UIColor blackColor];
    label.font = [UIFont systemFontOfSize:12];
    [self.view addSubview:label];
}
- (void)setNav
{
    [self setBackItem:@selector(backDismiss)];
    [self setRightItem:@"搜索" sel:@selector(searchBtnClick)];
    [self setTextField];
}
//- (void)backDismiss
//{
//    if (_select > -1) {
////        [[CustomViewController sharedCustom] addressWithPath:_dataArr[_select]];
////        [_delegate changeLocation:_dataArr[_select]];
//        [self addressWithPath:_dataArr[_select]];
//    } else if (_textField.text.length) {
////        [[CustomViewController sharedCustom] addressWithPath:_textField.text];
//        [self addressWithPath:_textField.text];
//    }
//    [super backDismiss];
//}

- (void)searchBtnClick
{
    [_searchDataArr removeAllObjects];
    [_searchTableView reloadData];
    count = 0;
    if (_textField.text.length) {
        _coverView.hidden = NO;
        [self download:nil];
    } else {
        _coverView.hidden = YES;
    }
    
    [_textField resignFirstResponder];
}

- (void)addressWithPath:(NSString *)path
{
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    [geocoder geocodeAddressString:path completionHandler:^(NSArray *placemarks, NSError *error) {
        CLPlacemark * placemark = placemarks[0];
        CLLocationCoordinate2D coordinate=placemark.location.coordinate;
        NSString *strCoordinate=[NSString stringWithFormat:@"经度:%3.5f \n纬度:%3.5f",coordinate.latitude,coordinate.longitude];
        NSLog(@"%@",strCoordinate);
        if (coordinate.latitude && coordinate.longitude) {
            [CustomViewController sharedCustom].coordinate = coordinate;
            [CustomViewController sharedCustom].lastPlace = path;
            [[CustomViewController sharedCustom] initDataArr];
            [_delegate changeLocation:path];
        }
        
    }];
}
- (void)setTextField
{
    _textField = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, 200, 30)];
    _textField.placeholder = @"输入地址";
    _textField.delegate = self;
    _textField.backgroundColor = [UIColor whiteColor];
    _textField.borderStyle = UITextBorderStyleRoundedRect;
    _textField.secureTextEntry = NO;
    _textField.returnKeyType = UIReturnKeyDone;
    _textField.clearButtonMode = UITextFieldViewModeAlways;
    _textField.keyboardAppearance = UIKeyboardAppearanceDefault;
//    _textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.navigationItem.titleView = _textField;
}

//- (void)textFieldDidBeginEditing:(UITextField *)textField
//{
//    
//}


- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    _coverView.hidden = NO;
    _coverView.backgroundColor = [UIColor colorWithWhite:0.0f alpha:0.4f];
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    _searchText = textField.text;

    return YES;
}
//- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
//{
//    [self down];
//    return YES;
//}
//- (void)down
//{
//    NSString *str = @"http://api.map.baidu.com/place/v2/suggestion?"
//    @"query=华联"
//    @"&region=131"
//    @"&output=json"
//    @"&ak=gGmhaPdNEKlOCynIGR2EbGPf";
//    [GCDServer serverWithUrl:str complete:^(NSData * data) {
//        NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:Nil];
//        NSLog(@"%@",dict);
//    }];
//}
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

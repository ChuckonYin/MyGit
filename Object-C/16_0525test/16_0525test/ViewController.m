//
//  ViewController.m
//  16_0525test
//
//  Created by ChuckonYin on 16/5/25.
//  Copyright © 2016年 pinAn.com. All rights reserved.
//

#import "ViewController.h"

#define kScreenWidth [[UIScreen mainScreen] bounds].size.width
#define kScreenHeight [[UIScreen mainScreen] bounds].size.height

#define upHeight 300.0f

@interface ViewController ()<UIScrollViewDelegate, UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UIScrollView *scroll1;

@property (nonatomic, strong) UIScrollView *scroll2;

@property (nonatomic, strong) UIView *upView;

@property (nonatomic, strong) UIView *downVeiw;

@property (nonatomic, strong) UIView *header;

@property (nonatomic, assign) BOOL isExpand;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.scroll1];
    [self.view addSubview:self.scroll2];
    
    [self.scroll1 addSubview:self.upView];
    [self.scroll2 addSubview:self.downVeiw];
}

- (UIScrollView *)scroll1{
    if (!_scroll1) {
        _scroll1 = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    }
    return _scroll1;
}

- (UIScrollView *)scroll2{
    if (!_scroll2) {
        _scroll2 = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) style:UITableViewStyleGrouped];
        _scroll2.contentSize = CGSizeMake(0, 2*kScreenHeight);
        _scroll2.delegate = self;
        _scroll2.backgroundColor = [UIColor clearColor];
    }
    return _scroll2;
}

- (UIView *)upView{
    if (!_upView) {
        _upView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, upHeight)];
        _upView.backgroundColor = [UIColor yellowColor];
        _upView.layer.contents = (id)([UIImage imageNamed:@"1.jpg"].CGImage);
    }
    return _upView;
}

- (UIView *)downVeiw{
    if (!_downVeiw) {
        _downVeiw = [[UIView alloc] initWithFrame:CGRectMake(0, upHeight-50, kScreenWidth, kScreenHeight - upHeight+50)];
        _downVeiw.backgroundColor = [UIColor redColor];
        [_downVeiw addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(expand)]];
    }
    return _downVeiw;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
//    if (!scrollView.isTracking) return;
    if (self.scroll2.contentOffset.y>0) return;
    self.scroll1.contentOffset = CGPointMake(0, self.scroll2.contentOffset.y);
}

- (void)expand{
     [UIView animateWithDuration:0.25 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
         if(self.downVeiw.transform.ty>5){
             self.downVeiw.transform = CGAffineTransformMakeTranslation(0, 0);
         }
         else{
             self.downVeiw.transform = CGAffineTransformMakeTranslation(0, 50);
         }
     } completion:^(BOOL finished) {
         
     }];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellid"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    self.isExpand = !self.isExpand;
    [self expand];
}

- (UIView *)header{
    if (!_header) {
        _header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, upHeight-50)];
    }
    return _header;
}

@end








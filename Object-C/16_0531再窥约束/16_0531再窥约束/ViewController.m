//
//  ViewController.m
//  16_0531再窥约束
//
//  Created by apple on 16/5/31.
//  Copyright © 2016年 pinAn.com. All rights reserved.
//

#import "ViewController.h"
#import "Masonry.h"
#import "ViewController1.h"
#import "PopView.h"

#define kScreenWidth [[UIScreen mainScreen] bounds].size.width

@interface ViewController ()

@property (nonatomic, strong) UIView *customView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  
//    [self.view addSubview:self.customView];
//    
//    [self.customView mas_updateConstraints:^(MASConstraintMaker *make) {
//        make.bottom.equalTo(self.view);
//    }];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [PopView showCustomView:self.customView onView:self.view];
    });
    
    UILabel *label1 = [[UILabel alloc] init];
    label1.adjustsFontSizeToFitWidth = YES;
    label1.text = @"人生若只如初见人生若只如初见";
    label1.numberOfLines = 1;
    [self.view addSubview:label1];
    UILabel *label2 = [[UILabel alloc] init];
    label1.adjustsFontSizeToFitWidth = YES;
    label2.text = @"人生若只如初见";
    label2.numberOfLines = 1;
    [self.view addSubview:label2];
    UILabel *label3 = [[UILabel alloc] init];
    label1.adjustsFontSizeToFitWidth = YES;
    label3.text = @"人生若只如初见";
    label3.numberOfLines = 1;
    [self.view addSubview:label3];
    
    [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view);
        make.top.equalTo(self.view);
    }];
    [label2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(label1.mas_right).offset(10);
        make.top.equalTo(self.view);
    }];
    [label3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(label2.mas_right).offset(10);
        make.top.equalTo(self.view);
        make.right.equalTo(self.view);
    }];
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectZero];
    btn.backgroundColor = [UIColor yellowColor];
    [btn setTitle:@"按钮" forState:UIControlStateNormal];
    [self.view addSubview:btn];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
    }];
    
}

- (UIView *)customView{
    if (!_customView) {
        
        _customView = [[UIView alloc] init];
        _customView.backgroundColor = [UIColor lightGrayColor];
        
        UILabel *titleLabel = [[UILabel alloc] init];
        titleLabel.backgroundColor = [UIColor yellowColor];
        titleLabel.text = @"标题";
        [_customView addSubview:titleLabel];
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_customView);
            make.centerX.equalTo(_customView);
        }];
        
        UILabel *contentLabel = [[UILabel alloc] init];
        contentLabel.textAlignment = NSTextAlignmentCenter;
        contentLabel.numberOfLines = 0;
        contentLabel.backgroundColor = [UIColor redColor];
        contentLabel.text = @"人生若只如初见，何事秋风悲画扇。\n等闲变却故人心，却道故人心易变。\n骊山语罢清宵半，泪雨霖铃终不怨。\n何如薄幸锦衣郎，比翼连枝当日愿。";
        [_customView addSubview:contentLabel];
        [contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(_customView);
            make.top.equalTo(titleLabel.mas_bottom).offset(5);
            make.left.equalTo(_customView).offset(10);
            make.right.equalTo(_customView).offset(-10);
        }];
        
        [_customView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(kScreenWidth);
            make.bottom.equalTo(contentLabel.mas_bottom).offset(30);
        }];
    }
    return _customView;
}

@end




